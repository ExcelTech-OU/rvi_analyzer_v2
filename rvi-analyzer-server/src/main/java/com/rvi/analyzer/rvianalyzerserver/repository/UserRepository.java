package com.rvi.analyzer.rvianalyzerserver.repository;

import com.rvi.analyzer.rvianalyzerserver.entiy.User;
import org.springframework.data.r2dbc.repository.Query;
import org.springframework.data.r2dbc.repository.R2dbcRepository;
import org.springframework.stereotype.Repository;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

@Repository
public interface UserRepository extends R2dbcRepository<User, Integer> {
    @Query("""
            SELECT `_id`, `username`, `password`, `supervisor`, `passwordType`, `userGroup`, `status`, `createdBy`, `createdDateTime`, `lastUpdatedDateTime`
            FROM `User`
            WHERE `username` = :username;
            """)
    Mono<User> findByusername(String username);

//    Flux<User> findByUserNamePattern(String pattern);

    Flux<User> findBycreatedBy(String createdBy);

//    Mono<Long> countUsersByUsername(String username);
}
