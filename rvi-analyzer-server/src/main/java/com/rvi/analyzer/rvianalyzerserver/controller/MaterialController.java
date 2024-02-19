//package com.rvi.analyzer.rvianalyzerserver.controller;
//
//import com.rvi.analyzer.rvianalyzerserver.domain.MaterialResponse;
//import com.rvi.analyzer.rvianalyzerserver.domain.NewMaterialResponse;
//import com.rvi.analyzer.rvianalyzerserver.dto.MaterialDto;
//import com.rvi.analyzer.rvianalyzerserver.service.MaterialService;
//import lombok.RequiredArgsConstructor;
//import org.springframework.http.ResponseEntity;
//import org.springframework.web.bind.annotation.*;
//import reactor.core.publisher.Mono;
//
//@RestController
//@RequiredArgsConstructor
//public class MaterialController {
//    final private MaterialService materialService;
//
//    @PostMapping(path = "/register/material")
//    public Mono<NewMaterialResponse> addMaterial(@RequestBody MaterialDto materialDto, @RequestHeader("Authorization") String auth) {
//        return materialService.addMaterial(materialDto, auth);
//    }
//
//    @GetMapping(path = "/rvi/analyzer/v1/materials")
//    public Mono<ResponseEntity<MaterialResponse>> getMaterials(@RequestHeader("Authorization") String auth) {
//        return materialService.getMaterials(auth);
//    }
//
//    @GetMapping(path = "/rvi/analyzer/v1/material")
//    public Mono<MaterialDto> getMaterialInfo(@RequestBody MaterialDto materialDto) {
//        return materialService.getMaterialByName(materialDto.getName());
//    }
//
//    @GetMapping(path = "/rvi/analyzer/v1/checkMaterial")
//    public Mono<Boolean> checkMaterialExists(@RequestBody MaterialDto materialDto) {
//        return materialService.existsMaterialByName(materialDto.getName());
//    }
//
//}
