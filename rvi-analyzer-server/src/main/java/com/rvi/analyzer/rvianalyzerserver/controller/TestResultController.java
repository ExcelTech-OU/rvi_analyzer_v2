//package com.rvi.analyzer.rvianalyzerserver.controller;
//
//import com.rvi.analyzer.rvianalyzerserver.domain.*;
//import com.rvi.analyzer.rvianalyzerserver.dto.*;
//import com.rvi.analyzer.rvianalyzerserver.service.MaterialService;
//import com.rvi.analyzer.rvianalyzerserver.service.TestResultService;
//import com.rvi.analyzer.rvianalyzerserver.service.TestService;
//import lombok.RequiredArgsConstructor;
//import org.springframework.http.ResponseEntity;
//import org.springframework.web.bind.annotation.*;
//import reactor.core.publisher.Mono;
//
//@RestController
//@RequiredArgsConstructor
//public class TestResultController {
//    final private TestResultService testResultService;
//
//    @PostMapping(path = "/register/testResult")
//    public Mono<NewTestResultResponse> addTestResult(@RequestBody TestResultDto testResultDto, @RequestHeader("Authorization") String auth) {
//        return testResultService.addTestResult(testResultDto, auth);
//    }
//
//    @GetMapping(path = "/rvi/analyzer/v1/testResults")
//    public Mono<ResponseEntity<TestResultResponse>> getTestResults(@RequestHeader("Authorization") String auth) {
//        return testResultService.getTestResultss(auth);
//    }
//}
