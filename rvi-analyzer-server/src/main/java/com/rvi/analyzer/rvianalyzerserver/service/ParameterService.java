package com.rvi.analyzer.rvianalyzerserver.service;

import com.rvi.analyzer.rvianalyzerserver.domain.*;
import com.rvi.analyzer.rvianalyzerserver.dto.MaterialDto;
import com.rvi.analyzer.rvianalyzerserver.dto.ParameterDto;
import com.rvi.analyzer.rvianalyzerserver.mappers.MaterialMapper;
import com.rvi.analyzer.rvianalyzerserver.mappers.ParameterMapper;
import com.rvi.analyzer.rvianalyzerserver.repository.MaterialRepository;
import com.rvi.analyzer.rvianalyzerserver.repository.ParameterRepository;
import com.rvi.analyzer.rvianalyzerserver.repository.UserRepository;
import com.rvi.analyzer.rvianalyzerserver.security.JwtUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Mono;

import java.util.function.BooleanSupplier;

import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
@Slf4j
public class ParameterService {
    final private UserRepository userRepository;
    final private ParameterRepository parameterRepository;
    final private JwtUtils jwtUtils;
    final private UserGroupRoleService userGroupRoleService;
    final private ParameterMapper parameterMapper;

    public Mono<NewParameterResponse> addParameter(ParameterDto parameterDto, String jwt) {
        return Mono.just(parameterDto)
                .doOnNext(parameterDto1 -> log.info("Parameter add request received [{}]", parameterDto))
                .flatMap(request -> parameterRepository.findByName(request.getName()))
                .flatMap(style -> Mono.just(NewParameterResponse.builder()
                        .status("E1002")
                        .statusDescription("Parameter Already exists")
                        .build()))
                .switchIfEmpty(
                        createParameter(parameterDto, jwtUtils.getUsername(jwt))
                )
                .doOnError(e ->
                        NewParameterResponse.builder()
                                .status("E1000")
                                .statusDescription("Failed")
                                .build());
    }

    private Mono<NewParameterResponse> createParameter(ParameterDto parameterDto, String username) {
        return userRepository.findByUsername(username)
                .flatMap(creatingStyle -> userGroupRoleService.getUserRolesByUserGroup(creatingStyle.getGroup())
                        .flatMap(userRoles -> {
                            log.info(parameterDto.getName());
                            if (userRoles.contains(UserRoles.CREATE_PARAMETER)) {
                                return save(parameterDto, username);
                            } else {
                                return Mono.just(NewParameterResponse.builder()
                                        .status("E1200")
                                        .statusDescription("You are not authorized to use this service").build());
                            }
                        }));
    }

    private Mono<NewParameterResponse> save(ParameterDto parameterDto, String username) {
        return Mono.just(parameterDto)
                .map(parameterMapper::parameterDtoToParameter)
                .doOnNext(parameter -> {
                    parameter.setName(parameterDto.getName());
                    parameter.setCreatedBy(username);
                    parameter.setCreatedDateTime(LocalDateTime.now());
                })
                .flatMap(parameterRepository::insert)
                .doOnSuccess(parameter -> log.info("Successfully saved the parameter [{}]", parameter))
                .map(material -> NewParameterResponse.builder()
                        .status("S1000")
                        .statusDescription("Success")
                        .name(parameterDto.getName())
                        .build());
    }

    public Mono<ResponseEntity<ParameterResponse>> getParameters(String auth) {
        log.info("get parameters request received with jwt [{}]", auth);
        return userRepository.findByUsername(jwtUtils.getUsername(auth))
                .flatMap(requestedUser -> userGroupRoleService.getUserRolesByUserGroup(requestedUser.getGroup())
                        .flatMap(userRoles -> {
                            if (userRoles.contains(UserRoles.GET_ALL_PARAMETER)) {
                                return parameterRepository.findAll()
                                        .map(parameter -> {
                                            return ParameterDto.builder()
                                                    ._id(parameter.get_id())
                                                    .name(parameter.getName())
                                                    .createdBy(parameter.getCreatedBy())
                                                    .createdDateTime(parameter.getCreatedDateTime())
                                                    .build();
                                        })
                                        .collectList()
                                        .flatMap(parameterDtos -> Mono.just(ResponseEntity.ok(ParameterResponse.builder()
                                                .status("S1000")
                                                .statusDescription("Success")
                                                .parameters(parameterDtos)
                                                .build()
                                        )));
                            } else {
                                return Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(ParameterResponse.builder()
                                        .status("E1200")
                                        .statusDescription("You are not authorized to use this service").build()));
                            }
                        })
                )
                .switchIfEmpty(Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(ParameterResponse.builder()
                        .status("E1000")
                        .statusDescription("Failed").build())));
    }

    public Mono<ParameterDto> getParameterByName(String name) {
        return Mono.just(name)
                .doOnNext(uName -> log.info("Finding parameter for name [{}]", uName))
                .flatMap(parameterRepository::findByName)
                .map(parameterMapper::parameterToParameterDto);
    }
}
