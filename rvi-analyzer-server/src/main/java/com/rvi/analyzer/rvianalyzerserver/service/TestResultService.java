//package com.rvi.analyzer.rvianalyzerserver.service;
//
//import com.rvi.analyzer.rvianalyzerserver.domain.NewTestResultResponse;
//import com.rvi.analyzer.rvianalyzerserver.domain.TestResultResponse;
//import com.rvi.analyzer.rvianalyzerserver.domain.UserRoles;
//import com.rvi.analyzer.rvianalyzerserver.dto.TestResultDto;
//import com.rvi.analyzer.rvianalyzerserver.mappers.TestMapper;
//import com.rvi.analyzer.rvianalyzerserver.mappers.TestResultMapper;
//import com.rvi.analyzer.rvianalyzerserver.repository.TestRepository;
//import com.rvi.analyzer.rvianalyzerserver.repository.TestResultRepository;
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
//public class TestResultService {
//    final private UserRepository userRepository;
//    final private TestResultRepository testResultRepository;
//    final private JwtUtils jwtUtils;
//    final private UserGroupRoleService userGroupRoleService;
//    final private TestResultMapper testResultMapper;
//    final private TestService testService;
//    final private ProductionOrderService productionOrderService;
//
//    public Mono<NewTestResultResponse> addTestResult(TestResultDto testResultDto, String jwt) {
//        return Mono.just(testResultDto)
//                .doOnNext(testResultDto1 -> log.info("Test result add request received [{}]", testResultDto1))
//                .flatMap(request -> testResultRepository.findByProductId(request.getProductId()))
//                .flatMap(test -> Mono.just(NewTestResultResponse.builder()
//                        .status("E1002")
//                        .statusDescription("Test result Already exists")
//                        .build()))
//                .switchIfEmpty(
//                        createTestResult(testResultDto, jwtUtils.getUsername(jwt))
//                )
//                .doOnError(e ->
//                        NewTestResultResponse.builder()
//                                .status("E1000")
//                                .statusDescription("Failed")
//                                .build());
//    }
//
//    private Mono<NewTestResultResponse> createTestResult(TestResultDto testResultDto, String username) {
//        return Mono.just(userRepository.findByUsername(username))
//                .flatMap(creatingStyle -> userGroupRoleService.getUserRolesByUserGroup(creatingStyle.getGroup())
//                        .flatMap(userRoles -> {
//                            log.info(testResultDto.getProductId());
//                            if (userRoles.contains(UserRoles.CREATE_TEST_RESULT)) {
//                                return testService.getTestByTestGate(testResultDto.getTestGate())
//                                        .flatMap(testDto -> {
//                                            return productionOrderService.getProductionOrderByOrderId(testResultDto.getProductionOrder())
//                                                    .flatMap(productionOrderDto -> {
//                                                        return save(testResultDto, username);
//                                                    })
//                                                    .switchIfEmpty(Mono.just(NewTestResultResponse.builder()
//                                                            .status("E1000")
//                                                            .statusDescription("Production order is not available")
//                                                            .build()));
//                                        })
//                                        .switchIfEmpty(Mono.just(NewTestResultResponse.builder()
//                                                .status("E1000")
//                                                .statusDescription("Test is not available")
//                                                .build()));
//                            } else {
//                                return Mono.just(NewTestResultResponse.builder()
//                                        .status("E1200")
//                                        .statusDescription("You are not authorized to use this service").build());
//                            }
//                        }));
//    }
//
//    private Mono<NewTestResultResponse> save(TestResultDto testResultDto, String username) {
//        return Mono.just(testResultDto)
//                .map(testResultMapper::testResultDtoToTestResult)
//                .doOnNext(testResult -> {
//                    testResult.setTestGate(testResultDto.getTestGate() != null ? testResultDto.getTestGate() : "UN-ASSIGNED");
//                    testResult.setProductId(testResultDto.getProductId() != null ? testResultDto.getProductId() : "UN-ASSIGNED");
//                    testResult.setProductionOrder(testResultDto.getProductionOrder() != null ? testResultDto.getProductionOrder() : "UN-ASSIGNED");
//                    testResult.setMode01(testResultDto.getMode01() != null ? testResultDto.getMode01() : "UN-ASSIGNED");
//                    testResult.setMode02(testResultDto.getMode02() != null ? testResultDto.getMode02() : "UN-ASSIGNED");
//                    testResult.setMode03(testResultDto.getMode03() != null ? testResultDto.getMode03() : "UN-ASSIGNED");
//                    testResult.setMode04(testResultDto.getMode04() != null ? testResultDto.getMode04() : "UN-ASSIGNED");
//                    testResult.setCreatedBy(username);
//                    testResult.setCreatedDateTime(LocalDateTime.now());
//                })
//                .flatMap(testResultRepository::insert)
//                .doOnSuccess(test -> log.info("Successfully saved the test result [{}]", test))
//                .map(testResult -> NewTestResultResponse.builder()
//                        .status("S1000")
//                        .statusDescription("Success")
//                        .productId(testResult.getProductId())
//                        .build());
//    }
//
//    public Mono<ResponseEntity<TestResultResponse>> getTestResultss(String auth) {
//        log.info("get test results request received with jwt [{}]", auth);
//        return Mono.just(userRepository.findByUsername(jwtUtils.getUsername(auth)))
//                .flatMap(requestedUser -> userGroupRoleService.getUserRolesByUserGroup(requestedUser.getGroup())
//                        .flatMap(userRoles -> {
//                            if (userRoles.contains(UserRoles.GET_ALL_TEST_RESULT)) {
//                                return testResultRepository.findAll()
//                                        .map(testResult -> {
//                                            return TestResultDto.builder()
//                                                    ._id(testResult.get_id())
//                                                    .testGate(testResult.getTestGate())
//                                                    .productId(testResult.getProductId())
//                                                    .productionOrder(testResult.getProductionOrder())
//                                                    .mode01(testResult.getMode01())
//                                                    .mode02(testResult.getMode02())
//                                                    .mode03(testResult.getMode03())
//                                                    .mode04(testResult.getMode04())
//                                                    .createdBy(testResult.getCreatedBy())
//                                                    .createdDateTime(testResult.getCreatedDateTime())
//                                                    .build();
//                                        })
//                                        .collectList()
//                                        .flatMap(testResultDtos -> Mono.just(ResponseEntity.ok(TestResultResponse.builder()
//                                                .status("S1000")
//                                                .statusDescription("Success")
//                                                .testResults(testResultDtos)
//                                                .build()
//                                        )));
//                            } else {
//                                return Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(TestResultResponse.builder()
//                                        .status("E1200")
//                                        .statusDescription("You are not authorized to use this service").build()));
//                            }
//                        })
//                )
//                .switchIfEmpty(Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(TestResultResponse.builder()
//                        .status("E1000")
//                        .statusDescription("Failed").build())));
//    }
//
//    public Mono<TestResultDto> getTestResultByProductId(String name) {
//        return Mono.just(name)
//                .doOnNext(uName -> log.info("Finding test result for name [{}]", uName))
//                .flatMap(testResultRepository::findByProductId)
//                .map(testResultMapper::testResultToTestResultDto);
//    }
//}
