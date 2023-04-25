package com.rvi.analyzer.rvianalyzerserver.domain;

import com.rvi.analyzer.rvianalyzerserver.dto.*;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class LoginResponse {
    private UserDto user;
    final String state;
    final String stateDescription;
    private String jwt;
}
