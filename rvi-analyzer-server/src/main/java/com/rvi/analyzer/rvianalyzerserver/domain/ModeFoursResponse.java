package com.rvi.analyzer.rvianalyzerserver.domain;

import com.rvi.analyzer.rvianalyzerserver.dto.ModeFourDto;
import com.rvi.analyzer.rvianalyzerserver.dto.ModeThreeDto;
import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class ModeFoursResponse {
    private String status;
    private String statusDescription;
    private List<ModeFourDto> sessions;
}
