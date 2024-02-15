package com.rvi.analyzer.rvianalyzerserver.repository;

import com.rvi.analyzer.rvianalyzerserver.entiy.Style;
import org.springframework.data.r2dbc.repository.R2dbcRepository;
import org.springframework.stereotype.Repository;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

@Repository
public interface StyleRepository extends R2dbcRepository<Style, Integer> {
    Mono<Style> findByname(String name);

//    @Query(
//            value = """
//    {
//        "username" : {
//            $regex: .*?0.*
//        }
//    }
//    """
//    )
//    Flux<User> findByUserNamePattern(String pattern);

    Flux<Style> findBycreatedBy(String createdBy);

//    @Query(value = "{ 'created-by': ?0 }", count = true)
//    Mono<Long> countUsersByUsername(String username);
}
