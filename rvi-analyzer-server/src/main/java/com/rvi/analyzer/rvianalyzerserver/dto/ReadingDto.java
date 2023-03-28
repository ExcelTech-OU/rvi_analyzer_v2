package com.rvi.analyzer.rvianalyzerserver.dto;

import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class ReadingDto {
    private String temperature;
    private String current;
    private String voltage;
    private String maxCurrent;
    private String result;
}
