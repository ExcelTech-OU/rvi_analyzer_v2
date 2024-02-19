//package com.rvi.analyzer.rvianalyzerserver.service;
//
//import com.rvi.analyzer.rvianalyzerserver.domain.NewPlantResponse;
//import com.rvi.analyzer.rvianalyzerserver.domain.NewUserResponse;
//import com.rvi.analyzer.rvianalyzerserver.domain.PlantResponse;
//import com.rvi.analyzer.rvianalyzerserver.domain.UserRoles;
//import com.rvi.analyzer.rvianalyzerserver.dto.MaterialDto;
//import com.rvi.analyzer.rvianalyzerserver.dto.PlantDto;
//import com.rvi.analyzer.rvianalyzerserver.entiy.User;
//import com.rvi.analyzer.rvianalyzerserver.mappers.PlantMapper;
//import com.rvi.analyzer.rvianalyzerserver.repository.PlantRepository;
//import com.rvi.analyzer.rvianalyzerserver.repository.UserRepository;
//import com.rvi.analyzer.rvianalyzerserver.security.JwtUtils;
//import lombok.RequiredArgsConstructor;
//import lombok.extern.slf4j.Slf4j;
//import org.springframework.http.HttpStatus;
//import org.springframework.http.ResponseEntity;
//import org.springframework.stereotype.Service;
//import reactor.core.publisher.Mono;
//
//import java.time.LocalDateTime;
//
//@Service
//@RequiredArgsConstructor
//@Slf4j
//public class PlantService {
//
//    final PlantRepository plantRepository;
//    final private UserRepository userRepository;
//    final private PlantMapper plantMapper;
//    final private JwtUtils jwtUtils;
//    final private UserGroupRoleService userGroupRoleService;
//
//    public Mono<NewPlantResponse> addPlant(PlantDto plantDto, String jwt) {
//        return Mono.just(plantDto)
//                .doOnNext(plantDto1 -> log.info("Plant add request received [{}]", plantDto))
//                .flatMap(request -> plantRepository.findByName(request.getName()))
//                .flatMap(plant -> Mono.just(NewPlantResponse.builder()
//                        .status("E1002")
//                        .statusDescription("Plant Already exists")
//                        .build()))
//                .switchIfEmpty(
//                        createPlant(plantDto, jwtUtils.getUsername(jwt))
//                )
//                .doOnError(e ->
//                        NewPlantResponse.builder()
//                                .status("E1000")
//                                .statusDescription("Failed")
//                                .build());
//    }
//
//    private Mono<NewPlantResponse> createPlant(PlantDto plantDto, String username) {
//        return userRepository.findByUsername(username)
//                .flatMap(creatingPlant -> userGroupRoleService.getUserRolesByUserGroup(creatingPlant.getGroup())
//                        .flatMap(userRoles -> {
//                            log.info(plantDto.getName());
//                            if (userRoles.contains(UserRoles.CREATE_PLANT)) {
//                                return save(plantDto, username);
//                            } else {
//                                return Mono.just(NewPlantResponse.builder()
//                                        .status("E1200")
//                                        .statusDescription("You are not authorized to use this service").build());
//                            }
//                        }));
//    }
//
//    private Mono<NewPlantResponse> save(PlantDto plantDto, String username) {
//        return Mono.just(plantDto)
//                .map(plantMapper::plantDtoToPlant)
//                .doOnNext(plant -> {
//                    plant.setName(plantDto.getName());
//                    plant.setCreatedBy(username);
//                    plant.setCreatedDateTime(LocalDateTime.now());
//                    plant.setLastUpdatedDateTime(LocalDateTime.now());
//                })
//                .flatMap(plantRepository::insert)
//                .doOnSuccess(plant -> log.info("Successfully saved the plant [{}]", plant))
//                .map(plant -> NewPlantResponse.builder()
//                        .status("S1000")
//                        .statusDescription("Success")
//                        .name(plantDto.getName())
//                        .build());
//    }
//
//
//    public Mono<ResponseEntity<PlantResponse>> getPlants(String auth) {
//        log.info("get plants request received with jwt [{}]", auth);
//        return userRepository.findByUsername(jwtUtils.getUsername(auth))
//                .flatMap(requestedUser -> userGroupRoleService.getUserRolesByUserGroup(requestedUser.getGroup())
//                        .flatMap(userRoles -> {
//                            if (userRoles.contains(UserRoles.GET_ALL_PLANTS)) {
//                                return plantRepository.findAll()
//                                        .map(
//                                                plant -> {
//                                                    return PlantDto.builder()
//                                                            ._id(plant.get_id())
//                                                            .name(plant.getName())
//                                                            .createdBy(plant.getCreatedBy())
//                                                            .lastUpdatedDateTime(plant.getLastUpdatedDateTime())
//                                                            .createdDateTime(plant.getCreatedDateTime())
//                                                            .build();
//                                                }
//                                        )
//                                        .collectList()
//                                        .flatMap(plantDtos -> Mono.just(ResponseEntity.ok(PlantResponse.builder()
//                                                .status("S1000")
//                                                .statusDescription("Success")
//                                                .plants(plantDtos)
//                                                .build()
//                                        )));
//                            } else {
//                                return Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(PlantResponse.builder()
//                                        .status("E1200")
//                                        .statusDescription("You are not authorized to use this service").build()));
//                            }
//                        })
//                )
//                .switchIfEmpty(Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(PlantResponse.builder()
//                        .status("E1000")
//                        .statusDescription("Failed").build())));
//    }
//
//    public Mono<PlantDto> getPlantByName(String name) {
//        return Mono.just(name)
//                .doOnNext(uName -> log.info("Finding plant for name [{}]", uName))
//                .flatMap(plantRepository::findByName)
//                .map(plantMapper::plantToPlantDto);
//    }
//}
