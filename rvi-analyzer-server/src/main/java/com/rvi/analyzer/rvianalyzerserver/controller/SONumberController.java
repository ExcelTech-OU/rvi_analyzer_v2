package com.rvi.analyzer.rvianalyzerserver.controller;

import com.rvi.analyzer.rvianalyzerserver.domain.*;
import com.rvi.analyzer.rvianalyzerserver.dto.CustomerPODto;
import com.rvi.analyzer.rvianalyzerserver.dto.SONumberDto;
import com.rvi.analyzer.rvianalyzerserver.service.CustomerPOService;
import com.rvi.analyzer.rvianalyzerserver.service.SONumberService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Mono;

@RestController
@RequiredArgsConstructor
public class SONumberController {

    final private SONumberService soNumberService;

    @PostMapping(path = "/register/soNumber")
    public Mono<NewSONumberResponse> addSONumber(@RequestBody SONumberDto soNumberDto, @RequestHeader("Authorization") String auth) {
        return soNumberService.addSONumber(soNumberDto, auth);
    }

    @GetMapping(path = "/rvi/analyzer/v1/soNumbers")
    public Mono<ResponseEntity<SONumberResponse>> getSONumbers(@RequestHeader("Authorization") String auth) {
        return soNumberService.getSONumbers(auth);
    }
}
