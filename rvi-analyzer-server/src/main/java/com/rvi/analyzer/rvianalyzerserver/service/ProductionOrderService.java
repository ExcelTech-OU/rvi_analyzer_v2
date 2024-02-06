package com.rvi.analyzer.rvianalyzerserver.service;

import com.rvi.analyzer.rvianalyzerserver.domain.*;
import com.rvi.analyzer.rvianalyzerserver.dto.CustomerPODto;
import com.rvi.analyzer.rvianalyzerserver.dto.ProductionOrderDto;
import com.rvi.analyzer.rvianalyzerserver.dto.SONumberDto;
import com.rvi.analyzer.rvianalyzerserver.entiy.ProductionOrder;
import com.rvi.analyzer.rvianalyzerserver.entiy.SONumber;
import com.rvi.analyzer.rvianalyzerserver.mappers.CustomerPOMapper;
import com.rvi.analyzer.rvianalyzerserver.mappers.ProductionOrderMapper;
import com.rvi.analyzer.rvianalyzerserver.mappers.SONumberMapper;
import com.rvi.analyzer.rvianalyzerserver.mappers.StyleMapper;
import com.rvi.analyzer.rvianalyzerserver.repository.*;
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
public class ProductionOrderService {
    final private ProductionOrderRepository productionOrderRepository;
    final private UserRepository userRepository;
    final private ProductionOrderMapper productionOrderMapper;
    final private JwtUtils jwtUtils;
    final private UserGroupRoleService userGroupRoleService;
    final private SONumberService soNumberService;

    public Mono<NewProductionOrderResponse> addProductionOrder(ProductionOrderDto productionOrderDto, String jwt) {
        return Mono.just(productionOrderDto)
                .doOnNext(productionOrderDto1 -> log.info("Production order add request received [{}]", productionOrderDto1))
                .flatMap(request -> productionOrderRepository.findByOrderId(request.getOrderId()))
                .flatMap(productionOrder -> Mono.just(NewProductionOrderResponse.builder()
                        .status("E1002")
                        .statusDescription("Production Order Already exists")
                        .build()))
                .switchIfEmpty(
                        createProductionOrder(productionOrderDto, jwtUtils.getUsername(jwt))
                )
                .doOnError(e ->
                        NewProductionOrderResponse.builder()
                                .status("E1000")
                                .statusDescription("Failed")
                                .build());
    }

    private Mono<NewProductionOrderResponse> createProductionOrder(ProductionOrderDto productionOrderDto, String username) {
        return userRepository.findByUsername(username)
                .flatMap(creatingStyle -> userGroupRoleService.getUserRolesByUserGroup(creatingStyle.getGroup())
                        .flatMap(userRoles -> {
                            log.info(productionOrderDto.getOrderId());
                            if (userRoles.contains(UserRoles.CREATE_PRODUCTION_ORDER)) {
                                return soNumberService.getSONumberBySONumber(productionOrderDto.getSoNumber())
                                        .flatMap(soNumberDto -> {
                                            return save(productionOrderDto, username);
                                        })
                                        .switchIfEmpty(Mono.just(NewProductionOrderResponse.builder()
                                                .status("E1000")
                                                .statusDescription("SO Number is not available").build()));
                            } else {
                                return Mono.just(NewProductionOrderResponse.builder()
                                        .status("E1200")
                                        .statusDescription("You are not authorized to use this service").build());
                            }
                        }));
    }

    private Mono<NewProductionOrderResponse> save(ProductionOrderDto productionOrderDto, String username) {
        return Mono.just(productionOrderDto)
                .map(productionOrderDto1 -> {
                    return ProductionOrder.builder()
                            .soNumber(productionOrderDto.getSoNumber())
                            .orderId(productionOrderDto.getOrderId())
                            .createdBy(username)
                            .createdDateTime(LocalDateTime.now())
                            .build();
                })
                .doOnNext(productionOrderDto1 -> {
                    productionOrderDto1.setSoNumber(productionOrderDto.getSoNumber());
                    productionOrderDto1.setOrderId(productionOrderDto.getOrderId() != null ? productionOrderDto.getOrderId() : "UN-ASSIGNED");
                    productionOrderDto1.setCreatedBy(username);
                    productionOrderDto1.setCreatedDateTime(LocalDateTime.now());
                })
                .flatMap(productionOrderRepository::insert)
                .doOnSuccess(productionOrder -> log.info("Successfully saved the production order [{}]", productionOrder))
                .map(soNumber -> NewProductionOrderResponse.builder()
                        .status("S1000")
                        .statusDescription("Success")
                        .orderId(soNumber.getSoNumber())
                        .build());
    }

    public Mono<ResponseEntity<ProductionOrderResponse>> getProductionOrders(String auth) {
        log.info("get production order request received with jwt [{}]", auth);
        return userRepository.findByUsername(jwtUtils.getUsername(auth))
                .flatMap(requestedUser -> userGroupRoleService.getUserRolesByUserGroup(requestedUser.getGroup())
                        .flatMap(userRoles -> {
                            if (userRoles.contains(UserRoles.GET_ALL_PRODUCTION_ORDER)) {
                                return productionOrderRepository.findAll()
                                        .map(productionOrder -> {
                                            return ProductionOrderDto.builder()
                                                    ._id(productionOrder.get_id())
                                                    .soNumber(productionOrder.getSoNumber())
                                                    .orderId(productionOrder.getOrderId())
                                                    .createdBy(productionOrder.getCreatedBy())
                                                    .createdDateTime(productionOrder.getCreatedDateTime())
                                                    .build();
                                        })
                                        .collectList()
                                        .flatMap(productionOrders -> Mono.just(ResponseEntity.ok(ProductionOrderResponse.builder()
                                                .status("S1000")
                                                .statusDescription("Success")
                                                .orders(productionOrders)
                                                .build()
                                        )));
                            } else {
                                return Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(ProductionOrderResponse.builder()
                                        .status("E1200")
                                        .statusDescription("You are not authorized to use this service").build()));
                            }
                        })
                )
                .switchIfEmpty(Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(ProductionOrderResponse.builder()
                        .status("E1000")
                        .statusDescription("Failed").build())));
    }

    public Mono<ProductionOrderDto> getProductionOrderByOrderId(String name) {
        return Mono.just(name)
                .doOnNext(uName -> log.info("Finding production order for name [{}]", uName))
                .flatMap(productionOrderRepository::findByOrderId)
                .map(productionOrderMapper::productionOrderToProductionOrderDto);
    }
}
