package com.rvi.analyzer.rvianalyzerserver.service;

import com.rvi.analyzer.rvianalyzerserver.domain.*;
import com.rvi.analyzer.rvianalyzerserver.dto.*;
import com.rvi.analyzer.rvianalyzerserver.entiy.ModeOne;
import com.rvi.analyzer.rvianalyzerserver.entiy.ModeTwo;
import com.rvi.analyzer.rvianalyzerserver.entiy.Report;
import com.rvi.analyzer.rvianalyzerserver.mappers.*;
import com.rvi.analyzer.rvianalyzerserver.repository.*;
import com.rvi.analyzer.rvianalyzerserver.security.JwtUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.mongodb.core.aggregation.ConditionalOperators;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Mono;

import javax.xml.stream.events.Characters;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.concurrent.atomic.AtomicBoolean;

@Service
@RequiredArgsConstructor
@Slf4j
public class SessionService {

    final private ModeOneMapper modeOneMapper;
    final private ModeTwoMapper modeTwoMapper;
    final private ModeThreeMapper modeThreeMapper;
    final private ModeFourMapper modeFourMapper;
    final private ModeFiveMapper modeFiveMapper;
    final private ModeSixMapper modeSixMapper;
    final private ModeOneRepository modeOneRepository;
    final private ModeTwoRepository modeTwoRepository;
    final private ModeThreeRepository modeThreeRepository;
    final private ModeFourRepository modeFourRepository;
    final private ModeFiveRepository modeFiveRepository;
    final private ModeSixRepository modeSixRepository;
    final private JwtUtils jwtUtils;
    final private UserService userService;
    final private UserGroupRoleService userGroupRoleService;

    final private ReportRepository repository;

    private final String CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()_-+=<>?";

    @Value("${report.server.base.url}")
    private String reportUrl;


