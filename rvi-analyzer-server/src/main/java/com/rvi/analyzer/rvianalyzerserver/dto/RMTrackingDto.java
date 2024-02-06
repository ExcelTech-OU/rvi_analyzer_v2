package com.rvi.analyzer.rvianalyzerserver.dto;

import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@Data
@Builder
public class RMTrackingDto {
    private String _id;
    private String userId;
    private String productionOrder;
    private String createdBy;
    private LocalDateTime createdDateTime;
}
