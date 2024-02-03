package com.rvi.analyzer.rvianalyzerserver.dto;

import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Builder
public class ProductionOrderDto {
    private String _id;
    private String soNumber;
    private String orderId;
    private String createdBy;
    private LocalDateTime createdDateTime;
}
