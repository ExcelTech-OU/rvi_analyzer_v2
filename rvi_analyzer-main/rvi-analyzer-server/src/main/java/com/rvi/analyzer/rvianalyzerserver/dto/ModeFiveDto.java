package com.rvi.analyzer.rvianalyzerserver.dto;

import com.rvi.analyzer.rvianalyzerserver.entiy.DefaultConfiguration;
import com.rvi.analyzer.rvianalyzerserver.entiy.SessionConfigurationModeFive;
import com.rvi.analyzer.rvianalyzerserver.entiy.SessionConfigurationModeThree;
import com.rvi.analyzer.rvianalyzerserver.entiy.SessionResult;
import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class ModeFiveDto {
    private String createdBy;
    private DefaultConfiguration defaultConfigurations;
    private SessionConfigurationModeFive sessionConfigurationModeFive;
    private SessionResult results;
    private String status;
    private String createdDateTime;
    private String lastUpdatedDateTime;
}
