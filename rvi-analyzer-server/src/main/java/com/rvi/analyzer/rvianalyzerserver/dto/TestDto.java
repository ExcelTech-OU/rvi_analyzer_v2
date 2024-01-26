package com.rvi.analyzer.rvianalyzerserver.dto;

import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@Data
@Builder
public class TestDto {
    private String _id;
    private String testGate;
    private String material;
    private List<ParameterModeDto> parameterModes;
    private String createdBy;
    private LocalDateTime createdDateTime;
}
