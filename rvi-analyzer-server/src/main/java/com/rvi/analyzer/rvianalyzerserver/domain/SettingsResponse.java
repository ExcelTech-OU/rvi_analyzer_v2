package com.rvi.analyzer.rvianalyzerserver.domain;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class SettingsResponse {
    private String status;
    private String statusDescription;
    private String lowerBound;
    private String upperBound;

    public static SettingsResponse success(String lowerBound, String upperBound) {
        return SettingsResponse.builder()
                .status("S2000")
                .statusDescription("Request was successful")
                .lowerBound(lowerBound)
                .upperBound(upperBound)
                .build();
    }

    public static SettingsResponse fail() {
        return SettingsResponse.builder()
                .status("E1000")
                .statusDescription("Request failed")
                .build();
    }
}
