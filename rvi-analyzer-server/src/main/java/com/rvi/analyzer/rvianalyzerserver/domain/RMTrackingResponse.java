package com.rvi.analyzer.rvianalyzerserver.domain;

import com.rvi.analyzer.rvianalyzerserver.dto.*;
import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class RMTrackingResponse {
    private String status;
    private String statusDescription;
    private List<RMTrackingDto> rmTrackings;

    public static RMTrackingResponse success() {
        return RMTrackingResponse.builder().
                status("S2000")
                .statusDescription("Request was success")
                .build();
    }

    public static RMTrackingResponse fail() {
        return RMTrackingResponse.builder()
                .status("E1000")
                .statusDescription("Request was failed")
                .build();
    }
}
