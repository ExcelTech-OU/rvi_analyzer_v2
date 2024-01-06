package com.rvi.analyzer.rvianalyzerserver.controller;

import com.rvi.analyzer.rvianalyzerserver.domain.NewCustomerResponse;
import com.rvi.analyzer.rvianalyzerserver.dto.CustomerDto;
import com.rvi.analyzer.rvianalyzerserver.service.CustomerService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RestController;
import reactor.core.publisher.Mono;

@RestController
@RequiredArgsConstructor
public class CustomerController {

    final private CustomerService customerService;

    @PostMapping(path = "/register/customer")
    public Mono<NewCustomerResponse> addCustomer(@RequestBody CustomerDto customerDto, @RequestHeader("Authorization") String auth) {
        return customerService.addCustomer(customerDto, auth);
    }

//    @GetMapping(path = "/rvi/analyzer/v1/customers")
//    public Mono<ResponseEntity<UsersResponse>> getUsers(@RequestHeader("Authorization") String auth) {
//        return customerService.getCustomers(auth);
//    }
}
