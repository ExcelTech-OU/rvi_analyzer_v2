package com.rvi.analyzer.rvianalyzerserver.domain;

import com.rvi.analyzer.rvianalyzerserver.dto.ModeFiveDto;
import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class ModeFiveResponse {
    private String status;
    private String statusDescription;
    private List<ModeFiveDto> sessions;
}
