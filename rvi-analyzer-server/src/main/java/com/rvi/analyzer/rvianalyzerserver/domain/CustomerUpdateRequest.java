package com.rvi.analyzer.rvianalyzerserver.domain;

import lombok.Data;

@Data
public class CustomerUpdateRequest {
    private String name;
    private String plant;
    private String admin;
}
