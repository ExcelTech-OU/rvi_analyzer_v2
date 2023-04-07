package com.rvi.analyzer.rvianalyzerserver.dto;

import lombok.Builder;
import lombok.Data;

import java.util.Date;

@Builder
@Data
public class ReadingDto {
    private String temperature;
    private String current;
    private String voltage;
    private String result;
    private String readAt;
}
