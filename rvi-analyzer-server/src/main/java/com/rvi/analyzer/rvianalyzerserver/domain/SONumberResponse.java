package com.rvi.analyzer.rvianalyzerserver.domain;

import com.rvi.analyzer.rvianalyzerserver.dto.CustomerDto;
import com.rvi.analyzer.rvianalyzerserver.dto.SONumberDto;
import com.rvi.analyzer.rvianalyzerserver.dto.StyleDto;
import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class SONumberResponse {
    private String status;
    private String statusDescription;
    private List<SONumberDto> soNumbers;

    public static SONumberResponse success() {
        return SONumberResponse.builder().
                status("S2000")
                .statusDescription("Request was success")
                .build();
    }

    public static SONumberResponse fail() {
        return SONumberResponse.builder()
                .status("E1000")
                .statusDescription("Request was failed")
                .build();
    }
}
