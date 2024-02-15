package com.rvi.analyzer.rvianalyzerserver.repository;

import com.rvi.analyzer.rvianalyzerserver.entiy.RMTracking;
import org.springframework.data.r2dbc.repository.R2dbcRepository;
import org.springframework.stereotype.Repository;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

@Repository
public interface RMTrackingRepository extends R2dbcRepository<RMTracking, Integer> {
    Mono<RMTracking> findByuserId(String name);

    Flux<RMTracking> findBycreatedBy(String createdBy);
}
