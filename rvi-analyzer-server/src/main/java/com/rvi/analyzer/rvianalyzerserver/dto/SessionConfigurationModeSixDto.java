package com.rvi.analyzer.rvianalyzerserver.dto;

import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class SessionConfigurationModeSixDto {

    private String fixedCurrent;
    private String maxVoltage;
    private String timeDuration;
}
