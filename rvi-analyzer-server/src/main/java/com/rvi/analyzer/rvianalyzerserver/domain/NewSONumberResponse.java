package com.rvi.analyzer.rvianalyzerserver.domain;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class NewSONumberResponse {
    private String status;
    private String statusDescription;
    private String number;
}
