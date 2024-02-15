package com.rvi.analyzer.rvianalyzerserver.repository;

import com.rvi.analyzer.rvianalyzerserver.entiy.SONumber;
import org.springframework.data.r2dbc.repository.R2dbcRepository;
import org.springframework.stereotype.Repository;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

@Repository
public interface SONumberRepository extends R2dbcRepository<SONumber, Integer> {
    Mono<SONumber> findBysoNumber(String number);

    Flux<SONumber> findBycreatedBy(String createdBy);
}
