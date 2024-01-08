package com.rvi.analyzer.rvianalyzerserver.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class DefaultConfigurationDto {
    private String customerName;
    private String operatorId;
    private String serialNo;
    private String batchNo;
    private String sessionId;
}
