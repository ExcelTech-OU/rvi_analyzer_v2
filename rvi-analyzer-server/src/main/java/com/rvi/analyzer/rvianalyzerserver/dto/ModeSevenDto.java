package com.rvi.analyzer.rvianalyzerserver.dto;

import com.rvi.analyzer.rvianalyzerserver.entiy.DefaultConfiguration;
import com.rvi.analyzer.rvianalyzerserver.entiy.SessionConfigurationModeSix;
import com.rvi.analyzer.rvianalyzerserver.entiy.SessionResult;
import com.rvi.analyzer.rvianalyzerserver.entiy.SessionResultModeSeven;
import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@Builder
@Data
public class ModeSevenDto {
    private String createdBy;
    private DefaultConfiguration defaultConfigurations;
    private SessionResultModeSeven result;
    private String status;
    private String createdDateTime;
    private String lastUpdatedDateTime;
}
