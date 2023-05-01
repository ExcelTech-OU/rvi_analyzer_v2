package com.rvi.analyzer.rvianalyzerserver.repository;

import com.rvi.analyzer.rvianalyzerserver.entiy.Group;
import com.rvi.analyzer.rvianalyzerserver.entiy.GroupRole;
import org.springframework.data.mongodb.repository.Query;
import org.springframework.data.mongodb.repository.ReactiveMongoRepository;
import reactor.core.publisher.Mono;

public interface GroupRepository extends ReactiveMongoRepository<Group, String> {
    @Query(
            value = """
    {
        "group-name" : {
            "$eq" : ?0
        }
    }
    """
    )
    Mono<Group> getGroupByGroupName(String groupName);
}
