package com.rvi.analyzer.rvianalyzerserver.repository;

import com.rvi.analyzer.rvianalyzerserver.entiy.CustomerPO;
import org.springframework.data.r2dbc.repository.R2dbcRepository;
import org.springframework.stereotype.Repository;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

@Repository
public interface CustomerPORepository extends R2dbcRepository<CustomerPO, Integer> {
    Mono<CustomerPO> findByname(String name);

    //    Flux<User> findByUserNamePattern(String pattern);
    Flux<CustomerPO> findBycreatedBy(String createdBy);
}
