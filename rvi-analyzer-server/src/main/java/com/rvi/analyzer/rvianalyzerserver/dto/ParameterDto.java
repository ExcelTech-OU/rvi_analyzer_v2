package com.rvi.analyzer.rvianalyzerserver.dto;

import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@Data
@Builder
public class ParameterDto {
    private String _id;
    private String name;
    private String createdBy;
    private LocalDateTime createdDateTime;
}
