package com.rvi.analyzer.rvianalyzerserver.domain;

import com.rvi.analyzer.rvianalyzerserver.dto.*;
import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class ParameterResponse {
    private String status;
    private String statusDescription;
    private List<ParameterDto> parameters;

    public static ParameterResponse success() {
        return ParameterResponse.builder().
                status("S2000")
                .statusDescription("Request was success")
                .build();
    }

    public static ParameterResponse fail() {
        return ParameterResponse.builder()
                .status("E1000")
                .statusDescription("Request was failed")
                .build();
    }
}
