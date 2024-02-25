package com.rvi.analyzer.rvianalyzerserver.controller;

import com.rvi.analyzer.rvianalyzerserver.domain.CustomerPOResponse;
import com.rvi.analyzer.rvianalyzerserver.domain.NewCustomerPOResponse;
import com.rvi.analyzer.rvianalyzerserver.dto.CustomerPODto;
import com.rvi.analyzer.rvianalyzerserver.service.CustomerPOService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Mono;

@RestController
@RequiredArgsConstructor
public class CustomerPOController {

    final private CustomerPOService customerPOService;

    @PostMapping(path = "/register/customerPO")
    public Mono<NewCustomerPOResponse> addCustomerPO(@RequestBody CustomerPODto customerPODto, @RequestHeader("Authorization") String auth) {
        return customerPOService.addCustomerPO(customerPODto, auth);
    }

    @GetMapping(path = "/rvi/analyzer/v1/customerPOs")
    public Mono<ResponseEntity<CustomerPOResponse>> getCustomerPOs(@RequestHeader("Authorization") String auth) {
        return customerPOService.getCustomerPOs(auth);
    }

    @GetMapping(path = "/rvi/analyzer/v1/customerPO/{name}")
    public Mono<CustomerPODto> getCustomerPOInfo(@PathVariable String name) {
        return customerPOService.getCustomerPOByName(name);
    }
}
