package com.rvi.analyzer.rvianalyzerserver.dto;

import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Builder
public class MaterialDto {
    private String _id;
    private String name;
    private String plant;
    private String customer;
    private String style;
    private String createdBy;
    private LocalDateTime createdDateTime;
}
