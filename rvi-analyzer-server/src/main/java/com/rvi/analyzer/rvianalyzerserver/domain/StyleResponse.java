package com.rvi.analyzer.rvianalyzerserver.domain;

import com.rvi.analyzer.rvianalyzerserver.dto.CustomerDto;
import com.rvi.analyzer.rvianalyzerserver.dto.StyleDto;
import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class StyleResponse {
    private String status;
    private String statusDescription;
    private List<StyleDto> styles;

    public static StyleResponse success() {
        return StyleResponse.builder().
                status("S2000")
                .statusDescription("Request was success")
                .build();
    }

    public static StyleResponse fail() {
        return StyleResponse.builder()
                .status("E1000")
                .statusDescription("Request was failed")
                .build();
    }
}
