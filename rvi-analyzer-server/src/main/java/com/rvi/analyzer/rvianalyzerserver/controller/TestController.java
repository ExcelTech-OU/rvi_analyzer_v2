//package com.rvi.analyzer.rvianalyzerserver.controller;
//
//import com.rvi.analyzer.rvianalyzerserver.domain.*;
//import com.rvi.analyzer.rvianalyzerserver.dto.MaterialDto;
//import com.rvi.analyzer.rvianalyzerserver.dto.StyleDto;
//import com.rvi.analyzer.rvianalyzerserver.dto.TestDto;
//import com.rvi.analyzer.rvianalyzerserver.dto.UserDto;
//import com.rvi.analyzer.rvianalyzerserver.service.MaterialService;
//import com.rvi.analyzer.rvianalyzerserver.service.TestService;
//import lombok.RequiredArgsConstructor;
//import org.springframework.http.ResponseEntity;
//import org.springframework.web.bind.annotation.*;
//import reactor.core.publisher.Mono;
//
//@RestController
//@RequiredArgsConstructor
//public class TestController {
//    final private TestService testService;
//
//    @PostMapping(path = "/register/test")
//    public Mono<NewTestResponse> addTest(@RequestBody TestDto testDto, @RequestHeader("Authorization") String auth) {
//        return testService.addTest(testDto, auth);
//    }
//
//    @GetMapping(path = "/rvi/analyzer/v1/tests")
//    public Mono<ResponseEntity<TestResponse>> getTests(@RequestHeader("Authorization") String auth) {
//        return testService.getTests(auth);
//    }
//}
