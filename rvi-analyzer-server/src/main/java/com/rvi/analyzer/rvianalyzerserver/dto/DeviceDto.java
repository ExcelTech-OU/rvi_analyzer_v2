package com.rvi.analyzer.rvianalyzerserver.dto;

import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Builder
public class DeviceDto {
    private String createdBy;
    private String macAddress;
    private String assignTo;
    private String status;
    private LocalDateTime createdDateTime;
}
