package com.rvi.analyzer.rvianalyzerserver.domain;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class NewCustomerResponse {
    private String status;
    private String statusDescription;
    private String name;
}
