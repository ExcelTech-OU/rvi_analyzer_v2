package com.rvi.analyzer.rvianalyzerserver.service;

import com.rvi.analyzer.rvianalyzerserver.domain.*;
import com.rvi.analyzer.rvianalyzerserver.dto.MaterialDto;
import com.rvi.analyzer.rvianalyzerserver.dto.RMTrackingDto;
import com.rvi.analyzer.rvianalyzerserver.dto.StyleDto;
import com.rvi.analyzer.rvianalyzerserver.dto.UserDto;
import com.rvi.analyzer.rvianalyzerserver.entiy.Style;
import com.rvi.analyzer.rvianalyzerserver.mappers.RMTrackingMapper;
import com.rvi.analyzer.rvianalyzerserver.mappers.StyleMapper;
import com.rvi.analyzer.rvianalyzerserver.repository.RMTrackingRepository;
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
import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class RMTrackingService {
    final private RMTrackingRepository rmTrackingRepository;
    final private UserRepository userRepository;
    final private RMTrackingMapper rmTrackingMapper;
    final private JwtUtils jwtUtils;
    final private UserGroupRoleService userGroupRoleService;
    final private ProductionOrderService productionOrderService;

    public Mono<NewRMTrackingResponse> addRMTracking(RMTrackingDto rmTrackingDto, String jwt) {
        return Mono.just(rmTrackingDto)
                .doOnNext(rmTrackingDto1 -> log.info("RM Tracking add request received [{}]", rmTrackingDto1))
                .flatMap(request -> rmTrackingRepository.findByUserId(request.getUserId()))
                .flatMap(rmTracking -> Mono.just(NewRMTrackingResponse.builder()
                        .status("E1002")
                        .statusDescription("RM Tracking Already exists")
                        .build()))
                .switchIfEmpty(
                        createRMTracking(rmTrackingDto, jwtUtils.getUsername(jwt))
                )
                .doOnError(e ->
                        NewRMTrackingResponse.builder()
                                .status("E1000")
                                .statusDescription("Failed")
                                .build());
    }

    private Mono<NewRMTrackingResponse> createRMTracking(RMTrackingDto rmTrackingDto, String username) {
        return userRepository.findByUsername(username)
                .flatMap(creatingRM -> userGroupRoleService.getUserRolesByUserGroup(creatingRM.getGroup())
                        .flatMap(userRoles -> {
                            log.info(rmTrackingDto.getUserId());
                            if (userRoles.contains(UserRoles.CREATE_RM_TRACKING)) {
                                return productionOrderService.getProductionOrderByOrderId(rmTrackingDto.getProductionOrder())
                                        .flatMap(productionOrderDto -> {
                                            return save(rmTrackingDto, username);
                                        })
                                        .switchIfEmpty(Mono.just(NewRMTrackingResponse.builder()
                                                .status("E1000")
                                                .statusDescription("Customer PO is not available").build()));
                            } else {
                                return Mono.just(NewRMTrackingResponse.builder()
                                        .status("E1200")
                                        .statusDescription("You are not authorized to use this service").build());
                            }
                        }));
    }

    private Mono<NewRMTrackingResponse> save(RMTrackingDto rmTrackingDto, String username) {
        return Mono.just(rmTrackingDto)
                .map(rmTrackingMapper::rmTrackingDtoToRMTracking)
                .doOnNext(rmTracking -> {
                    rmTracking.setUserId(rmTrackingDto.getUserId() != null ? rmTrackingDto.getUserId() : "UN-ASSIGNED");
                    rmTracking.setProductionOrder(rmTrackingDto.getProductionOrder() != null ? rmTrackingDto.getProductionOrder() : "UN-ASSIGNED");
                    rmTracking.setCreatedBy(username);
                    rmTracking.setCreatedDateTime(LocalDateTime.now());
                })
                .flatMap(rmTrackingRepository::insert)
                .doOnSuccess(rmTracking -> log.info("Successfully saved the rm tracking [{}]", rmTracking))
                .map(rmTracking -> NewRMTrackingResponse.builder()
                        .status("S1000")
                        .statusDescription("Success")
                        .userId(rmTrackingDto.getUserId())
                        .build());
    }

    public Mono<ResponseEntity<RMTrackingResponse>> getRMTrackings(String auth) {
        log.info("get rm tracking request received with jwt [{}]", auth);
        return userRepository.findByUsername(jwtUtils.getUsername(auth))
                .flatMap(requestedUser -> userGroupRoleService.getUserRolesByUserGroup(requestedUser.getGroup())
                        .flatMap(userRoles -> {
                            if (userRoles.contains(UserRoles.GET_ALL_RM_TRACKING)) {
                                return rmTrackingRepository.findAll()
                                        .map(rmTracking -> {
                                            return RMTrackingDto.builder()
                                                    ._id(rmTracking.get_id())
                                                    .productionOrder(rmTracking.getProductionOrder())
                                                    .userId(rmTracking.getUserId())
                                                    .createdBy(rmTracking.getCreatedBy())
                                                    .createdDateTime(rmTracking.getCreatedDateTime())
                                                    .build();
                                        })
                                        .collectList()
                                        .flatMap(rmTrackingDtos -> Mono.just(ResponseEntity.ok(RMTrackingResponse.builder()
                                                .status("S1000")
                                                .statusDescription("Success")
                                                .rmTrackings(rmTrackingDtos)
                                                .build()
                                        )));
                            } else {
                                return Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(RMTrackingResponse.builder()
                                        .status("E1200")
                                        .statusDescription("You are not authorized to use this service").build()));
                            }
                        })
                )
                .switchIfEmpty(Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(RMTrackingResponse.builder()
                        .status("E1000")
                        .statusDescription("Failed").build())));
    }

    public Mono<RMTrackingDto> getRMTrackingByUserId(String name) {
        return Mono.just(name)
                .doOnNext(uName -> log.info("Finding rm tracking for name [{}]", uName))
                .flatMap(rmTrackingRepository::findByUserId)
                .map(rmTrackingMapper::rmTrackingToRMTrackingDto);
    }
}
