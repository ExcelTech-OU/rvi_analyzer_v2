package com.rvi.analyzer.rvianalyzerserver.repository;

import com.rvi.analyzer.rvianalyzerserver.entiy.ModeTwo;
import org.springframework.data.domain.Pageable;
import org.springframework.data.mongodb.repository.Aggregation;
import org.springframework.data.mongodb.repository.Query;
import org.springframework.data.mongodb.repository.ReactiveMongoRepository;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

public interface ModeTwoRepository extends ReactiveMongoRepository<ModeTwo, String> {
    @Query(
            value = """
    {
        "default-configurations.session-id" : {
            "$eq" : ?0
        }
    }
    """
    )
    Mono<ModeTwo> findBySessionID(String sessionId);

    @Query(value = "?0")
    Flux<ModeTwo> findByFilters(String filter, Pageable pageable);
}
