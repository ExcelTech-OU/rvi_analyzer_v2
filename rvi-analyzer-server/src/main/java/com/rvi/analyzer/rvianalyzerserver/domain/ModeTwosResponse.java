package com.rvi.analyzer.rvianalyzerserver.domain;

import com.rvi.analyzer.rvianalyzerserver.dto.ModeTwoDto;
import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class ModeTwosResponse {
    private String status;
    private String statusDescription;
    private List<ModeTwoDto> sessions;
    private int total;

}
