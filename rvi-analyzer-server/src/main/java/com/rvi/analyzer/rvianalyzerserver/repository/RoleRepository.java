package com.rvi.analyzer.rvianalyzerserver.repository;

import com.rvi.analyzer.rvianalyzerserver.entiy.Role;
import org.springframework.data.r2dbc.repository.Query;
import org.springframework.data.r2dbc.repository.R2dbcRepository;
import reactor.core.publisher.Flux;

import java.util.List;

public interface RoleRepository extends R2dbcRepository<Role, String> {
    @Query("""
            SELECT *
            FROM Role
            WHERE roleId IN (:roleIds);
            """)
    Flux<Role> getRolesByRoleIds(List<String> roleIds);
}
