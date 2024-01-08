package com.rvi.analyzer.rvianalyzerserver.dto;

import com.rvi.analyzer.rvianalyzerserver.entiy.Reading;
import lombok.Builder;
import lombok.Data;

import java.util.List;

@Builder
@Data
public class SessionResultDto {
    private String testId;
    private List<Reading> readings;
}
