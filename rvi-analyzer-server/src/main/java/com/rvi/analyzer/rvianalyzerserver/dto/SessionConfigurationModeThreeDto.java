package com.rvi.analyzer.rvianalyzerserver.dto;

import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class SessionConfigurationModeThreeDto {
    private String startingVoltage;
    private String desiredVoltage;
    private String maxCurrent;
    private String voltageResolution;
    private String chargeInTime;
}
