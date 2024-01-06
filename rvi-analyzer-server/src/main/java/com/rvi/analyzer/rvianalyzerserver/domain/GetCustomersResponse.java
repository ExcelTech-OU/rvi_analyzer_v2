package com.rvi.analyzer.rvianalyzerserver.domain;
import com.rvi.analyzer.rvianalyzerserver.entiy.Customer;
import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class GetCustomersResponse {
    private String status;
    private String statusDescription;
    private List<Customer> customers;
    private int total;
}
