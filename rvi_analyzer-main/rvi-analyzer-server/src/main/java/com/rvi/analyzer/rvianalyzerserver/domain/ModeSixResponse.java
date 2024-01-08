package com.rvi.analyzer.rvianalyzerserver.domain;

import com.rvi.analyzer.rvianalyzerserver.dto.ModeSixDto;
import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class ModeSixResponse {
    private String status;
    private String statusDescription;
    private List<ModeSixDto> sessions;
    private int total;

}
