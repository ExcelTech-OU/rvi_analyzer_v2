package com.rvi.analyzer.rvianalyzerserver.domain;

import com.rvi.analyzer.rvianalyzerserver.dto.CustomerDto;
import com.rvi.analyzer.rvianalyzerserver.dto.CustomerPODto;
import com.rvi.analyzer.rvianalyzerserver.dto.StyleDto;
import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class CustomerPOResponse {
    private String status;
    private String statusDescription;
    private List<CustomerPODto> customerPOs;

    public static CustomerPOResponse success() {
        return CustomerPOResponse.builder().
                status("S2000")
                .statusDescription("Request was success")
                .build();
    }

    public static CustomerPOResponse fail() {
        return CustomerPOResponse.builder()
                .status("E1000")
                .statusDescription("Request was failed")
                .build();
    }
}
