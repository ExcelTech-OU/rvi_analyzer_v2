package com.rvi.analyzer.rvianalyzerserver.domain;

import com.rvi.analyzer.rvianalyzerserver.dto.*;
import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class TestResultResponse {
    private String status;
    private String statusDescription;
    private List<TestResultDto> testResults;

    public static TestResultResponse success() {
        return TestResultResponse.builder().
                status("S2000")
                .statusDescription("Request was success")
                .build();
    }

    public static TestResultResponse fail() {
        return TestResultResponse.builder()
                .status("E1000")
                .statusDescription("Request was failed")
                .build();
    }
}
