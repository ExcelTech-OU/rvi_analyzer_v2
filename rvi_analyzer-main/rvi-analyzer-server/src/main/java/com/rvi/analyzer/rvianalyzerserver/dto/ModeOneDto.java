package com.rvi.analyzer.rvianalyzerserver.dto;

import com.rvi.analyzer.rvianalyzerserver.entiy.DefaultConfiguration;
import com.rvi.analyzer.rvianalyzerserver.entiy.SessionConfigurationModeOne;
import com.rvi.analyzer.rvianalyzerserver.entiy.SessionResult;
import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@Builder
@Data
public class ModeOneDto {
    private String createdBy;
    private DefaultConfiguration defaultConfigurations;
    private SessionConfigurationModeOne sessionConfigurationModeOne;
    private List<SessionResult> results;
    private String status;
    private String createdDateTime;
    private String lastUpdatedDateTime;
}
