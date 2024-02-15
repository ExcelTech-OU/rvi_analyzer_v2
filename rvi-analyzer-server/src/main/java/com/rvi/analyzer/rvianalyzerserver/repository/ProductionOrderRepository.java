package com.rvi.analyzer.rvianalyzerserver.repository;

import com.rvi.analyzer.rvianalyzerserver.entiy.ProductionOrder;
import org.springframework.data.r2dbc.repository.R2dbcRepository;
import org.springframework.stereotype.Repository;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

@Repository
public interface ProductionOrderRepository extends R2dbcRepository<ProductionOrder, Integer> {
    Mono<ProductionOrder> findByorderId(String orderId);

    Flux<ProductionOrder> findBycreatedBy(String createdBy);
}
