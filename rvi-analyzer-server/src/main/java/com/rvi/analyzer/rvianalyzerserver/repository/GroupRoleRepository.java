package com.rvi.analyzer.rvianalyzerserver.repository;

import com.rvi.analyzer.rvianalyzerserver.entiy.GroupRole;
import org.springframework.data.r2dbc.repository.Query;
import org.springframework.data.r2dbc.repository.R2dbcRepository;
import reactor.core.publisher.Mono;

public interface GroupRoleRepository extends R2dbcRepository<GroupRole, Integer> {
    @Query("SELECT * FROM GroupRole WHERE groupId = :groupId")
    Mono<GroupRole> getGroupRoleByGroupId(String groupId);
}
