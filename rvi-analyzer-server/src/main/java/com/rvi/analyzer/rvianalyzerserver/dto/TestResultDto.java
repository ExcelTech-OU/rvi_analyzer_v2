package com.rvi.analyzer.rvianalyzerserver.dto;

import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@Data
@Builder
public class TestResultDto {
    private String _id;
    private String testGate;
    private String productionOrder;
    private String productId;
    private String mode01;
    private String mode02;
    private String mode03;
    private String mode04;
    private String createdBy;
    private LocalDateTime createdDateTime;
}
