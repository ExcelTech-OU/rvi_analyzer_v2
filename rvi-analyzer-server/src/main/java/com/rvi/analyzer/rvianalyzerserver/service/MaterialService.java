package com.rvi.analyzer.rvianalyzerserver.service;

import com.rvi.analyzer.rvianalyzerserver.domain.*;
import com.rvi.analyzer.rvianalyzerserver.dto.MaterialDto;
import com.rvi.analyzer.rvianalyzerserver.dto.StyleDto;
import com.rvi.analyzer.rvianalyzerserver.dto.UserDto;
import com.rvi.analyzer.rvianalyzerserver.mappers.MaterialMapper;
import com.rvi.analyzer.rvianalyzerserver.repository.MaterialRepository;
import com.rvi.analyzer.rvianalyzerserver.repository.UserRepository;
import com.rvi.analyzer.rvianalyzerserver.security.JwtUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Mono;

import java.time.LocalDateTime;
import java.util.ArrayList;

import static org.yaml.snakeyaml.DumperOptions.ScalarStyle.createStyle;

@Service
@RequiredArgsConstructor
@Slf4j
public class MaterialService {
    final private UserRepository userRepository;
    final private MaterialRepository materialRepository;
    final private JwtUtils jwtUtils;
    final private UserGroupRoleService userGroupRoleService;
    final private MaterialMapper materialMapper;

    public Mono<NewMaterialResponse> addMaterial(MaterialDto materialDto, String jwt) {
        return Mono.just(materialDto)
                .doOnNext(materialDto1 -> log.info("Material add request received [{}]", materialDto))
                .flatMap(request -> materialRepository.findByName(request.getName()))
                .flatMap(style -> Mono.just(NewMaterialResponse.builder()
                        .status("E1002")
                        .statusDescription("Material Already exists")
                        .build()))
                .switchIfEmpty(
                        createMaterial(materialDto, jwtUtils.getUsername(jwt))
                )
                .doOnError(e ->
                        NewMaterialResponse.builder()
                                .status("E1000")
                                .statusDescription("Failed")
                                .build());
    }

    private Mono<NewMaterialResponse> createMaterial(MaterialDto materialDto, String username) {
        return userRepository.findByUsername(username)
                .flatMap(creatingStyle -> userGroupRoleService.getUserRolesByUserGroup(creatingStyle.getGroup())
                        .flatMap(userRoles -> {
                            log.info(materialDto.getName());
                            if (userRoles.contains(UserRoles.CREATE_TOP_ADMIN)) {
                                return save(materialDto, username);
                            } else {
                                return Mono.just(NewMaterialResponse.builder()
                                        .status("E1200")
                                        .statusDescription("You are not authorized to use this service").build());
                            }
                        }));
    }

    private Mono<NewMaterialResponse> save(MaterialDto materialDto, String username) {
        return Mono.just(materialDto)
                .map(materialMapper::materialDtoToMaterial)
                .doOnNext(material -> {
                    material.setName(materialDto.getName());
                    material.setCustomer(materialDto.getCustomer() != null ? materialDto.getCustomer() : "UN-ASSIGNED");
                    material.setPlant(materialDto.getPlant() != null ? materialDto.getPlant() : "UN-ASSIGNED");
                    material.setStyle(materialDto.getStyle() != null ? materialDto.getStyle() : "UN-ASSIGNED");
//                    material.setAdmin(styleDto.getAdmin() != null ? styleDto.getAdmin() : new ArrayList<>());
//                    style.setPlant("UN-ASSIGNED");
//                    style.setCustomer("UN-ASSIGNED");
                    material.setCreatedBy(username);
                    material.setCreatedDateTime(LocalDateTime.now());
                })
                .flatMap(materialRepository::insert)
                .doOnSuccess(material -> log.info("Successfully saved the material [{}]", material))
                .map(material -> NewMaterialResponse.builder()
                        .status("S1000")
                        .statusDescription("Success")
                        .name(materialDto.getName())
                        .build());
    }

    public Mono<ResponseEntity<MaterialResponse>> getMaterials(String auth) {
        log.info("get materials request received with jwt [{}]", auth);
        return userRepository.findByUsername(jwtUtils.getUsername(auth))
                .flatMap(requestedUser -> userGroupRoleService.getUserRolesByUserGroup(requestedUser.getGroup())
                        .flatMap(userRoles -> {
                            if (userRoles.contains(UserRoles.LOGIN_WEB)) {
                                return materialRepository.findAll()
                                        .map(material -> {
                                            return MaterialDto.builder()
                                                    ._id(material.get_id())
                                                    .plant(material.getPlant())
                                                    .customer(material.getCustomer())
                                                    .style(material.getStyle())
                                                    .name(material.getName())
                                                    .createdBy(material.getCreatedBy())
                                                    .createdDateTime(material.getCreatedDateTime())
                                                    .build();
                                        })
                                        .collectList()
                                        .flatMap(materialDtos -> Mono.just(ResponseEntity.ok(MaterialResponse.builder()
                                                .status("S1000")
                                                .statusDescription("Success")
                                                .materials(materialDtos)
                                                .build()
                                        )));
                            } else {
                                return Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(MaterialResponse.builder()
                                        .status("E1200")
                                        .statusDescription("You are not authorized to use this service").build()));
                            }
                        })
                )
                .switchIfEmpty(Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(MaterialResponse.builder()
                        .status("E1000")
                        .statusDescription("Failed").build())));
    }

    public Mono<MaterialDto> getMaterialByName(String name) {
        return Mono.just(name)
                .doOnNext(uName -> log.info("Finding material for name [{}]", uName))
                .flatMap(materialRepository::findByName)
                .map(materialMapper::materialToMaterialDto);
    }
}
