package com.rvi.analyzer.rvianalyzerserver.dto;

import com.rvi.analyzer.rvianalyzerserver.entiy.DefaultConfiguration;
import com.rvi.analyzer.rvianalyzerserver.entiy.SessionConfigurationModeThree;
import com.rvi.analyzer.rvianalyzerserver.entiy.SessionResult;
import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class ModeThreeDto {
    private String createdBy;
    private DefaultConfiguration defaultConfigurations;
    private SessionConfigurationModeThree sessionConfigurationModeThree;
    private SessionResult results;
    private String status;
}
