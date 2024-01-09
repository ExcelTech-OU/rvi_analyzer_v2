package com.rvi.analyzer.rvianalyzerserver.domain;

import com.rvi.analyzer.rvianalyzerserver.dto.PlantDto;
import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class PlantResponse {
    private String status;
    private String statusDescription;
    private List<PlantDto> plants;

    public static PlantResponse success() {
        return PlantResponse.builder().
                status("S2000")
                .statusDescription("Request was success")
                .build();
    }

    public static PlantResponse fail() {
        return PlantResponse.builder()
                .status("E1000")
                .statusDescription("Request was failed")
                .build();
    }
}
