package com.rvi.analyzer.rvianalyzerserver.domain;

import com.rvi.analyzer.rvianalyzerserver.dto.CustomerDto;
import com.rvi.analyzer.rvianalyzerserver.dto.MaterialDto;
import com.rvi.analyzer.rvianalyzerserver.dto.StyleDto;
import com.rvi.analyzer.rvianalyzerserver.dto.TestDto;
import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class TestResponse {
    private String status;
    private String statusDescription;
    private List<TestDto> tests;

    public static TestResponse success() {
        return TestResponse.builder().
                status("S2000")
                .statusDescription("Request was success")
                .build();
    }

    public static TestResponse fail() {
        return TestResponse.builder()
                .status("E1000")
                .statusDescription("Request was failed")
                .build();
    }
}
