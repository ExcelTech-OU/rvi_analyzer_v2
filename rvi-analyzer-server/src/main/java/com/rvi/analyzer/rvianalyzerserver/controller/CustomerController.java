package com.rvi.analyzer.rvianalyzerserver.controller;

import com.rvi.analyzer.rvianalyzerserver.domain.CommonResponse;
import com.rvi.analyzer.rvianalyzerserver.domain.CustomerUpdateRequest;
import com.rvi.analyzer.rvianalyzerserver.domain.CustomersResponse;
import com.rvi.analyzer.rvianalyzerserver.domain.NewCustomerResponse;
import com.rvi.analyzer.rvianalyzerserver.dto.CustomerDto;
import com.rvi.analyzer.rvianalyzerserver.service.CustomerService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Mono;

@RestController
@RequiredArgsConstructor
public class CustomerController {

    final private CustomerService customerService;

    @PostMapping(path = "/register/customer")
    public Mono<NewCustomerResponse> addCustomer(@RequestBody CustomerDto customerDto, @RequestHeader("Authorization") String auth) {
        return customerService.addCustomer(customerDto, auth);
    }

    @GetMapping(path = "/rvi/analyzer/v1/customers")
    public Mono<ResponseEntity<CustomersResponse>> getCustomers(@RequestHeader("Authorization") String auth) {
        return customerService.getCustomers(auth);
    }
}
