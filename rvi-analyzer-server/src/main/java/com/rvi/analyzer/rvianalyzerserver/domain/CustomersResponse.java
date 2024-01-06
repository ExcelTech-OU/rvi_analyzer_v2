package com.rvi.analyzer.rvianalyzerserver.domain;

import com.rvi.analyzer.rvianalyzerserver.dto.CustomerDto;
import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class CustomersResponse {
    private String status;
    private String statusDescription;
    private List<CustomerDto> customers;

    public static CustomersResponse success() {
        return CustomersResponse.builder().
                status("S2000")
                .statusDescription("Request was success")
                .build();
    }

    public static CustomersResponse fail() {
        return CustomersResponse.builder()
                .status("E1000")
                .statusDescription("Request was failed")
                .build();
    }
}
