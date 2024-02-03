package com.rvi.analyzer.rvianalyzerserver.domain;

import com.rvi.analyzer.rvianalyzerserver.dto.CustomerDto;
import com.rvi.analyzer.rvianalyzerserver.dto.ProductionOrderDto;
import com.rvi.analyzer.rvianalyzerserver.dto.SONumberDto;
import com.rvi.analyzer.rvianalyzerserver.dto.StyleDto;
import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class ProductionOrderResponse {
    private String status;
    private String statusDescription;
    private List<ProductionOrderDto> orders;

    public static ProductionOrderResponse success() {
        return ProductionOrderResponse.builder().
                status("S2000")
                .statusDescription("Request was success")
                .build();
    }

    public static ProductionOrderResponse fail() {
        return ProductionOrderResponse.builder()
                .status("E1000")
                .statusDescription("Request was failed")
                .build();
    }
}
