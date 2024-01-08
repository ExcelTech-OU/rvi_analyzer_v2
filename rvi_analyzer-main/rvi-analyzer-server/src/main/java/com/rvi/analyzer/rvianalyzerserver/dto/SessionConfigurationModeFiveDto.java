package com.rvi.analyzer.rvianalyzerserver.dto;

import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class SessionConfigurationModeFiveDto {

    private String fixedVoltage;
    private String maxCurrent;
    private String timeDuration;
}
