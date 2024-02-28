package com.rvi.analyzer.rvianalyzerserver.domain;

import com.rvi.analyzer.rvianalyzerserver.dto.ModeSevenDto;
import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class ModeSevenResponse {
    private String status;
    private String statusDescription;
    private List<ModeSevenDto> sessions;
}
