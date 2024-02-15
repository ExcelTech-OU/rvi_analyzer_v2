package com.rvi.analyzer.rvianalyzerserver.dto;

import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Builder
public class UserDto {
    private String username;
    private String userGroup;
    private String password;
    private String status;
    private String passwordType;
    private String createdBy;
    private String supervisor;
    private LocalDateTime createdDateTime;
    private LocalDateTime lastUpdatedDateTime;
}
