package com.rvi.analyzer.rvianalyzerserver.dto;

import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class SessionConfigurationModeOneDto {
    private String voltage;
    private String maxCurrent;
    private String passMinCurrent;
    private String passMaxCurrent;
}
