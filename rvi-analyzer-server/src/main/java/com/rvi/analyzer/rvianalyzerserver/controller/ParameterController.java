package com.rvi.analyzer.rvianalyzerserver.controller;

import com.rvi.analyzer.rvianalyzerserver.domain.*;
import com.rvi.analyzer.rvianalyzerserver.dto.*;
import com.rvi.analyzer.rvianalyzerserver.service.MaterialService;
import com.rvi.analyzer.rvianalyzerserver.service.ParameterService;
import com.rvi.analyzer.rvianalyzerserver.service.TestResultService;
import com.rvi.analyzer.rvianalyzerserver.service.TestService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Mono;

@RestController
@RequiredArgsConstructor
public class ParameterController {
    final private ParameterService parameterService;

    @PostMapping(path = "/register/parameter")
    public Mono<NewParameterResponse> addParameter(@RequestBody ParameterDto parameterDto, @RequestHeader("Authorization") String auth) {
        return parameterService.addParameter(parameterDto, auth);
    }

    @GetMapping(path = "/rvi/analyzer/v1/parameters")
    public Mono<ResponseEntity<ParameterResponse>> getParameters(@RequestHeader("Authorization") String auth) {
        return parameterService.getParameters(auth);
    }
}
