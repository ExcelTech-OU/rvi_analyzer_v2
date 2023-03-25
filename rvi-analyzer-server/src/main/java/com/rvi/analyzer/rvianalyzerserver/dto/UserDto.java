package com.rvi.analyzer.rvianalyzerserver.dto;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class UserDto {
    private String userName;
    private String type;
    private String status;
    private String createdBy;
    private LocalDateTime createdDateTime;
    private LocalDateTime lastUpdatedDateTime;
}
