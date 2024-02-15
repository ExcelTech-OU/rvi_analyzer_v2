package com.rvi.analyzer.rvianalyzerserver.repository;

import com.rvi.analyzer.rvianalyzerserver.entiy.TestResult;
import org.springframework.data.r2dbc.repository.R2dbcRepository;
import org.springframework.stereotype.Repository;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

@Repository
public interface TestResultRepository extends R2dbcRepository<TestResult, Integer> {
    Mono<TestResult> findByproductId(String productId);

    Flux<TestResult> findBycreatedBy(String createdBy);
}
