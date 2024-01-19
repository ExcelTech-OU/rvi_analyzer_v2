package com.rvi.analyzer.rvianalyzerserver.domain;

import com.rvi.analyzer.rvianalyzerserver.entiy.Customer;
import com.rvi.analyzer.rvianalyzerserver.entiy.Style;
import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class GetStyleResponse {
    private String status;
    private String statusDescription;
    private List<Style> styles;
    private int total;
}
