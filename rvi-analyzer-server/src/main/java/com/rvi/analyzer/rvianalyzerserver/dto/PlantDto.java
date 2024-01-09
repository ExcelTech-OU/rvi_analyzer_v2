package com.rvi.analyzer.rvianalyzerserver.dto;

import lombok.Builder;
import lombok.Data;
import org.springframework.data.mongodb.core.mapping.Field;

import java.time.LocalDateTime;

@Data
@Builder
public class PlantDto {
    private String _id;
    private String name;
    private String createdBy;
    private LocalDateTime createdDateTime;
    private LocalDateTime lastUpdatedDateTime;
    //    private CustomerDto customer;
//    private String status;
}
