package com.rvi.analyzer.rvianalyzerserver.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class SettingsDto {
    private String upperBound;
    private String lowerBound;
}
