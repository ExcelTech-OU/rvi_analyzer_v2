package com.rvi.analyzer.rvianalyzerserver.dto;

import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Builder
public class CustomerPODto {
    private String name;
    private String rawMaterial;
    private String createdBy;
    private LocalDateTime createdDateTime;
}