    public Mono<ResponseEntity<CommonResponse>> addModeOne(ModeOneDto modeOneDto, String jwt) {
        return userService.getUser(jwtUtils.getUsername(jwt))
                .flatMap(user -> userGroupRoleService.getUserRolesByUserGroup(user.getGroup())
                        .flatMap(userRoles -> {
                            if (userRoles.contains(UserRoles.SAVE_MODE_ONE)) {
                                return Mono.just(modeOneDto)
                                        .doOnNext(modeOneDto1 -> log.info("MOde one add request received [{}]", modeOneDto1))
                                        .flatMap(modeOneDto1 -> modeOneRepository.findBySessionID(modeOneDto1.getDefaultConfigurations().getSessionId()))
                                        .flatMap(modeOne -> Mono.just(modeOne)
                                                .filter(mOne -> mOne.getResults().stream().anyMatch(i -> Objects.equals(i.getTestId(), modeOneDto.getResults().get(0).getTestId())))
                                                .flatMap(modeOne1 ->
                                                        Mono.just(ResponseEntity.ok(CommonResponse.builder()
                                                                .status("E1010")
                                                                .statusDescription("Mode Already exist with taskID")
                                                                .build()))
                                                ).switchIfEmpty(updateSessionOne(modeOneDto, modeOne))
                                        )
                                        .switchIfEmpty(saveModeOne(modeOneDto, jwt))
                                        .doOnError(e ->
                                                ResponseEntity.ok(CommonResponse.builder()
                                                        .status("E1000")
                                                        .statusDescription("Failed")
                                                        .build()));
                            } else {
                                return Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(CommonResponse.builder()
                                        .status("E1200")
                                        .statusDescription("You are not authorized to use this service").build()));
                            }
                        })
                )
                .switchIfEmpty(Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(CommonResponse.builder()
                        .status("E1200")
                        .statusDescription("Failed")
                        .build())));


    }

    private Mono<ResponseEntity<CommonResponse>> updateSessionOne(ModeOneDto modeOneDto, ModeOne modeOne) {
        return Mono.just(modeOne)
                .doOnNext(modeOne1 -> {
                    modeOneDto.getResults().get(0).getReadings().get(0).setReadAt(LocalDateTime.now());
                    modeOne.getResults().add(modeOneDto.getResults().get(0));
                    modeOne.setLastUpdatedDateTime(LocalDateTime.now());
                })
                .flatMap(modeOneRepository::save)
                .doOnSuccess(mOne -> log.info("Successfully updated the Mode One [{}]", mOne))
                .map(device -> ResponseEntity.ok(CommonResponse.builder()
                        .status("S1000")
                        .statusDescription("Success")
                        .build()));
    }

    private Mono<ResponseEntity<CommonResponse>> saveModeOne(ModeOneDto modeOneDto, String jwt) {
        return Mono.just(modeOneMapper.modeOneDtoToModeOne(modeOneDto))
                .doOnNext(modeOne -> {
                    modeOne.setCreatedBy(jwtUtils.getUsername(jwt));
                    modeOne.setStatus("ACTIVE");
                    modeOne.setCreatedDateTime(LocalDateTime.now());
                    modeOne.setLastUpdatedDateTime(LocalDateTime.now());
                    modeOne.getResults().get(0).getReadings().get(0).setReadAt(LocalDateTime.now());
                })
                .flatMap(modeOneRepository::save)
                .doOnSuccess(device -> log.info("Successfully saved the Mode One [{}]", device))
                .map(device -> ResponseEntity.ok(CommonResponse.builder()
                        .status("S1000")
                        .statusDescription("Success")
                        .build()));
    }

    // Mode Two related services
    public Mono<ResponseEntity<CommonResponse>> addModeTwo(ModeTwoDto modeTwoDto, String jwt) {
        return userService.getUser(jwtUtils.getUsername(jwt))
                .flatMap(user -> userGroupRoleService.getUserRolesByUserGroup(user.getGroup())
                        .flatMap(userRoles -> {
                            if (userRoles.contains(UserRoles.SAVE_MODE_TWO)) {
                                return Mono.just(modeTwoDto)
                                        .doOnNext(modeTwoDto1 -> log.info("MOde Two add request received [{}]", modeTwoDto1))
                                        .flatMap(modeTwoDto1 -> modeTwoRepository.findBySessionID(modeTwoDto1.getDefaultConfigurations().getSessionId()))
                                        .flatMap(modeTwo -> Mono.just(modeTwo)
                                                .filter(mOne -> mOne.getResults().stream().anyMatch(i -> Objects.equals(i.getTestId(), modeTwoDto.getResults().get(0).getTestId())))
                                                .flatMap(modeTwo1 ->
                                                        Mono.just(ResponseEntity.ok(CommonResponse.builder()
                                                                .status("E1010")
                                                                .statusDescription("Mode Already exist with taskID")
                                                                .build()))
                                                ).switchIfEmpty(updateSessionTwo(modeTwoDto, modeTwo))
                                        )
                                        .switchIfEmpty(saveModeTwo(modeTwoDto, jwt))
                                        .doOnError(e ->
                                                ResponseEntity.ok(CommonResponse.builder()
                                                        .status("E1000")
                                                        .statusDescription("Failed")
                                                        .build()));
                            } else {
                                return Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(CommonResponse.builder()
                                        .status("E1200")
                                        .statusDescription("You are not authorized to use this service").build()));
                            }
                        })
                )
                .switchIfEmpty(Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(CommonResponse.builder()
                        .status("E1220")
                        .statusDescription("Failed")
                        .build())));
    }

    private Mono<ResponseEntity<CommonResponse>> updateSessionTwo(ModeTwoDto modeTwoDto, ModeTwo modeTwo) {
        System.out.println(modeTwo);
        return Mono.just(modeTwo)
                .doOnNext(modeTwo1 -> {
                    modeTwoDto.getResults().get(0).getReadings().get(0).setReadAt(LocalDateTime.now());
                    modeTwo.getResults().add(modeTwoDto.getResults().get(0));
                    modeTwo.setLastUpdatedDateTime(LocalDateTime.now());
                })
                .flatMap(modeTwoRepository::save)
                .doOnSuccess(mOne -> log.info("Successfully updated the Mode Two [{}]", mOne))
                .map(device -> ResponseEntity.ok(CommonResponse.builder()
                        .status("S1000")
                        .statusDescription("Success")
                        .build()));
    }

    private Mono<ResponseEntity<CommonResponse>> saveModeTwo(ModeTwoDto modeTwoDto, String jwt) {
        return Mono.just(modeTwoMapper.modeTwoDtoToModeTwo(modeTwoDto))
                .doOnNext(modeTwo -> {
                    modeTwo.setCreatedBy(jwtUtils.getUsername(jwt));
                    modeTwo.setStatus("ACTIVE");
                    modeTwo.setCreatedDateTime(LocalDateTime.now());
                    modeTwo.setLastUpdatedDateTime(LocalDateTime.now());
                    modeTwo.getResults().get(0).getReadings().get(0).setReadAt(LocalDateTime.now());
                })
                .flatMap(modeTwoRepository::save)
                .doOnSuccess(device -> log.info("Successfully saved the Mode Two [{}]", device))
                .map(device -> ResponseEntity.ok(CommonResponse.builder()
                        .status("S1000")
                        .statusDescription("Success")
                        .build()));
    }

    // Mode Three related services
    public Mono<ResponseEntity<CommonResponse>> addModeThree(ModeThreeDto modeThreeDto, String jwt) {
        return userService.getUser(jwtUtils.getUsername(jwt))
                .flatMap(user -> userGroupRoleService.getUserRolesByUserGroup(user.getGroup())
                        .flatMap(userRoles -> {
                            if (userRoles.contains(UserRoles.SAVE_MODE_THREE)) {
                                return Mono.just(modeThreeDto)
                                        .doOnNext(modeThreeDto1 -> log.info("MOde three add request received [{}]", modeThreeDto1))
                                        .flatMap(modeThreeDto1 -> modeThreeRepository.findBySessionID(modeThreeDto1.getDefaultConfigurations().getSessionId()))
                                        .flatMap(modeThree -> Mono.just(ResponseEntity.ok(CommonResponse.builder()
                                                        .status("E1010")
                                                        .statusDescription("Mode Already exist with taskID, Session Id")
                                                        .build())
                                                )
                                        )
                                        .switchIfEmpty(saveModeThree(modeThreeDto, jwt))
                                        .doOnError(e ->
                                                ResponseEntity.ok(CommonResponse.builder()
                                                        .status("E1000")
                                                        .statusDescription("Failed")
                                                        .build()));
                            } else {
                                return Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(CommonResponse.builder()
                                        .status("E1200")
                                        .statusDescription("You are not authorized to use this service").build()));
                            }
                        })
                )
                .switchIfEmpty(Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(CommonResponse.builder()
                        .status("E1220")
                        .statusDescription("Failed")
                        .build())));

    }

    private Mono<ResponseEntity<CommonResponse>> saveModeThree(ModeThreeDto ModeThreeDto, String jwt) {
        return Mono.just(modeThreeMapper.modeThreeDtoToModeThree(ModeThreeDto))
                .doOnNext(modeThree -> {
                    modeThree.setCreatedBy(jwtUtils.getUsername(jwt));
                    modeThree.setStatus("ACTIVE");
                    modeThree.setCreatedDateTime(LocalDateTime.now());
                    modeThree.setLastUpdatedDateTime(LocalDateTime.now());
                })
                .flatMap(modeThreeRepository::save)
                .doOnSuccess(device -> log.info("Successfully saved the Mode Three [{}]", device))
                .map(device -> ResponseEntity.ok(CommonResponse.builder()
                        .status("S1000")
                        .statusDescription("Success")
                        .build()));
    }

    // Mode Four related services
    public Mono<ResponseEntity<CommonResponse>> addModeFour(ModeFourDto modeFourDto, String jwt) {
        return userService.getUser(jwtUtils.getUsername(jwt))
                .flatMap(user -> userGroupRoleService.getUserRolesByUserGroup(user.getGroup())
                        .flatMap(userRoles -> {
                            if (userRoles.contains(UserRoles.SAVE_MODE_FOUR)) {
                                return Mono.just(modeFourDto)
                                        .doOnNext(modeFourDto1 -> log.info("MOde four add request received [{}]", modeFourDto1))
                                        .flatMap(modeFourDto1 -> modeFourRepository.findBySessionID(modeFourDto1.getDefaultConfigurations().getSessionId()))
                                        .flatMap(modeFour -> Mono.just(ResponseEntity.ok(CommonResponse.builder()
                                                .status("E1010")
                                                .statusDescription("Mode Already exist with taskID, Session Id")
                                                .build()))

                                        )
                                        .switchIfEmpty(saveModeFour(modeFourDto, jwt))
                                        .doOnError(e ->
                                                ResponseEntity.ok(CommonResponse.builder()
                                                        .status("E1000")
                                                        .statusDescription("Failed")
                                                        .build()));
                            } else {
                                return Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(CommonResponse.builder()
                                        .status("E1200")
                                        .statusDescription("You are not authorized to use this service").build()));
                            }
                        })
                )
                .switchIfEmpty(Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(CommonResponse.builder()
                        .status("E1220")
                        .statusDescription("Failed")
                        .build())));
    }

    private Mono<ResponseEntity<CommonResponse>> saveModeFour(ModeFourDto modeFourDto, String jwt) {
        return Mono.just(modeFourMapper.modeFourDtoToModeFour(modeFourDto))
                .doOnNext(modeFour -> {
                    modeFour.setCreatedBy(jwtUtils.getUsername(jwt));
                    modeFour.setStatus("ACTIVE");
                    modeFour.setCreatedDateTime(LocalDateTime.now());
                    modeFour.setLastUpdatedDateTime(LocalDateTime.now());
                })
                .flatMap(modeFourRepository::save)
                .doOnSuccess(device -> log.info("Successfully saved the Mode Four [{}]", device))
                .map(device -> ResponseEntity.ok(CommonResponse.builder()
                        .status("S1000")
                        .statusDescription("Success")
                        .build()));
    }

    // Mode Five related services
    public Mono<ResponseEntity<CommonResponse>> addModeFive(ModeFiveDto modeFiveDto, String jwt) {
        return userService.getUser(jwtUtils.getUsername(jwt))
                .flatMap(user -> userGroupRoleService.getUserRolesByUserGroup(user.getGroup())
                        .flatMap(userRoles -> {
                            if (userRoles.contains(UserRoles.SAVE_MODE_FIVE)) {
                                return Mono.just(modeFiveDto)
                                        .doOnNext(modeFiveDto1 -> log.info("MOde five add request received [{}]", modeFiveDto1))
                                        .flatMap(modeFiveDto1 -> modeFiveRepository.findBySessionID(modeFiveDto1.getDefaultConfigurations().getSessionId()))
                                        .flatMap(modeFive -> Mono.just(ResponseEntity.ok(CommonResponse.builder()
                                                .status("E1010")
                                                .statusDescription("Mode Already exist with taskID, Session Id")
                                                .build()))

                                        )
                                        .switchIfEmpty(saveModeFive(modeFiveDto, jwt))
                                        .doOnError(e ->
                                                ResponseEntity.ok(CommonResponse.builder()
                                                        .status("E1000")
                                                        .statusDescription("Failed")
                                                        .build()));
                            } else {
                                return Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(CommonResponse.builder()
                                        .status("E1200")
                                        .statusDescription("You are not authorized to use this service").build()));
                            }
                        })
                )
                .switchIfEmpty(Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(CommonResponse.builder()
                        .status("E1220")
                        .statusDescription("Failed")
                        .build())));
    }

    private Mono<ResponseEntity<CommonResponse>> saveModeFive(ModeFiveDto modeFiveDto, String jwt) {
        return Mono.just(modeFiveMapper.modeFiveDtoToModeFive(modeFiveDto))
                .doOnNext(modeFive -> {
                    modeFive.setCreatedBy(jwtUtils.getUsername(jwt));
                    modeFive.setStatus("ACTIVE");
                    modeFive.setCreatedDateTime(LocalDateTime.now());
                    modeFive.setLastUpdatedDateTime(LocalDateTime.now());
                })
                .flatMap(modeFiveRepository::save)
                .doOnSuccess(device -> log.info("Successfully saved the Mode Five [{}]", device))
                .map(device -> ResponseEntity.ok(CommonResponse.builder()
                        .status("S1000")
                        .statusDescription("Success")
                        .build()));
    }

    // Mode Six related services
    public Mono<ResponseEntity<CommonResponse>> addModeSix(ModeSixDto modeSixDto, String jwt) {
        return userService.getUser(jwtUtils.getUsername(jwt))
                .flatMap(user -> userGroupRoleService.getUserRolesByUserGroup(user.getGroup())
                        .flatMap(userRoles -> {
                            if (userRoles.contains(UserRoles.SAVE_MODE_SIX)) {
                                return Mono.just(modeSixDto)
                                        .doOnNext(modeSixDto1 -> log.info("MOde six add request received [{}]", modeSixDto1))
                                        .flatMap(modeSixDto1 -> modeSixRepository.findBySessionID(modeSixDto1.getDefaultConfigurations().getSessionId()))
                                        .flatMap(modeSix -> Mono.just(ResponseEntity.ok(CommonResponse.builder()
                                                .status("E1010")
                                                .statusDescription("Mode Already exist with taskID, Session Id")
                                                .build()))

                                        )
                                        .switchIfEmpty(saveModeSix(modeSixDto, jwt))
                                        .doOnError(e ->
                                                ResponseEntity.ok(CommonResponse.builder()
                                                        .status("E1000")
                                                        .statusDescription("Failed")
                                                        .build()));
                            } else {
                                return Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(CommonResponse.builder()
                                        .status("E1200")
                                        .statusDescription("You are not authorized to use this service").build()));
                            }
                        })
                )
                .switchIfEmpty(Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(CommonResponse.builder()
                        .status("E1200")
                        .statusDescription("Failed")
                        .build())));
    }

    private Mono<ResponseEntity<CommonResponse>> saveModeSix(ModeSixDto modeSixDto, String jwt) {
        return Mono.just(modeSixMapper.modeSixDtoToModeSix(modeSixDto))
                .doOnNext(modeSix -> {
                    modeSix.setCreatedBy(jwtUtils.getUsername(jwt));
                    modeSix.setStatus("ACTIVE");
                    modeSix.setCreatedDateTime(LocalDateTime.now());
                    modeSix.setLastUpdatedDateTime(LocalDateTime.now());
                })
                .flatMap(modeSixRepository::save)
                .doOnSuccess(device -> log.info("Successfully saved the Mode Six [{}]", device))
                .map(device -> ResponseEntity.ok(CommonResponse.builder()
                        .status("S1000")
                        .statusDescription("Success")
                        .build()));
    }

    public Mono<ResponseEntity<ModeOnesResponse>> getAllModeOne(String pageNo, SessionSearchRequest request, String jwt) {
        return userService.getUser(jwtUtils.getUsername(jwt))
                .flatMap(user -> userGroupRoleService.getUserRolesByUserGroup(user.getGroup())
                        .flatMap(userRoles -> {
                            if (userRoles.contains(UserRoles.GET_MODE_ONE)) {
                                return userService.getUsersByAdmin(user.getUsername())
                                        .filter(strings -> !strings.isEmpty())
                                        .flatMap(strings -> {
                                            if (getFilters(strings, pageNo, request).isEmpty()) {
                                                return Mono.just(ResponseEntity.ok(ModeOnesResponse.builder()
                                                        .status("S1000")
                                                        .statusDescription("Success")
                                                        .sessions(new ArrayList<>())
                                                        .build()));
                                            } else {
                                                Pageable pageable = PageRequest.of(Integer.parseInt(pageNo), 20);

                                                return modeOneRepository.findByFilters(getFilters(strings, pageNo, request), pageable)
                                                        .filter(Objects::nonNull)
                                                        .flatMap(modeOne -> {
                                                            log.info("Mode one found with id [{}]", modeOne.getDefaultConfigurations().getSessionId());
                                                            return Mono.just(modeOneMapper.modeOneToModeOneDto(modeOne));
                                                        })
                                                        .collectList()
                                                        .flatMap(modeOneDtos -> Mono.just(ResponseEntity.ok(ModeOnesResponse.builder()
                                                                .status("S1000")
                                                                .statusDescription("Success")
                                                                .sessions(modeOneDtos)
                                                                .build())));
                                            }
                                        })
                                        .switchIfEmpty(Mono.just(ResponseEntity.ok(ModeOnesResponse.builder()
                                                .status("S1000")
                                                .statusDescription("Success")
                                                .sessions(new ArrayList<>())
                                                .build())));
                            } else {
                                return Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(ModeOnesResponse.builder()
                                        .status("E1200")
                                        .statusDescription("You are not authorized to use this service").build()));
                            }
                        })
                )
                .switchIfEmpty(Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(ModeOnesResponse.builder()
                        .status("E1220")
                        .statusDescription("Failed")
                        .build())));
    }

    public Mono<ResponseEntity<ModeTwosResponse>> getAllModeTwos(String pageNo, SessionSearchRequest request, String jwt) {
        return userService.getUser(jwtUtils.getUsername(jwt))
                .flatMap(user -> userGroupRoleService.getUserRolesByUserGroup(user.getGroup())
                        .flatMap(userRoles -> {
                            if (userRoles.contains(UserRoles.GET_MODE_TWO)) {
                                return userService.getUsersByAdmin(user.getUsername())
                                        .filter(strings -> !strings.isEmpty())
                                        .flatMap(strings -> {
                                            if (getFilters(strings, pageNo, request).isEmpty()) {
                                                return Mono.just(ResponseEntity.ok(ModeTwosResponse.builder()
                                                        .status("S1000")
                                                        .statusDescription("Success")
                                                        .sessions(new ArrayList<>())
                                                        .build()));
                                            } else {
                                                Pageable pageable = PageRequest.of(Integer.parseInt(pageNo), 20);

                                                return modeTwoRepository.findByFilters(getFilters(strings, pageNo, request), pageable)
                                                        .flatMap(modeTwo -> {
                                                            log.info("Mode two found with id [{}]", modeTwo.getDefaultConfigurations().getSessionId());
                                                            return Mono.just(modeTwoMapper.modeTwoToModeTwoDto(modeTwo));
                                                        })
                                                        .collectList()
                                                        .flatMap(modeTwoDtos -> Mono.just(ResponseEntity.ok(ModeTwosResponse.builder()
                                                                .status("S1000")
                                                                .statusDescription("Success")
                                                                .sessions(modeTwoDtos)
                                                                .build())));
                                            }
                                        })
                                        .switchIfEmpty(Mono.just(ResponseEntity.ok(ModeTwosResponse.builder()
                                                .status("S1000")
                                                .statusDescription("Success")
                                                .sessions(new ArrayList<>())
                                                .build())));
                            } else {
                                return Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(ModeTwosResponse.builder()
                                        .status("E1200")
                                        .statusDescription("You are not authorized to use this service").build()));
                            }
                        })
                )
                .switchIfEmpty(Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(ModeTwosResponse.builder()
                        .status("E1200")
                        .statusDescription("Failed")
                        .build())));
    }

    public Mono<ResponseEntity<ModeThreesResponse>> getAllModeThrees(String pageNo, SessionSearchRequest request, String jwt) {
        return userService.getUser(jwtUtils.getUsername(jwt))
                .flatMap(user -> userGroupRoleService.getUserRolesByUserGroup(user.getGroup())
                        .flatMap(userRoles -> {
                            if (userRoles.contains(UserRoles.GET_MODE_THREE)) {
                                return userService.getUsersByAdmin(user.getUsername())
                                        .filter(strings -> !strings.isEmpty())
                                        .flatMap(strings -> {
                                            if (getFilters(strings, pageNo, request).isEmpty()) {
                                                return Mono.just(ResponseEntity.ok(ModeThreesResponse.builder()
                                                        .status("S1000")
                                                        .statusDescription("Success")
                                                        .sessions(new ArrayList<>())
                                                        .build()));
                                            } else {
                                                Pageable pageable = PageRequest.of(Integer.parseInt(pageNo), 20);

                                                return modeThreeRepository.findByFilters(getFilters(strings, pageNo, request), pageable)
                                                        .flatMap(modeThree -> {
                                                            log.info("Mode three found with id [{}]", modeThree.getDefaultConfigurations().getSessionId());
                                                            return Mono.just(modeThreeMapper.modeThreeToModeThreeDto(modeThree));
                                                        })
                                                        .collectList()
                                                        .flatMap(modeThreeDtos -> Mono.just(ResponseEntity.ok(ModeThreesResponse.builder()
                                                                .status("S1000")
                                                                .statusDescription("Success")
                                                                .sessions(modeThreeDtos)
                                                                .build())));
                                            }
                                        })
                                        .switchIfEmpty(Mono.just(ResponseEntity.ok(ModeThreesResponse.builder()
                                                .status("S1000")
                                                .statusDescription("Success")
                                                .sessions(new ArrayList<>())
                                                .build())));
                            } else {
                                return Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(ModeThreesResponse.builder()
                                        .status("E1200")
                                        .statusDescription("You are not authorized to use this service").build()));
                            }
                        })
                )
                .switchIfEmpty(Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(ModeThreesResponse.builder()
                        .status("E1220")
                        .statusDescription("Failed")
                        .build())));
    }

    public Mono<ResponseEntity<ModeFoursResponse>> getAllModeFour(String pageNo, SessionSearchRequest request, String jwt) {
        return userService.getUser(jwtUtils.getUsername(jwt))
                .flatMap(user -> userGroupRoleService.getUserRolesByUserGroup(user.getGroup())
                        .flatMap(userRoles -> {
                            if (userRoles.contains(UserRoles.GET_MODE_FOUR)) {
                                return userService.getUsersByAdmin(user.getUsername())
                                        .filter(strings -> !strings.isEmpty())
                                        .flatMap(strings -> {
                                            if (getFilters(strings, pageNo, request).isEmpty()) {
                                                return Mono.just(ResponseEntity.ok(ModeFoursResponse.builder()
                                                        .status("S1000")
                                                        .statusDescription("Success")
                                                        .sessions(new ArrayList<>())
                                                        .build()));
                                            } else {
                                                Pageable pageable = PageRequest.of(Integer.parseInt(pageNo), 20);

                                                return modeFourRepository.findByFilters(getFilters(strings, pageNo, request), pageable)
                                                        .flatMap(modeFour -> {
                                                            log.info("Mode four found with id [{}]", modeFour.getDefaultConfigurations().getSessionId());
                                                            return Mono.just(modeFourMapper.modeFourToModeFourDto(modeFour));
                                                        })
                                                        .collectList()
                                                        .flatMap(modeFourDtos -> Mono.just(ResponseEntity.ok(ModeFoursResponse.builder()
                                                                .status("S1000")
                                                                .statusDescription("Success")
                                                                .sessions(modeFourDtos)
                                                                .build())));
                                            }
                                        })
                                        .switchIfEmpty(Mono.just(ResponseEntity.ok(ModeFoursResponse.builder()
                                                .status("S1000")
                                                .statusDescription("Success")
                                                .sessions(new ArrayList<>())
                                                .build())));
                            } else {
                                return Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(ModeFoursResponse.builder()
                                        .status("E1200")
                                        .statusDescription("You are not authorized to use this service").build()));
                            }
                        })
                )
                .switchIfEmpty(Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(ModeFoursResponse.builder()
                        .status("E1220")
                        .statusDescription("Failed")
                        .build())));
    }

    public Mono<ResponseEntity<ModeFiveResponse>> getAllModeFive(String pageNo, SessionSearchRequest request, String jwt) {
        return userService.getUser(jwtUtils.getUsername(jwt))
                .flatMap(user -> userGroupRoleService.getUserRolesByUserGroup(user.getGroup())
                        .flatMap(userRoles -> {
                            if (userRoles.contains(UserRoles.GET_MODE_FIVE)) {
                                return userService.getUsersByAdmin(user.getUsername())
                                        .filter(strings -> !strings.isEmpty())
                                        .flatMap(strings -> {
                                            if (getFilters(strings, pageNo, request).isEmpty()) {
                                                return Mono.just(ResponseEntity.ok(ModeFiveResponse.builder()
                                                        .status("S1000")
                                                        .statusDescription("Success")
                                                        .sessions(new ArrayList<>())
                                                        .build()));
                                            } else {
                                                Pageable pageable = PageRequest.of(Integer.parseInt(pageNo), 20);

                                                return modeFiveRepository.findByFilters(getFilters(strings, pageNo, request), pageable)
                                                        .flatMap(modeFive -> {
                                                            log.info("Mode five found with id [{}]", modeFive.getDefaultConfigurations().getSessionId());
                                                            return Mono.just(modeFiveMapper.modeFiveToModeFiveDto(modeFive));
                                                        })
                                                        .collectList()
                                                        .flatMap(modeFiveDtos -> Mono.just(ResponseEntity.ok(ModeFiveResponse.builder()
                                                                .status("S1000")
                                                                .statusDescription("Success")
                                                                .sessions(modeFiveDtos)
                                                                .build())));
                                            }
                                        })
                                        .switchIfEmpty(Mono.just(ResponseEntity.ok(ModeFiveResponse.builder()
                                                .status("S1000")
                                                .statusDescription("Success")
                                                .sessions(new ArrayList<>())
                                                .build())));
                            } else {
                                return Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(ModeFiveResponse.builder()
                                        .status("E1200")
                                        .statusDescription("You are not authorized to use this service").build()));
                            }
                        })
                )
                .switchIfEmpty(Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(ModeFiveResponse.builder()
                        .status("E1220")
                        .statusDescription("Failed")
                        .build())));
    }

    public Mono<ResponseEntity<ModeSixResponse>> getAllModeSix(String pageNo, SessionSearchRequest request, String jwt) {
        return userService.getUser(jwtUtils.getUsername(jwt))
                .flatMap(user -> userGroupRoleService.getUserRolesByUserGroup(user.getGroup())
                        .flatMap(userRoles -> {
                            if (userRoles.contains(UserRoles.GET_MODE_SIX)) {
                                return userService.getUsersByAdmin(user.getUsername())
                                        .filter(strings -> !strings.isEmpty())
                                        .flatMap(strings -> {
                                            if (getFilters(strings, pageNo, request).isEmpty()) {
                                                return Mono.just(ResponseEntity.ok(ModeSixResponse.builder()
                                                        .status("S1000")
                                                        .statusDescription("Success")
                                                        .sessions(new ArrayList<>())
                                                        .build()));
                                            } else {
                                                Pageable pageable = PageRequest.of(Integer.parseInt(pageNo), 20);

                                                return modeSixRepository.findByFilters(getFilters(strings, pageNo, request), pageable)
                                                        .flatMap(modeSix -> {
                                                            log.info("Mode six found with id [{}]", modeSix.getDefaultConfigurations().getSessionId());
                                                            return Mono.just(modeSixMapper.modeSixToModeSixDto(modeSix));
                                                        })
                                                        .collectList()
                                                        .flatMap(modeFourDtos -> Mono.just(ResponseEntity.ok(ModeSixResponse.builder()
                                                                .status("S1000")
                                                                .statusDescription("Success")
                                                                .sessions(modeFourDtos)
                                                                .build())));
                                            }
                                        })
                                        .switchIfEmpty(Mono.just(ResponseEntity.ok(ModeSixResponse.builder()
                                                .status("S1000")
                                                .statusDescription("Success")
                                                .sessions(new ArrayList<>())
                                                .build())));
                            } else {
                                return Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(ModeSixResponse.builder()
                                        .status("E1200")
                                        .statusDescription("You are not authorized to use this service").build()));
                            }
                        })
                )
                .switchIfEmpty(Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(ModeSixResponse.builder()
                        .status("E1220")
                        .statusDescription("Failed")
                        .build())));
    }

    private String getFilters(List<String> users, String pageNo, SessionSearchRequest request) {
        StringBuilder stringBuilder = new StringBuilder();

        if (!request.getFilterType().isEmpty() && !request.getFilterValue().isEmpty()) {
            if (FilterType.valueOf(request.getFilterType()) != FilterType.CREATED_BY) {
                if (users.size() > 0) {
                    stringBuilder.append("{ '$and': [")
                            .append("{'created-by': { '$in' : ")
                            .append(concatenateStrings(users))
                            .append("}}");
                }

                if (!stringBuilder.toString().isEmpty()) {
                    stringBuilder.append(", ");
                }

                switch (FilterType.valueOf(request.getFilterType())) {
                    case BATCH_NO -> stringBuilder.append("{ 'default-configurations.batch-no' : { $regex : '.*")
                            .append(request.getFilterValue())
                            .append(".*', $options: 'i'}}");
                    case SESSION_ID -> stringBuilder.append("{'default-configurations.session-id': { $regex : '.*")
                            .append(request.getFilterValue())
                            .append(".*', $options: 'i'}}");
                    case OPERATOR_ID -> stringBuilder.append("{'default-configurations.operator-id': { $regex : '.*")
                            .append(request.getFilterValue())
                            .append(".*', $options: 'i'}}");
                    case CUSTOMER_NAME ->
                            stringBuilder.append("{'default-configurations.customer-name': { $regex : '.*")
                                    .append(request.getFilterValue())
                                    .append(".*', $options: 'i'}}");
                }

            } else if (checkUserRegexMatchWithUsers(users, request.getFilterValue())) {
                stringBuilder.append("{'$and':[{")
                        .append("'created-by': { $regex : '.*")
                        .append(request.getFilterValue())
                        .append(".*', $options: 'i'}}");
            } else {
                if (users.size() > 0) {
                    stringBuilder.append("{'$and':[{")
                            .append("'created-by': { '$in' : ")
                            .append(concatenateStrings(users))
                            .append("}}");
                }
            }
        } else {
            if (users.size() > 0) {
                stringBuilder.append("{'$and':[{")
                        .append("'created-by': { '$in' : ")
                        .append(concatenateStrings(users))
                        .append("}}");
            }
        }

//        if (request.getDate() != null && !request.getDate().isEmpty()) {
//            DateTimeFormatter formatter = DateTimeFormatter.ISO_OFFSET_DATE_TIME;
//            LocalDateTime lastDateStart = LocalDateTime.of(LocalDateTime.parse(request.getDate(), formatter).toLocalDate(), LocalTime.MIDNIGHT);
//            LocalDateTime lastDateEnd = LocalDateTime.of(LocalDateTime.parse(request.getDate(), formatter).toLocalDate(), LocalTime.MAX);
//            log.info("Finding treatments between [{}] and [{}]", lastDateStart, lastDateEnd);
//
//            stringBuilder.append(", { 'created-date' : { $gt : ISODate('")
//                    .append(lastDateStart)
////                    .append("', $lt: '")
////                    .append(lastDateEnd)
//                    .append("') }}");
//        }

        stringBuilder.append("]}");


        log.info("AAAAAAAAAAAA :  {}", stringBuilder.toString());
        return stringBuilder.toString();
    }

    public String concatenateStrings(List<String> list) {
        if (list == null || list.isEmpty()) {
            return "[]"; // or throw an exception if desired
        }

        StringBuilder sb = new StringBuilder();
        sb.append("[");

        for (int i = 0; i < list.size(); i++) {
            sb.append("'").append(list.get(i)).append("'");

            if (i < list.size() - 1) {
                sb.append(", ");
            }
        }

        sb.append("]");

        return sb.toString();
    }

    private boolean checkUserRegexMatchWithUsers(List<String> users, String pattern) {
        AtomicBoolean contain = new AtomicBoolean(false);
        users.forEach(s -> {
            if (s.contains(pattern)) {
                contain.set(true);
            }
        });
        return contain.get();
    }

    public Mono<ResponseEntity<ShareReportResponse>> shareReport(String mode, String sessionId, String auth) {
        return userService.getUser(jwtUtils.getUsername(auth))
                .flatMap(user -> userGroupRoleService.getUserRolesByUserGroup(user.getGroup())
                        .flatMap(userRoles -> {
                            if (userRoles.contains(UserRoles.SHARE_REPORT)) {
                                return Mono.just(mode)
                                        .doOnNext(modeId -> log.info("Share report request received for mode [{}] and session id [{}]", modeId, sessionId))
                                        .flatMap(s -> {
                                            Report report = Report.builder()
                                                    .sessionId(sessionId)
                                                    .modeType(Integer.parseInt(mode))
                                                    .createdBy(user.getUsername())
                                                    .password(getRandomPassword())
                                                    .urlHash(getUrlHash())
                                                    .accessAttempts(0)
                                                    .createdDateTime(LocalDateTime.now())
                                                    .status("ACTIVE")
                                                    .build();
                                            return repository.save(report)
                                                    .flatMap(report1 -> Mono.just(ResponseEntity.ok(ShareReportResponse.builder()
                                                            .status("S1000")
                                                            .statusDescription("Success")
                                                            .url(reportUrl + report1.getUrlHash())
                                                            .password(report1.getPassword())
                                                            .build())));
                                        })
                                        .doOnError(e ->
                                                ResponseEntity.ok(ShareReportResponse.builder()
                                                        .status("E1000")
                                                        .statusDescription("Failed")
                                                        .build()));
                            } else {
                                return Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(ShareReportResponse.builder()
                                        .status("E1200")
                                        .statusDescription("You are not authorized to use this service").build()));
                            }
                        })
                )
                .switchIfEmpty(Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(ShareReportResponse.builder()
                        .status("E1200")
                        .statusDescription("Failed")
                        .build())));
    }

    public String getRandomPassword() {
        StringBuilder password = new StringBuilder(10);
        SecureRandom random = new SecureRandom();

        for (int i = 0; i < 10; i++) {
            int randomIndex = random.nextInt(CHARACTERS.length());
            char randomChar = CHARACTERS.charAt(randomIndex);
            password.append(randomChar);
        }

        return password.toString();
    }

    public static String getUrlHash() {
        SecureRandom random = new SecureRandom();
        byte[] salt = new byte[32];
        random.nextBytes(salt);

        StringBuilder hashBuilder = new StringBuilder();

        try {
            MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
            byte[] hashBytes = messageDigest.digest(salt);

            for (byte b : hashBytes) {
                hashBuilder.append(String.format("%02x", b));
            }
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }

        return hashBuilder.toString();
    }

    public Mono<ResponseEntity<CommonResponse>> checkReportStatus(String hash) {
        log.info("Report url hash validation request received with hash [{}]", hash);
        return repository.findByHash(hash)
                .flatMap(report -> Mono.just(ResponseEntity.ok(CommonResponse.success())))
                .switchIfEmpty(Mono.just(ResponseEntity.ok(CommonResponse.fail())))
                .onErrorResume(throwable -> Mono.just(ResponseEntity.ok(CommonResponse.fail())));
    }

    public Mono<ResponseEntity<PasswordValidationReportResponse>> checkReportPassword(String hash, ReportPasswordValidationRequest request) {
        return repository.findByHash(hash)
                .flatMap(report ->
                {
                    if (Objects.equals(report.getPassword(), request.getPassword())) {
                        switch (report.getModeType()) {
                            case 1:
                                return modeOneRepository.findBySessionID(report.getSessionId())
                                        .flatMap(modeOne -> Mono.just(ResponseEntity.ok(PasswordValidationReportResponse.builder()
                                                .status("S1000")
                                                .statusDescription("Success")
                                                .modeId(1)
                                                .modeOneDto(modeOneMapper.modeOneToModeOneDto(modeOne))
                                                .build())));
                            case 2:
                                return modeTwoRepository.findBySessionID(report.getSessionId())
                                        .flatMap(modeTwo -> Mono.just(ResponseEntity.ok(PasswordValidationReportResponse.builder()
                                                .status("S1000")
                                                .statusDescription("Success")
                                                .modeId(2)
                                                .modeTwoDto(modeTwoMapper.modeTwoToModeTwoDto(modeTwo))
                                                .build())));
                            case 3:
                                return modeThreeRepository.findBySessionID(report.getSessionId())
                                        .flatMap(modeThree -> Mono.just(ResponseEntity.ok(PasswordValidationReportResponse.builder()
                                                .status("S1000")
                                                .statusDescription("Success")
                                                .modeId(3)
                                                .modeThreeDto(modeThreeMapper.modeThreeToModeThreeDto(modeThree))
                                                .build())));
                            case 4:
                                return modeFourRepository.findBySessionID(report.getSessionId())
                                        .flatMap(mo -> Mono.just(ResponseEntity.ok(PasswordValidationReportResponse.builder()
                                                .status("S1000")
                                                .statusDescription("Success")
                                                .modeId(4)
                                                .modeFourDto(modeFourMapper.modeFourToModeFourDto(mo))
                                                .build())));
                            case 5:
                                return modeFiveRepository.findBySessionID(report.getSessionId())
                                        .flatMap(modeFive -> Mono.just(ResponseEntity.ok(PasswordValidationReportResponse.builder()
                                                .status("S1000")
                                                .statusDescription("Success")
                                                .modeId(5)
                                                .modeFiveDto(modeFiveMapper.modeFiveToModeFiveDto(modeFive))
                                                .build())));
                            case 6:
                                return modeSixRepository.findBySessionID(report.getSessionId())
                                        .flatMap(modeSix -> Mono.just(ResponseEntity.ok(PasswordValidationReportResponse.builder()
                                                .status("S1000")
                                                .statusDescription("Success")
                                                .modeId(6)
                                                .modeSixDto(modeSixMapper.modeSixToModeSixDto(modeSix))
                                                .build())));
                            default:
                                return Mono.just(ResponseEntity.ok(PasswordValidationReportResponse.builder()
                                        .status("E1000")
                                        .statusDescription("Failed")
                                        .build()));
                        }
                    } else {
                        return Mono.just(ResponseEntity.ok(PasswordValidationReportResponse.builder()
                                .status("E1000")
                                .statusDescription("Failed")
                                .build()));
                    }
                })
                .switchIfEmpty(Mono.just(ResponseEntity.ok(PasswordValidationReportResponse.builder()
                        .status("E1000")
                        .statusDescription("Failed")
                        .build())))
                .onErrorResume(throwable -> Mono.just(ResponseEntity.ok(PasswordValidationReportResponse.builder()
                        .status("E1000")
                        .statusDescription("Failed")
                        .build())));
    }
}