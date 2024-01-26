package com.rvi.analyzer.rvianalyzerserver.service;

import com.rvi.analyzer.rvianalyzerserver.domain.*;
import com.rvi.analyzer.rvianalyzerserver.dto.MaterialDto;
import com.rvi.analyzer.rvianalyzerserver.dto.StyleDto;
import com.rvi.analyzer.rvianalyzerserver.dto.TestDto;
import com.rvi.analyzer.rvianalyzerserver.dto.UserDto;
import com.rvi.analyzer.rvianalyzerserver.mappers.MaterialMapper;
import com.rvi.analyzer.rvianalyzerserver.mappers.TestMapper;
import com.rvi.analyzer.rvianalyzerserver.repository.MaterialRepository;
import com.rvi.analyzer.rvianalyzerserver.repository.TestRepository;
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
public class TestService {
    final private UserRepository userRepository;
    final private TestRepository testRepository;
    final private JwtUtils jwtUtils;
    final private UserGroupRoleService userGroupRoleService;
    final private TestMapper testMapper;

    public Mono<NewTestResponse> addTest(TestDto testDto, String jwt) {
        System.out.println(testDto.getTestGate() + " , 02");
        return Mono.just(testDto)
                .doOnNext(testDto1 -> log.info("Test add request received [{}]", testDto1))
                .flatMap(request -> testRepository.findByTestGate(request.getTestGate()))
                .flatMap(test -> Mono.just(NewTestResponse.builder()
                        .status("E1002")
                        .statusDescription("Test Already exists")
                        .build()))
                .switchIfEmpty(
                        createTest(testDto, jwtUtils.getUsername(jwt))
                )
                .doOnError(e ->
                        NewTestResponse.builder()
                                .status("E1000")
                                .statusDescription("Failed")
                                .build());
    }

    private Mono<NewTestResponse> createTest(TestDto testDto, String username) {
        System.out.println(testDto.getTestGate() + ", 03");
        return userRepository.findByUsername(username)
                .flatMap(creatingStyle -> userGroupRoleService.getUserRolesByUserGroup(creatingStyle.getGroup())
                        .flatMap(userRoles -> {
                            log.info(testDto.getTestGate());
                            if (userRoles.contains(UserRoles.CREATE_TOP_ADMIN)) {
                                System.out.println(testDto.getTestGate() + ", 04");
                                return save(testDto, username);
                            } else {
                                return Mono.just(NewTestResponse.builder()
                                        .status("E1200")
                                        .statusDescription("You are not authorized to use this service").build());
                            }
                        }));
    }

    private Mono<NewTestResponse> save(TestDto testDto, String username) {
        System.out.println(testDto.getTestGate() + ", 05");
        return Mono.just(testDto)
                .map(testMapper::testDtoToTest)
                .doOnNext(test -> {
                    test.setTestGate(testDto.getTestGate() != null ? testDto.getTestGate() : "UN-ASSIGNED");
                    test.setMaterial(testDto.getMaterial() != null ? testDto.getMaterial() : "UN-ASSIGNED");
                    test.setParameterModes(testDto.getParameterModes() != null ? testDto.getParameterModes() : new ArrayList<>());
                    test.setCreatedBy(username);
                    test.setCreatedDateTime(LocalDateTime.now());
                })
                .flatMap(testRepository::insert)
                .doOnSuccess(test -> log.info("Successfully saved the test [{}]", test))
                .map(material -> NewTestResponse.builder()
                        .status("S1000")
                        .statusDescription("Success")
                        .testGate(testDto.getTestGate())
                        .build());
    }

//    public Mono<ResponseEntity<MaterialResponse>> getMaterials(String auth) {
//        log.info("get materials request received with jwt [{}]", auth);
//        return userRepository.findByUsername(jwtUtils.getUsername(auth))
//                .flatMap(requestedUser -> userGroupRoleService.getUserRolesByUserGroup(requestedUser.getGroup())
//                        .flatMap(userRoles -> {
//                            if (userRoles.contains(UserRoles.GET_ALL_CUSTOMERS)) {
//                                return materialRepository.findAll()
//                                        .map(material -> {
//                                            return MaterialDto.builder()
//                                                    ._id(material.get_id())
//                                                    .plant(material.getPlant())
//                                                    .customer(material.getCustomer())
//                                                    .style(material.getStyle())
//                                                    .name(material.getName())
//                                                    .createdBy(material.getCreatedBy())
//                                                    .createdDateTime(material.getCreatedDateTime())
//                                                    .build();
//                                        })
//                                        .collectList()
//                                        .flatMap(materialDtos -> Mono.just(ResponseEntity.ok(MaterialResponse.builder()
//                                                .status("S1000")
//                                                .statusDescription("Success")
//                                                .materials(materialDtos)
//                                                .build()
//                                        )));
//                            } else {
//                                return Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(MaterialResponse.builder()
//                                        .status("E1200")
//                                        .statusDescription("You are not authorized to use this service").build()));
//                            }
//                        })
//                )
//                .switchIfEmpty(Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(MaterialResponse.builder()
//                        .status("E1000")
//                        .statusDescription("Failed").build())));
//    }
//
//    public Mono<MaterialDto> getMaterialByName(String name) {
//        return Mono.just(name)
//                .doOnNext(uName -> log.info("Finding material for name [{}]", uName))
//                .flatMap(materialRepository::findByName)
//                .map(materialMapper::materialToMaterialDto);
//    }
}
