package com.rvi.analyzer.rvianalyzerserver.dto;

import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;

@Builder
@Data
public class ModeSevenDto {
    private String _id;
    private String macAddress;
    private String voltage;
    private String current;
    private String resistance;
    private String result;
    private String customer;
    private String serialNumber;
    private String testId;
    private LocalDateTime createdDateTime;
}
