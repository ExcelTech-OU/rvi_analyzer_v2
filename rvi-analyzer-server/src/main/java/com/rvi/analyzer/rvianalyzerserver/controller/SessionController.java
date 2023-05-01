package com.rvi.analyzer.rvianalyzerserver.controller;


import com.rvi.analyzer.rvianalyzerserver.domain.*;
import com.rvi.analyzer.rvianalyzerserver.dto.*;
import com.rvi.analyzer.rvianalyzerserver.service.SessionService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Mono;

@RestController
@RequiredArgsConstructor
public class SessionController {

    final private SessionService sessionService;

    @PostMapping(path = "/rvi/analyzer/v1/session/add/one")
    public Mono<CommonResponse> addModeOne(@RequestBody ModeOneDto modeOneDto) {
        return sessionService.addModeOne(modeOneDto);
    }

    @GetMapping(path = "/rvi/analyzer/v1/session/get/one")
    public Mono<ModeOnesResponse> getModeOnes(@RequestHeader("Authorization") String auth) {
        return sessionService.getAllModeOne();
    }

    @PostMapping(path = "/rvi/analyzer/v1/session/add/two")
    public Mono<CommonResponse> addModeTwo(@RequestBody ModeTwoDto modeTwoDto) {
        return sessionService.addModeTwo(modeTwoDto);
    }

    @GetMapping(path = "/rvi/analyzer/v1/session/get/two")
    public Mono<ModeTwosResponse> getModeTwos() {
        return sessionService.getAllModeTwos();
    }

    @PostMapping(path = "/rvi/analyzer/v1/session/add/three")
    public Mono<CommonResponse> addModeThree(@RequestBody ModeThreeDto modeThreeDto) {
        return sessionService.addModeThree(modeThreeDto);
    }

    @GetMapping(path = "/rvi/analyzer/v1/session/get/three")
    public Mono<ModeThreesResponse> getModeThrees() {
        return sessionService.getAllModeThrees();
    }

    @PostMapping(path = "/rvi/analyzer/v1/session/add/four")
    public Mono<CommonResponse> addModeFour(@RequestBody ModeFourDto modeFourDto) {
        return sessionService.addModeFour(modeFourDto);
    }

    @GetMapping(path = "/rvi/analyzer/v1/session/get/four")
    public Mono<ModeFoursResponse> getModeFour() {
        return sessionService.getAllModeFour();
    }

    @PostMapping(path = "/rvi/analyzer/v1/session/add/five")
    public Mono<CommonResponse> addModeFive(@RequestBody ModeFiveDto modeFiveDto) {
        return sessionService.addModeFive(modeFiveDto);
    }

    @GetMapping(path = "/rvi/analyzer/v1/session/get/five")
    public Mono<ModeFiveResponse> getModeFive() {
        return sessionService.getAllModeFive();
    }

    @PostMapping(path = "/rvi/analyzer/v1/session/add/six")
    public Mono<CommonResponse> addModeFour(@RequestBody ModeSixDto modeSixDto) {
        return sessionService.addModeSix(modeSixDto);
    }

    @GetMapping(path = "/rvi/analyzer/v1/session/get/six")
    public Mono<ModeSixResponse> getModeSix() {
        return sessionService.getAllModeSix();
    }

}
