package com.rvi.analyzer.rvianalyzerserver.dto;

import lombok.Builder;
import lombok.Data;
import org.springframework.data.mongodb.core.mapping.Field;

@Builder
@Data
public class SessionConfigurationModeSixDto {

    private String fixedCurrent;
    private String maxVoltage;
    private String timeDuration;
}
