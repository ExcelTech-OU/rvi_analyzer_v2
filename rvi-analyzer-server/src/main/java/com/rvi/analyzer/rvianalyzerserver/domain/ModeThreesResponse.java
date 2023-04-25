package com.rvi.analyzer.rvianalyzerserver.domain;

import com.rvi.analyzer.rvianalyzerserver.dto.ModeThreeDto;
import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class ModeThreesResponse {
    private String status;
    private String statusDescription;
    private List<ModeThreeDto> sessions;
}
