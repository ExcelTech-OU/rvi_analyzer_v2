package com.rvi.analyzer.rvianalyzerserver.service;

import com.rvi.analyzer.rvianalyzerserver.domain.UserRoles;
import com.rvi.analyzer.rvianalyzerserver.entiy.Role;
import com.rvi.analyzer.rvianalyzerserver.repository.GroupRepository;
import com.rvi.analyzer.rvianalyzerserver.repository.GroupRoleRepository;
import com.rvi.analyzer.rvianalyzerserver.repository.RoleRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Mono;

import java.util.ArrayList;
import java.util.List;

@Service
//@AllArgsConstructor
@Slf4j
public class UserGroupRoleService {
    @Autowired
    private GroupRepository groupRepository;
    @Autowired
    private RoleRepository roleRepository;
    @Autowired
    private GroupRoleRepository groupRoleRepository;

    Mono<List<UserRoles>> getUserRolesByUserGroup(String userGroup) {
        List<UserRoles> rolesEmptyList = new ArrayList<>();
        return groupRepository.getGroupByGroupName(userGroup)
                .flatMap(group -> {
                    log.info("Found User Group [{}]", group.getGroupName());
                    return groupRoleRepository.getGroupRoleByGroupId(String.valueOf(group.getGroupId()))
                            .flatMap(groupRole ->
                                    roleRepository.getRolesByRoleIds(groupRole.getRoleIds())
                                            .collectList()
                                            .flatMap(roles -> Mono.just(roles.stream().map(Role::getRoleName).toList()))
                            )
                            .switchIfEmpty(Mono.just(rolesEmptyList));
                })
                .switchIfEmpty(Mono.just(rolesEmptyList));
    }
}
