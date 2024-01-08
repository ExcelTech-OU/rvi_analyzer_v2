package com.rvi.analyzer.rvianalyzerserver.dto;

import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class SessionConfigurationModeFourDto {

    private String startingCurrent;
    private String desiredCurrent;
    private String maxVoltage;
    private String currentResolution;
    private String chargeInTime;
}
