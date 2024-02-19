//package com.rvi.analyzer.rvianalyzerserver.controller;
//
//import com.rvi.analyzer.rvianalyzerserver.domain.NewPlantResponse;
//import com.rvi.analyzer.rvianalyzerserver.domain.PlantResponse;
//import com.rvi.analyzer.rvianalyzerserver.dto.PlantDto;
//import com.rvi.analyzer.rvianalyzerserver.service.PlantService;
//import lombok.RequiredArgsConstructor;
//import org.springframework.http.ResponseEntity;
//import org.springframework.web.bind.annotation.*;
//import reactor.core.publisher.Mono;
//
//@RestController
//@RequiredArgsConstructor
//public class PlantController {
//
//    final private PlantService plantService;
//
//    @PostMapping(path = "/register/plant")
//    public Mono<NewPlantResponse> addPlant(@RequestBody PlantDto plantDto, @RequestHeader("Authorization") String auth) {
//        return plantService.addPlant(plantDto, auth);
//    }
//
//    @GetMapping(path = "/rvi/analyzer/v1/plants")
//    public Mono<ResponseEntity<PlantResponse>> getPlants(@RequestHeader("Authorization") String auth) {
//        return plantService.getPlants(auth);
//    }
//}
