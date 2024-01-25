package com.rvi.analyzer.rvianalyzerserver.dto;

import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@Data
@Builder
public class StyleDto {
    private String _id;
    private String name;
    private String customer;
    private String plant;
    private List<String> admin;
    //    private String admin;
    private String createdBy;
    private LocalDateTime createdDateTime;
}
