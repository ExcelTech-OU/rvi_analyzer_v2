package com.rvi.analyzer.rvianalyzerserver.dto;

import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class SessionConfigurationModeTwoDto {
    private String current;
    private String maxVoltage;
    private String passMinVoltage;
    private String passMaxVoltage;
}
