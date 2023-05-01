package com.rvi.analyzer.rvianalyzerserver.repository;

import com.rvi.analyzer.rvianalyzerserver.entiy.Role;
import org.springframework.data.mongodb.repository.Query;
import org.springframework.data.mongodb.repository.ReactiveMongoRepository;
import reactor.core.publisher.Flux;

import java.util.List;

public interface RoleRepository extends ReactiveMongoRepository<Role, String> {
    @Query(
            value = """
    {
        "role-id" : {
            "$in" : ?0
        }
    }
    """
    )
    Flux<Role> getRolesByRoleIds(List<String> roleIds);
}
