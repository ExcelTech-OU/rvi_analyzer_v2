package com.rvi.analyzer.rvianalyzerserver.domain;

import com.rvi.analyzer.rvianalyzerserver.dto.UserDto;
import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class UserRolesResponse {
    private UserDto user;
    final String status;
    final String statusDescription;
    private List<UserRoles> roles;
}
