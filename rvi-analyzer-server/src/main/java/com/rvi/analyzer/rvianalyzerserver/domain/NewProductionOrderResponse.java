package com.rvi.analyzer.rvianalyzerserver.domain;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class NewProductionOrderResponse {
    private String status;
    private String statusDescription;
    private String orderId;
}
