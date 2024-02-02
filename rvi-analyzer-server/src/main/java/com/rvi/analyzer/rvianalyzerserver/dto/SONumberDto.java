package com.rvi.analyzer.rvianalyzerserver.dto;

import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Builder
public class SONumberDto {
    private String _id;
    private String soNumber;
    private String customerPO;
    private String createdBy;
    private LocalDateTime createdDateTime;
}
