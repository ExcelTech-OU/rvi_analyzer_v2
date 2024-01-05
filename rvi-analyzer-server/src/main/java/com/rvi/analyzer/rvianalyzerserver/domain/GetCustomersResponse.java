package com.rvi.analyzer.rvianalyzerserver.domain;

import com.elextrone.smart_store_server.repo.entity.Customer;
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
