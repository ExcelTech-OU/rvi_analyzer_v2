package com.rvi.analyzer.rvianalyzerserver.domain;

import com.rvi.analyzer.rvianalyzerserver.dto.CustomerDto;
import com.rvi.analyzer.rvianalyzerserver.dto.MaterialDto;
import com.rvi.analyzer.rvianalyzerserver.dto.StyleDto;
import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class MaterialResponse {
    private String status;
    private String statusDescription;
    private List<MaterialDto> materials;

    public static MaterialResponse success() {
        return MaterialResponse.builder().
                status("S2000")
                .statusDescription("Request was success")
                .build();
    }

    public static MaterialResponse fail() {
        return MaterialResponse.builder()
                .status("E1000")
                .statusDescription("Request was failed")
                .build();
    }
}
