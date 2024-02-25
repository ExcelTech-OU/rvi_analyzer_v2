package com.rvi.analyzer.rvianalyzerserver.controller;

import com.rvi.analyzer.rvianalyzerserver.domain.NewRMTrackingResponse;
import com.rvi.analyzer.rvianalyzerserver.domain.RMTrackingResponse;
import com.rvi.analyzer.rvianalyzerserver.dto.RMTrackingDto;
import com.rvi.analyzer.rvianalyzerserver.service.RMTrackingService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Mono;

@RestController
@RequiredArgsConstructor
public class RMTrackingController {
    final private RMTrackingService rmTrackingService;

    @PostMapping(path = "/register/rmTracking")
    public Mono<NewRMTrackingResponse> addRMTracking(@RequestBody RMTrackingDto rmTrackingDto, @RequestHeader("Authorization") String auth) {
        return rmTrackingService.addRMTracking(rmTrackingDto, auth);
    }

    @GetMapping(path = "/rvi/analyzer/v1/rmTrackings")
    public Mono<ResponseEntity<RMTrackingResponse>> getRMTrackings(@RequestHeader("Authorization") String auth) {
        return rmTrackingService.getRMTrackings(auth);
    }

    @GetMapping(path = "/rvi/analyzer/v1/rmTracking/{userId}")
    public Mono<RMTrackingDto> getRMTrackingInfo(@PathVariable String userId) {
        return rmTrackingService.getRMTrackingByUserId(userId);
    }
}
