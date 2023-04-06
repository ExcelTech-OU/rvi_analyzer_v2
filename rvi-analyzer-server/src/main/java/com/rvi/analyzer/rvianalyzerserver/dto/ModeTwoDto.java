package com.rvi.analyzer.rvianalyzerserver.dto;

import com.rvi.analyzer.rvianalyzerserver.entiy.DefaultConfiguration;
import com.rvi.analyzer.rvianalyzerserver.entiy.SessionConfigurationModeTwo;
import com.rvi.analyzer.rvianalyzerserver.entiy.SessionResult;
import lombok.Builder;
import lombok.Data;

import java.util.List;

@Builder
@Data
public class ModeTwoDto {
    private String createdBy;
    private DefaultConfiguration defaultConfigurations;
    private SessionConfigurationModeTwo sessionConfigurationModeTwo;
    private List<SessionResult> results;
    private String status;
}
