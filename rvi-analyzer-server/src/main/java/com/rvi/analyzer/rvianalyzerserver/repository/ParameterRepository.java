package com.rvi.analyzer.rvianalyzerserver.repository;

import com.rvi.analyzer.rvianalyzerserver.entiy.Parameter;
import org.springframework.data.r2dbc.repository.R2dbcRepository;
import org.springframework.stereotype.Repository;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

@Repository
public interface ParameterRepository extends R2dbcRepository<Parameter, Integer> {
    Mono<Parameter> findByname(String name);

    Flux<Parameter> findBycreatedBy(String createdBy);
}
