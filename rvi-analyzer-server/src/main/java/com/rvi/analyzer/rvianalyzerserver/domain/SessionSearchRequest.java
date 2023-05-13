package com.rvi.analyzer.rvianalyzerserver.domain;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class SessionSearchRequest {
    private String date;
    private String filterType;
    private String filterValue;
}
