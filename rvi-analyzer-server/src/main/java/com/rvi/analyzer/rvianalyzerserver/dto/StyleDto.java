package com.rvi.analyzer.rvianalyzerserver.dto;

import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Builder
public class StyleDto {
    private String _id;
    private String name;
    private String customer;
    private String plant;
    private String createdBy;
    private LocalDateTime createdDateTime;
}
