package com.rvi.analyzer.rvianalyzerserver.service;

import com.rvi.analyzer.rvianalyzerserver.domain.UserRoles;
import com.rvi.analyzer.rvianalyzerserver.entiy.Group;
import com.rvi.analyzer.rvianalyzerserver.entiy.Role;
import com.rvi.analyzer.rvianalyzerserver.repository.GroupRepository;
import com.rvi.analyzer.rvianalyzerserver.repository.GroupRoleRepository;
import com.rvi.analyzer.rvianalyzerserver.repository.RoleRepository;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Mono;

import java.util.ArrayList;
import java.util.List;

@Service
@AllArgsConstructor
@Slf4j
public class UserGroupRoleService {
    private GroupRepository groupRepository;
    private RoleRepository roleRepository;
    private GroupRoleRepository groupRoleRepository;

    Mono<List<UserRoles>> getUserRolesByUserGroup(String userGroup) {
        List<UserRoles> rolesEmptyList = new ArrayList<>();
        return Mono.just(groupRepository.findByGroupName(userGroup))
                .flatMap(group -> {
                    log.info("Found User Group [{}]", group.getGroupName());
                    return Mono.just(groupRoleRepository.findByGroupGroupIdIgnoreCase(group.getGroupId()))
                            .flatMap(groupRoles ->
                                    Mono.just(roleRepository.findByIdIn(groupRoles.stream().map(groupRole -> groupRole.getRole().getId()).toList()))
                                            .flatMap(roles -> Mono.just(roles.stream().map(Role::getRoleName).toList()))
                            )
                            .switchIfEmpty(Mono.just(rolesEmptyList));
                })
                .switchIfEmpty(Mono.just(rolesEmptyList));
    }

    Group getUserGroupByGroupName(String groupName) {
        return groupRepository.findByGroupName(groupName);
    }
}
