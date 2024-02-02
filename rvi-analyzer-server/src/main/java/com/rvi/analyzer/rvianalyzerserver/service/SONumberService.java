package com.rvi.analyzer.rvianalyzerserver.service;

import com.rvi.analyzer.rvianalyzerserver.domain.*;
import com.rvi.analyzer.rvianalyzerserver.dto.CustomerPODto;
import com.rvi.analyzer.rvianalyzerserver.dto.SONumberDto;
import com.rvi.analyzer.rvianalyzerserver.entiy.SONumber;
import com.rvi.analyzer.rvianalyzerserver.mappers.CustomerPOMapper;
import com.rvi.analyzer.rvianalyzerserver.mappers.SONumberMapper;
import com.rvi.analyzer.rvianalyzerserver.mappers.StyleMapper;
import com.rvi.analyzer.rvianalyzerserver.repository.CustomerPORepository;
import com.rvi.analyzer.rvianalyzerserver.repository.SONumberRepository;
import com.rvi.analyzer.rvianalyzerserver.repository.StyleRepository;
import com.rvi.analyzer.rvianalyzerserver.repository.UserRepository;
import com.rvi.analyzer.rvianalyzerserver.security.JwtUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Mono;

import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
@Slf4j
public class SONumberService {
    final private SONumberRepository soNumberRepository;
    final private UserRepository userRepository;
    final private SONumberMapper soNumberMapper;
    final private JwtUtils jwtUtils;
    final private UserGroupRoleService userGroupRoleService;

    public Mono<NewSONumberResponse> addSONumber(SONumberDto soNumberDto, String jwt) {
        return Mono.just(soNumberDto)
                .doOnNext(soNumberDto1 -> log.info("SO Number add request received [{}]", soNumberDto1))
                .flatMap(request -> soNumberRepository.findBySONumber(request.getSoNumber()))
                .flatMap(soNumber -> Mono.just(NewSONumberResponse.builder()
                        .status("E1002")
                        .statusDescription("SO Number Already exists")
                        .build()))
                .switchIfEmpty(
                        createSONumber(soNumberDto, jwtUtils.getUsername(jwt))
                )
                .doOnError(e ->
                        NewSONumberResponse.builder()
                                .status("E1000")
                                .statusDescription("Failed")
                                .build());
    }

    private Mono<NewSONumberResponse> createSONumber(SONumberDto soNumberDto, String username) {
        return userRepository.findByUsername(username)
                .flatMap(creatingStyle -> userGroupRoleService.getUserRolesByUserGroup(creatingStyle.getGroup())
                        .flatMap(userRoles -> {
                            log.info(soNumberDto.getSoNumber());
                            if (userRoles.contains(UserRoles.CREATE_SO_NUMBER)) {
                                return save(soNumberDto, username);
                            } else {
                                return Mono.just(NewSONumberResponse.builder()
                                        .status("E1200")
                                        .statusDescription("You are not authorized to use this service").build());
                            }
                        }));
    }

    private Mono<NewSONumberResponse> save(SONumberDto soNumberDto, String username) {
        return Mono.just(soNumberDto)
                .map(soNumberDto1 -> {
                    return SONumber.builder()
                            .soNumber(soNumberDto.getSoNumber())
                            .customerPO(soNumberDto.getCustomerPO())
                            .createdBy(username)
                            .createdDateTime(LocalDateTime.now())
                            .build();
                })
                .doOnNext(soNumber -> {
                    soNumber.setSoNumber(soNumber.getSoNumber());
                    soNumber.setCustomerPO(soNumber.getCustomerPO() != null ? soNumber.getCustomerPO() : "UN-ASSIGNED");
                    soNumber.setCreatedBy(username);
                    soNumber.setCreatedDateTime(LocalDateTime.now());
                })
                .flatMap(soNumberRepository::insert)
                .doOnSuccess(soNumber -> log.info("Successfully saved the SO number [{}]", soNumber))
                .map(soNumber -> NewSONumberResponse.builder()
                        .status("S1000")
                        .statusDescription("Success")
                        .number(soNumber.getSoNumber())
                        .build());
    }

    public Mono<ResponseEntity<SONumberResponse>> getSONumbers(String auth) {
        log.info("get so numbers request received with jwt [{}]", auth);
        return userRepository.findByUsername(jwtUtils.getUsername(auth))
                .flatMap(requestedUser -> userGroupRoleService.getUserRolesByUserGroup(requestedUser.getGroup())
                        .flatMap(userRoles -> {
                            if (userRoles.contains(UserRoles.GET_ALL_SO_NUMBER)) {
                                return soNumberRepository.findAll()
                                        .map(soNumber -> {
                                            return SONumberDto.builder()
                                                    ._id(soNumber.get_id())
                                                    .soNumber(soNumber.getSoNumber())
                                                    .customerPO(soNumber.getCustomerPO())
                                                    .createdBy(soNumber.getCreatedBy())
                                                    .createdDateTime(soNumber.getCreatedDateTime())
                                                    .build();
                                        })
                                        .collectList()
                                        .flatMap(soNumberDtos -> Mono.just(ResponseEntity.ok(SONumberResponse.builder()
                                                .status("S1000")
                                                .statusDescription("Success")
                                                .soNumbers(soNumberDtos)
                                                .build()
                                        )));
                            } else {
                                return Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(SONumberResponse.builder()
                                        .status("E1200")
                                        .statusDescription("You are not authorized to use this service").build()));
                            }
                        })
                )
                .switchIfEmpty(Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(SONumberResponse.builder()
                        .status("E1000")
                        .statusDescription("Failed").build())));
    }
}
