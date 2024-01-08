package com.rvi.analyzer.rvianalyzerserver.repository;

import com.rvi.analyzer.rvianalyzerserver.entiy.GroupRole;
import org.springframework.data.mongodb.repository.Query;
import org.springframework.data.mongodb.repository.ReactiveMongoRepository;
import reactor.core.publisher.Mono;

public interface GroupRoleRepository extends ReactiveMongoRepository<GroupRole, String> {
    @Query(
            value = """
    {
        "group-id" : {
            "$eq" : ?0
        }
    }
    """
    )
    Mono<GroupRole> getGroupRoleByGroupId(String groupId);
}
