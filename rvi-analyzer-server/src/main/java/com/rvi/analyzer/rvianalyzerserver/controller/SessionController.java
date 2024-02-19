//package com.rvi.analyzer.rvianalyzerserver.controller;
//
//import com.fasterxml.jackson.annotation.JsonInclude;
//import com.rvi.analyzer.rvianalyzerserver.domain.*;
//import com.rvi.analyzer.rvianalyzerserver.dto.*;
//import com.rvi.analyzer.rvianalyzerserver.service.SessionService;
//import lombok.RequiredArgsConstructor;
//import org.springframework.http.ResponseEntity;
//import org.springframework.web.bind.annotation.*;
//import reactor.core.publisher.Mono;
//
//@RestController
//@RequiredArgsConstructor
//public class SessionController {
//
//    final private SessionService sessionService;
//
//    @PostMapping(path = "/rvi/analyzer/v1/session/add/one")
//    public Mono<ResponseEntity<CommonResponse>> addModeOne(@RequestBody ModeOneDto modeOneDto,
//                                                           @RequestHeader("Authorization") String jwt) {
//        return sessionService.addModeOne(modeOneDto, jwt);
//    }
//
//    @PostMapping(path = "/rvi/analyzer/v1/session/get/one/{pageNo}")
//    public Mono<ResponseEntity<ModeOnesResponse>> getModeOnes(@PathVariable("pageNo") String pageNo,
//                                                              @RequestBody SessionSearchRequest request,
//                                                              @RequestHeader("Authorization") String auth) {
//        return sessionService.getAllModeOne(pageNo, request, auth);
//    }
//
//    @GetMapping(path = "/rvi/analyzer/v1/session/get/last/one")
//    public Mono<ResponseEntity<ModeOnesResponse>> getLastModeOne(@RequestHeader("Authorization") String auth) {
//        return sessionService.getLastModeOne(auth);
//    }
//
//    @GetMapping(path = "/rvi/analyzer/v1/session/share/{mode}/{sessionId}")
//    public Mono<ResponseEntity<ShareReportResponse>> shareReport(@PathVariable("mode") String mode,
//                                                                 @PathVariable("sessionId") String sessionId,
//                                                              @RequestHeader("Authorization") String auth) {
//        return sessionService.shareReport(mode, sessionId, auth);
//    }
//
//    @PostMapping(path = "/rvi/analyzer/v1/session/add/two")
//    public Mono<ResponseEntity<CommonResponse>> addModeTwo(@RequestBody ModeTwoDto modeTwoDto,
//                                                           @RequestHeader("Authorization") String jwt) {
//        return sessionService.addModeTwo(modeTwoDto, jwt);
//    }
//
//    @PostMapping(path = "/rvi/analyzer/v1/session/get/two/{pageNo}")
//    public Mono<ResponseEntity<ModeTwosResponse>> getModeTwos(@PathVariable("pageNo") String pageNo,
//                                                              @RequestBody SessionSearchRequest request,
//                                                              @RequestHeader("Authorization") String jwt) {
//        return sessionService.getAllModeTwos(pageNo, request, jwt);
//    }
//
//    @GetMapping(path = "/rvi/analyzer/v1/session/get/last/two")
//    public Mono<ResponseEntity<ModeTwosResponse>> getModeTwos(@RequestHeader("Authorization") String jwt) {
//        return sessionService.getLastModeTwo(jwt);
//    }
//
//    @PostMapping(path = "/rvi/analyzer/v1/session/add/three")
//    public Mono<ResponseEntity<CommonResponse>> addModeThree(@RequestBody ModeThreeDto modeThreeDto,
//                                                             @RequestHeader("Authorization") String jwt) {
//        return sessionService.addModeThree(modeThreeDto, jwt);
//    }
//
//    @PostMapping(path = "/rvi/analyzer/v1/session/get/three/{pageNo}")
//    public Mono<ResponseEntity<ModeThreesResponse>> getModeThrees(@PathVariable("pageNo") String pageNo,
//                                                                  @RequestBody SessionSearchRequest request,
//                                                                  @RequestHeader("Authorization") String jwt) {
//        return sessionService.getAllModeThrees(pageNo, request, jwt);
//    }
//
//    @GetMapping(path = "/rvi/analyzer/v1/session/get/last/three")
//    public Mono<ResponseEntity<ModeThreesResponse>> getLastModeThree(@RequestHeader("Authorization") String jwt) {
//        return sessionService.getLastModeThree(jwt);
//    }
//
//    @PostMapping(path = "/rvi/analyzer/v1/session/add/four")
//    public Mono<ResponseEntity<CommonResponse>> addModeFour(@RequestBody ModeFourDto modeFourDto,
//                                                            @RequestHeader("Authorization") String jwt) {
//        return sessionService.addModeFour(modeFourDto, jwt);
//    }
//
//    @PostMapping(path = "/rvi/analyzer/v1/session/get/four/{pageNo}")
//    public Mono<ResponseEntity<ModeFoursResponse>> getModeFour(@PathVariable("pageNo") String pageNo,
//                                                               @RequestBody SessionSearchRequest request,
//                                                               @RequestHeader("Authorization") String jwt) {
//        return sessionService.getAllModeFour(pageNo, request, jwt);
//    }
//
//    @GetMapping(path = "/rvi/analyzer/v1/session/get/last/four")
//    public Mono<ResponseEntity<ModeFoursResponse>> getLastModeFour(@RequestHeader("Authorization") String jwt) {
//        return sessionService.getLastModeFour(jwt);
//    }
//
//    @PostMapping(path = "/rvi/analyzer/v1/session/add/five")
//    public Mono<ResponseEntity<CommonResponse>> addModeFive(@RequestBody ModeFiveDto modeFiveDto,
//                                                            @RequestHeader("Authorization") String jwt) {
//        return sessionService.addModeFive(modeFiveDto, jwt);
//    }
//
//    @PostMapping(path = "/rvi/analyzer/v1/session/get/five/{pageNo}")
//    public Mono<ResponseEntity<ModeFiveResponse>> getModeFive(@PathVariable("pageNo") String pageNo,
//                                                              @RequestBody SessionSearchRequest request,
//                                                              @RequestHeader("Authorization") String jwt) {
//        return sessionService.getAllModeFive(pageNo, request, jwt);
//    }
//
//    @GetMapping(path = "/rvi/analyzer/v1/session/get/last/five")
//    public Mono<ResponseEntity<ModeFiveResponse>> getLastModeFive(@RequestHeader("Authorization") String jwt) {
//        return sessionService.getLastModeFive(jwt);
//    }
//
//    @PostMapping(path = "/rvi/analyzer/v1/session/add/six")
//    public Mono<ResponseEntity<CommonResponse>> addModeFour(@RequestBody ModeSixDto modeSixDto,
//                                                            @RequestHeader("Authorization") String jwt) {
//        return sessionService.addModeSix(modeSixDto, jwt);
//    }
//
//    @PostMapping(path = "/rvi/analyzer/v1/session/get/six/{pageNo}")
//    public Mono<ResponseEntity<ModeSixResponse>> getModeSix(@PathVariable("pageNo") String pageNo,
//                                                            @RequestBody SessionSearchRequest request,
//                                                            @RequestHeader("Authorization") String jwt) {
//        return sessionService.getAllModeSix(pageNo, request, jwt);
//    }
//
//    @GetMapping(path = "/rvi/analyzer/v1/session/get/last/six")
//    public Mono<ResponseEntity<ModeSixResponse>> getLastModeSix(@RequestHeader("Authorization") String jwt) {
//        return sessionService.getLastModeSix(jwt);
//    }
//
//    @GetMapping(path = "/report/status/{hash}")
//    public Mono<ResponseEntity<CommonResponse>> checkReportStatus(@PathVariable("hash") String hash) {
//        return sessionService.checkReportStatus(hash);
//    }
//
//    @PostMapping(path = "/report/status/password/{hash}")
//    public Mono<ResponseEntity<PasswordValidationReportResponse>> checkReportStatus(@PathVariable("hash") String hash,
//                                                                  @RequestBody ReportPasswordValidationRequest request) {
//        return sessionService.checkReportPassword(hash, request);
//    }
//}
