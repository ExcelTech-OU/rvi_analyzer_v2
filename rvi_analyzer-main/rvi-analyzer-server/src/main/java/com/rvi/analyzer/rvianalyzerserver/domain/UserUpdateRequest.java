package com.rvi.analyzer.rvianalyzerserver.domain;

import lombok.Data;

@Data
public class UserUpdateRequest {
    private String username;
    private String status;
}
