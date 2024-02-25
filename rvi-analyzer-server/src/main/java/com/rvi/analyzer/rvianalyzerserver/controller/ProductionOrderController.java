package com.rvi.analyzer.rvianalyzerserver.controller;

import com.rvi.analyzer.rvianalyzerserver.domain.NewProductionOrderResponse;
import com.rvi.analyzer.rvianalyzerserver.domain.ProductionOrderResponse;
import com.rvi.analyzer.rvianalyzerserver.dto.ProductionOrderDto;
import com.rvi.analyzer.rvianalyzerserver.service.ProductionOrderService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Mono;

@RestController
@RequiredArgsConstructor
public class ProductionOrderController {

    final private ProductionOrderService productionOrderService;

    @PostMapping(path = "/register/productionOrder")
    public Mono<NewProductionOrderResponse> addProductionOrder(@RequestBody ProductionOrderDto productionOrderDto, @RequestHeader("Authorization") String auth) {
        return productionOrderService.addProductionOrder(productionOrderDto, auth);
    }

    @GetMapping(path = "/rvi/analyzer/v1/productionOrders")
    public Mono<ResponseEntity<ProductionOrderResponse>> getProductionOrders(@RequestHeader("Authorization") String auth) {
        return productionOrderService.getProductionOrders(auth);
    }

    @GetMapping(path = "/rvi/analyzer/v1/productionOrder/{id}")
    public Mono<ProductionOrderDto> getOrderInfo(@PathVariable String id) {
        return productionOrderService.getProductionOrderByOrderId(id);
    }
}
