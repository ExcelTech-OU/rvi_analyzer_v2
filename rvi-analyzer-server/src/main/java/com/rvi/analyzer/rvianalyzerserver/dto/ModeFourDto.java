package com.rvi.analyzer.rvianalyzerserver.dto;

import com.rvi.analyzer.rvianalyzerserver.entiy.DefaultConfiguration;
import com.rvi.analyzer.rvianalyzerserver.entiy.SessionConfigurationModeFour;
import com.rvi.analyzer.rvianalyzerserver.entiy.SessionConfigurationModeThree;
import com.rvi.analyzer.rvianalyzerserver.entiy.SessionResult;
import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class ModeFourDto {
    private String createdBy;
    private DefaultConfiguration defaultConfigurations;
    private SessionConfigurationModeFour sessionConfigurationModeFour;
    private SessionResult results;
    private String status;
}
