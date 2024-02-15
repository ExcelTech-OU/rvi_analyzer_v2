package com.rvi.analyzer.rvianalyzerserver.repository;

import com.rvi.analyzer.rvianalyzerserver.entiy.Test;
import org.springframework.data.r2dbc.repository.R2dbcRepository;
import org.springframework.stereotype.Repository;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

@Repository
public interface TestRepository extends R2dbcRepository<Test, Integer> {
    Mono<Test> findBytestGate(String testGate);

    Flux<Test> findBycreatedBy(String createdBy);
}
