package com.rvi.analyzer.rvianalyzerserver.repository;

import com.rvi.analyzer.rvianalyzerserver.entiy.Group;
import org.springframework.data.r2dbc.repository.Query;
import org.springframework.data.r2dbc.repository.R2dbcRepository;
import org.springframework.stereotype.Repository;
import reactor.core.publisher.Mono;

@Repository
public interface GroupRepository extends R2dbcRepository<Group, String> {
    @Query("""
            SELECT *
            FROM `Group` g
            WHERE g.groupName = :groupName;
            """)
    Mono<Group> getGroupByGroupName(String groupName);
}
