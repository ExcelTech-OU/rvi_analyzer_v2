package com.rvi.analyzer.rvianalyzerserver.service;

import com.rvi.analyzer.rvianalyzerserver.domain.*;
import com.rvi.analyzer.rvianalyzerserver.dto.CustomerPODto;
import com.rvi.analyzer.rvianalyzerserver.dto.MaterialDto;
import com.rvi.analyzer.rvianalyzerserver.mappers.CustomerPOMapper;
import com.rvi.analyzer.rvianalyzerserver.mappers.StyleMapper;
import com.rvi.analyzer.rvianalyzerserver.repository.CustomerPORepository;
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
public class CustomerPOService {
    final private CustomerPORepository customerPORepository;
    final private UserRepository userRepository;
    final private CustomerPOMapper customerPOMapper;
    final private JwtUtils jwtUtils;
    final private UserGroupRoleService userGroupRoleService;
    final private MaterialService materialService;

    public Mono<NewCustomerPOResponse> addCustomerPO(CustomerPODto customerPODto, String jwt) {
        return Mono.just(customerPODto)
                .doOnNext(customerPODto1 -> log.info("Customer PO add request received [{}]", customerPODto1))
                .flatMap(request -> customerPORepository.findByName(request.getName()))
                .flatMap(style -> Mono.just(NewCustomerPOResponse.builder()
                        .status("E1002")
                        .statusDescription("Customer PO Already exists")
                        .build()))
                .switchIfEmpty(
                        createCustomerPO(customerPODto, jwtUtils.getUsername(jwt))
                )
                .doOnError(e ->
                        NewCustomerPOResponse.builder()
                                .status("E1000")
                                .statusDescription("Failed")
                                .build());
    }

    private Mono<NewCustomerPOResponse> createCustomerPO(CustomerPODto customerPODto, String username) {
        return userRepository.findByUsername(username)
                .flatMap(creatingStyle -> userGroupRoleService.getUserRolesByUserGroup(creatingStyle.getGroup())
                        .flatMap(userRoles -> {
                            log.info(customerPODto.getName());
                            if (userRoles.contains(UserRoles.CREATE_CUSTOMER_PO)) {
                                return materialService.getMaterialByName(customerPODto.getRawMaterial())
                                        .flatMap(materialDto -> {
                                            return save(customerPODto, username);
                                        })
                                        .switchIfEmpty(Mono.just(NewCustomerPOResponse.builder()
                                                .status("E1000")
                                                .statusDescription("Material is not available").build()));
                            } else {
                                return Mono.just(NewCustomerPOResponse.builder()
                                        .status("E1200")
                                        .statusDescription("You are not authorized to use this service").build());
                            }
                        }));
    }

    private Mono<NewCustomerPOResponse> save(CustomerPODto customerPODto, String username) {
        return Mono.just(customerPODto)
                .map(customerPOMapper::customerPODtoToCustomerPO)
                .doOnNext(customerPO -> {
                    customerPO.setName(customerPO.getName());
                    customerPO.setRawMaterial(customerPO.getRawMaterial() != null ? customerPO.getRawMaterial() : "UN-ASSIGNED");
                    customerPO.setCreatedBy(username);
                    customerPO.setCreatedDateTime(LocalDateTime.now());
                })
                .flatMap(customerPORepository::insert)
                .doOnSuccess(customerPO -> log.info("Successfully saved the customer po [{}]", customerPO))
                .map(customerPO -> NewCustomerPOResponse.builder()
                        .status("S1000")
                        .statusDescription("Success")
                        .name(customerPO.getName())
                        .build());
    }

    public Mono<ResponseEntity<CustomerPOResponse>> getCustomerPOs(String auth) {
        log.info("get customer po s request received with jwt [{}]", auth);
        return userRepository.findByUsername(jwtUtils.getUsername(auth))
                .flatMap(requestedUser -> userGroupRoleService.getUserRolesByUserGroup(requestedUser.getGroup())
                        .flatMap(userRoles -> {
                            if (userRoles.contains(UserRoles.GET_ALL_CUSTOMER_PO)) {
                                return customerPORepository.findAll()
                                        .map(customerPO -> {
                                            return CustomerPODto.builder()
                                                    .name(customerPO.getName())
                                                    .rawMaterial(customerPO.getRawMaterial())
                                                    .createdBy(customerPO.getCreatedBy())
                                                    .createdDateTime(customerPO.getCreatedDateTime())
                                                    .build();
                                        })
                                        .collectList()
                                        .flatMap(customerPOs -> Mono.just(ResponseEntity.ok(CustomerPOResponse.builder()
                                                .status("S1000")
                                                .statusDescription("Success")
                                                .customerPOs(customerPOs)
                                                .build()
                                        )));
                            } else {
                                return Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(CustomerPOResponse.builder()
                                        .status("E1200")
                                        .statusDescription("You are not authorized to use this service").build()));
                            }
                        })
                )
                .switchIfEmpty(Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(CustomerPOResponse.builder()
                        .status("E1000")
                        .statusDescription("Failed").build())));
    }

    public Mono<CustomerPODto> getCustomerPOByName(String name) {
        return Mono.just(name)
                .doOnNext(uName -> log.info("Finding customer PO for name [{}]", uName))
                .flatMap(customerPORepository::findByName)
                .map(customerPOMapper::customerPOToCustomerPODto);
    }
}
