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
import java.util.Objects;

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
    final private MaterialService materialService;
    private boolean booleanValue;

    public Mono<NewTestResponse> addTest(TestDto testDto, String jwt) {
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
        return userRepository.findByUsername(username)
                .flatMap(creatingStyle -> userGroupRoleService.getUserRolesByUserGroup(creatingStyle.getGroup())
                        .flatMap(userRoles -> {
                            log.info(testDto.getTestGate());
                            if (userRoles.contains(UserRoles.CREATE_TEST)) {
                                return materialService.getMaterialByName(testDto.getMaterial())
                                        .flatMap(materialDto -> {
                                            return save(testDto, username);
                                        })
                                        .switchIfEmpty(Mono.just(NewTestResponse.builder()
                                                .status("E1000")
                                                .statusDescription("Material is not available")
                                                .build()));
                            } else {
                                return Mono.just(NewTestResponse.builder()
                                        .status("E1200")
                                        .statusDescription("You are not authorized to use this service").build());
                            }
                        }));
    }

    private Mono<NewTestResponse> save(TestDto testDto, String username) {
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

    public Mono<ResponseEntity<TestResponse>> getTests(String auth) {
        log.info("get tests request received with jwt [{}]", auth);
        return userRepository.findByUsername(jwtUtils.getUsername(auth))
                .flatMap(requestedUser -> userGroupRoleService.getUserRolesByUserGroup(requestedUser.getGroup())
                        .flatMap(userRoles -> {
                            if (userRoles.contains(UserRoles.GET_ALL_TESTS)) {
                                return testRepository.findAll()
                                        .map(test -> {
                                            return TestDto.builder()
                                                    ._id(test.get_id())
                                                    .testGate(test.getTestGate())
                                                    .material(test.getMaterial())
                                                    .parameterModes(test.getParameterModes())
                                                    .createdBy(test.getCreatedBy())
                                                    .createdDateTime(test.getCreatedDateTime())
                                                    .build();
                                        })
                                        .collectList()
                                        .flatMap(testDtos -> Mono.just(ResponseEntity.ok(TestResponse.builder()
                                                .status("S1000")
                                                .statusDescription("Success")
                                                .tests(testDtos)
                                                .build()
                                        )));
                            } else if (userRoles.contains(UserRoles.GET_TESTS)) {
                                return testRepository.findByCreatedBy(requestedUser.getUsername())
                                        .map(test -> {
                                            return TestDto.builder()
                                                    ._id(test.get_id())
                                                    .testGate(test.getTestGate())
                                                    .material(test.getMaterial())
                                                    .parameterModes(test.getParameterModes())
                                                    .createdBy(test.getCreatedBy())
                                                    .createdDateTime(test.getCreatedDateTime())
                                                    .build();
                                        })
                                        .collectList()
                                        .flatMap(testDtos -> Mono.just(ResponseEntity.ok(TestResponse.builder()
                                                .status("S1000")
                                                .statusDescription("Success")
                                                .tests(testDtos)
                                                .build()
                                        )));
                            } else {
                                return Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(TestResponse.builder()
                                        .status("E1200")
                                        .statusDescription("You are not authorized to use this service").build()));
                            }
                        })
                )
                .switchIfEmpty(Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(TestResponse.builder()
                        .status("E1000")
                        .statusDescription("Failed").build())));
    }

    public Mono<TestDto> getTestByTestGate(String name) {
        return Mono.just(name)
                .doOnNext(uName -> log.info("Finding test for name [{}]", uName))
                .flatMap(testRepository::findByTestGate)
                .map(testMapper::testToTestDto);
    }
}
