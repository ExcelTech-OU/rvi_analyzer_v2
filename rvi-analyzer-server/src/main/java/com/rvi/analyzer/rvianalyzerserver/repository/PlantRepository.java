package com.rvi.analyzer.rvianalyzerserver.repository;

import com.rvi.analyzer.rvianalyzerserver.entiy.Plant;
import org.springframework.data.r2dbc.repository.R2dbcRepository;
import org.springframework.stereotype.Repository;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

@Repository
public interface PlantRepository extends R2dbcRepository<Plant, Integer> {
    Mono<Plant> findByname(String name);

    Flux<Plant> findBycreatedBy(String createdBy);
}
