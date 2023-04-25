package com.rvi.analyzer.rvianalyzerserver.controller;


import com.rvi.analyzer.rvianalyzerserver.domain.CommonResponse;
import com.rvi.analyzer.rvianalyzerserver.domain.ModeOnesResponse;
import com.rvi.analyzer.rvianalyzerserver.domain.ModeThreesResponse;
import com.rvi.analyzer.rvianalyzerserver.domain.ModeTwosResponse;
import com.rvi.analyzer.rvianalyzerserver.dto.*;
import com.rvi.analyzer.rvianalyzerserver.service.SessionService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import reactor.core.publisher.Mono;

@RestController
@RequiredArgsConstructor
public class SessionController {

    final private SessionService sessionService;

    @PostMapping(path = "/rvi/analyzer/v1/session/add/one")
    public Mono<CommonResponse> addModeOne(@RequestBody ModeOneDto modeOneDto){
        return sessionService.addModeOne(modeOneDto);
    }

    @GetMapping(path = "/rvi/analyzer/v1/session/get/one")
    public Mono<ModeOnesResponse> getModeOnes(){
        return sessionService.getAllModeOne();
    }

    @PostMapping(path = "/rvi/analyzer/v1/session/add/two")
    public Mono<CommonResponse> addModeTwo(@RequestBody ModeTwoDto modeTwoDto){
        return sessionService.addModeTwo(modeTwoDto);
    }

    @GetMapping(path = "/rvi/analyzer/v1/session/get/two")
    public Mono<ModeTwosResponse> getModeTwos(){
        return sessionService.getAllModeTwos();
    }

    @PostMapping(path = "/rvi/analyzer/v1/session/add/three")
    public Mono<CommonResponse> addModeThree(@RequestBody ModeThreeDto modeThreeDto){
        return sessionService.addModeThree(modeThreeDto);
    }

    @GetMapping(path = "/rvi/analyzer/v1/session/get/three")
    public Mono<ModeThreesResponse> getModeThrees(){
        return sessionService.getAllModeThrees();
    }

    @PostMapping(path = "/rvi/analyzer/v1/session/add/four")
    public Mono<CommonResponse> addModeFour(@RequestBody ModeFourDto modeFourDto){
        return sessionService.addModeFour(modeFourDto);
    }
    @PostMapping(path = "/rvi/analyzer/v1/session/add/five")
    public Mono<CommonResponse> addModeFive(@RequestBody ModeFiveDto modeFiveDto){
        return sessionService.addModeFive(modeFiveDto);
    }

    @PostMapping(path = "/rvi/analyzer/v1/session/add/six")
    public Mono<CommonResponse> addModeFour(@RequestBody ModeSixDto modeSixDto){
        return sessionService.addModeSix(modeSixDto);
    }

}
