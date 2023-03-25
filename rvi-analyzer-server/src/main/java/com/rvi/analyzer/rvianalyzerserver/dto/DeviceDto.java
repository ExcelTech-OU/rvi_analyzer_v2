package com.rvi.analyzer.rvianalyzerserver.dto;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class DeviceDto {
    private String createdBy;
    private String macAddress;
    private String status;
    private LocalDateTime createdDateTime;
}
