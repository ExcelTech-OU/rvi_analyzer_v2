package com.rvi.analyzer.rvianalyzerserver.service;

import com.rvi.analyzer.rvianalyzerserver.domain.*;
import com.rvi.analyzer.rvianalyzerserver.dto.*;
import com.rvi.analyzer.rvianalyzerserver.entiy.ModeOne;
import com.rvi.analyzer.rvianalyzerserver.entiy.ModeTwo;
import com.rvi.analyzer.rvianalyzerserver.mappers.*;
import com.rvi.analyzer.rvianalyzerserver.repository.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Mono;

import java.time.LocalDateTime;
import java.util.Objects;

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

    public Mono<CommonResponse> addModeOne(ModeOneDto modeOneDto) {
        return Mono.just(modeOneDto)
                .doOnNext(modeOneDto1 -> log.info("MOde one add request received [{}]", modeOneDto1))
                .flatMap(modeOneDto1 -> modeOneRepository.findBySessionID(modeOneDto1.getDefaultConfigurations().getSessionId()))
                .flatMap(modeOne -> Mono.just(modeOne)
                        .filter(mOne -> mOne.getResults().stream().anyMatch(i -> Objects.equals(i.getTestId(), modeOneDto.getResults().get(0).getTestId())))
                        .flatMap(modeOne1 ->
                                Mono.just(CommonResponse.builder()
                                        .status("E1010")
                                        .statusDescription("Mode Already exist with taskID")
                                        .build())
                        ).switchIfEmpty(updateSessionOne(modeOneDto, modeOne))
                )
                .switchIfEmpty(saveModeOne(modeOneDto))
                .doOnError(e ->
                        CommonResponse.builder()
                                .status("E1000")
                                .statusDescription("Failed")
                                .build());

    }

    private Mono<CommonResponse> updateSessionOne(ModeOneDto modeOneDto, ModeOne modeOne) {
        return Mono.just(modeOne)
                .doOnNext(modeOne1 -> {
                    modeOneDto.getResults().get(0).getReadings().get(0).setReadAt(LocalDateTime.now());
                    modeOne.getResults().add(modeOneDto.getResults().get(0));
                    modeOne.setLastUpdatedDateTime(LocalDateTime.now());
                })
                .flatMap(modeOneRepository::save)
                .doOnSuccess(mOne -> log.info("Successfully updated the Mode One [{}]", mOne))
                .map(device -> CommonResponse.builder()
                        .status("S1000")
                        .statusDescription("Success")
                        .build());
    }

    private Mono<CommonResponse> saveModeOne(ModeOneDto modeOneDto) {
        return Mono.just(modeOneMapper.modeOneDtoToModeOne(modeOneDto))
                .doOnNext(modeOne -> {
                    modeOne.setStatus("ACTIVE");
                    modeOne.setCreatedDateTime(LocalDateTime.now());
                    modeOne.setLastUpdatedDateTime(LocalDateTime.now());
                    modeOne.getResults().get(0).getReadings().get(0).setReadAt(LocalDateTime.now());
                })
                .flatMap(modeOneRepository::save)
                .doOnSuccess(device -> log.info("Successfully saved the Mode One [{}]", device))
                .map(device -> CommonResponse.builder()
                        .status("S1000")
                        .statusDescription("Success")
                        .build());
    }

    // Mode Two related services
    public Mono<CommonResponse> addModeTwo(ModeTwoDto modeTwoDto) {
        return Mono.just(modeTwoDto)
                .doOnNext(modeTwoDto1 -> log.info("MOde Two add request received [{}]", modeTwoDto1))
                .flatMap(modeTwoDto1 -> modeTwoRepository.findBySessionID(modeTwoDto1.getDefaultConfigurations().getSessionId()))
                .flatMap(modeTwo -> Mono.just(modeTwo)
                        .filter(mOne -> mOne.getResults().stream().anyMatch(i -> Objects.equals(i.getTestId(), modeTwoDto.getResults().get(0).getTestId())))
                        .flatMap(modeTwo1 ->
                                Mono.just(CommonResponse.builder()
                                        .status("E1010")
                                        .statusDescription("Mode Already exist with taskID")
                                        .build())
                        ).switchIfEmpty(updateSessionTwo(modeTwoDto, modeTwo))
                )
                .switchIfEmpty(saveModeTwo(modeTwoDto))
                .doOnError(e ->
                        CommonResponse.builder()
                                .status("E1000")
                                .statusDescription("Failed")
                                .build());

    }

    private Mono<CommonResponse> updateSessionTwo(ModeTwoDto modeTwoDto, ModeTwo modeTwo) {
        System.out.println(modeTwo);
        return Mono.just(modeTwo)
                .doOnNext(modeTwo1 -> {
                    modeTwoDto.getResults().get(0).getReadings().get(0).setReadAt(LocalDateTime.now());
                    modeTwo.getResults().add(modeTwoDto.getResults().get(0));
                    modeTwo.setLastUpdatedDateTime(LocalDateTime.now());
                })
                .flatMap(modeTwoRepository::save)
                .doOnSuccess(mOne -> log.info("Successfully updated the Mode Two [{}]", mOne))
                .map(device -> CommonResponse.builder()
                        .status("S1000")
                        .statusDescription("Success")
                        .build());
    }

    private Mono<CommonResponse> saveModeTwo(ModeTwoDto modeTwoDto) {
        return Mono.just(modeTwoMapper.modeTwoDtoToModeTwo(modeTwoDto))
                .doOnNext(modeTwo -> {
                    modeTwo.setStatus("ACTIVE");
                    modeTwo.setCreatedDateTime(LocalDateTime.now());
                    modeTwo.setLastUpdatedDateTime(LocalDateTime.now());
                    modeTwo.getResults().get(0).getReadings().get(0).setReadAt(LocalDateTime.now());
                })
                .flatMap(modeTwoRepository::save)
                .doOnSuccess(device -> log.info("Successfully saved the Mode Two [{}]", device))
                .map(device -> CommonResponse.builder()
                        .status("S1000")
                        .statusDescription("Success")
                        .build());
    }

    // Mode Three related services
    public Mono<CommonResponse> addModeThree(ModeThreeDto modeThreeDto) {
        return Mono.just(modeThreeDto)
                .doOnNext(modeThreeDto1 -> log.info("MOde three add request received [{}]", modeThreeDto1))
                .flatMap(modeThreeDto1 -> modeThreeRepository.findBySessionID(modeThreeDto1.getDefaultConfigurations().getSessionId()))
                .flatMap(modeThree -> Mono.just(CommonResponse.builder()
                                .status("E1010")
                                .statusDescription("Mode Already exist with taskID, Session Id")
                                .build()
                        )
                )
                .switchIfEmpty(saveModeThree(modeThreeDto))
                .doOnError(e ->
                        CommonResponse.builder()
                                .status("E1000")
                                .statusDescription("Failed")
                                .build());

    }

    private Mono<CommonResponse> saveModeThree(ModeThreeDto ModeThreeDto) {
        return Mono.just(modeThreeMapper.modeThreeDtoToModeThree(ModeThreeDto))
                .doOnNext(modeThree -> {
                    modeThree.setStatus("ACTIVE");
                    modeThree.setCreatedDateTime(LocalDateTime.now());
                    modeThree.setLastUpdatedDateTime(LocalDateTime.now());
                })
                .flatMap(modeThreeRepository::save)
                .doOnSuccess(device -> log.info("Successfully saved the Mode Three [{}]", device))
                .map(device -> CommonResponse.builder()
                        .status("S1000")
                        .statusDescription("Success")
                        .build());
    }

    // Mode Four related services
    public Mono<CommonResponse> addModeFour(ModeFourDto modeFourDto) {
        return Mono.just(modeFourDto)
                .doOnNext(modeFourDto1 -> log.info("MOde four add request received [{}]", modeFourDto1))
                .flatMap(modeFourDto1 -> modeFourRepository.findBySessionID(modeFourDto1.getDefaultConfigurations().getSessionId()))
                .flatMap(modeFour -> Mono.just(CommonResponse.builder()
                        .status("E1010")
                        .statusDescription("Mode Already exist with taskID, Session Id")
                        .build())

                )
                .switchIfEmpty(saveModeFour(modeFourDto))
                .doOnError(e ->
                        CommonResponse.builder()
                                .status("E1000")
                                .statusDescription("Failed")
                                .build());

    }

    private Mono<CommonResponse> saveModeFour(ModeFourDto modeFourDto) {
        return Mono.just(modeFourMapper.modeFourDtoToModeFour(modeFourDto))
                .doOnNext(modeFour -> {
                    modeFour.setStatus("ACTIVE");
                    modeFour.setCreatedDateTime(LocalDateTime.now());
                    modeFour.setLastUpdatedDateTime(LocalDateTime.now());
                })
                .flatMap(modeFourRepository::save)
                .doOnSuccess(device -> log.info("Successfully saved the Mode Four [{}]", device))
                .map(device -> CommonResponse.builder()
                        .status("S1000")
                        .statusDescription("Success")
                        .build());
    }

    // Mode Five related services
    public Mono<CommonResponse> addModeFive(ModeFiveDto modeFiveDto) {
        return Mono.just(modeFiveDto)
                .doOnNext(modeFiveDto1 -> log.info("MOde five add request received [{}]", modeFiveDto1))
                .flatMap(modeFiveDto1 -> modeFiveRepository.findBySessionID(modeFiveDto1.getDefaultConfigurations().getSessionId()))
                .flatMap(modeFive -> Mono.just(CommonResponse.builder()
                        .status("E1010")
                        .statusDescription("Mode Already exist with taskID, Session Id")
                        .build())

                )
                .switchIfEmpty(saveModeFive(modeFiveDto))
                .doOnError(e ->
                        CommonResponse.builder()
                                .status("E1000")
                                .statusDescription("Failed")
                                .build());

    }

    private Mono<CommonResponse> saveModeFive(ModeFiveDto modeFiveDto) {
        return Mono.just(modeFiveMapper.modeFiveDtoToModeFive(modeFiveDto))
                .doOnNext(modeFive -> {
                    modeFive.setStatus("ACTIVE");
                    modeFive.setCreatedDateTime(LocalDateTime.now());
                    modeFive.setLastUpdatedDateTime(LocalDateTime.now());
                })
                .flatMap(modeFiveRepository::save)
                .doOnSuccess(device -> log.info("Successfully saved the Mode Five [{}]", device))
                .map(device -> CommonResponse.builder()
                        .status("S1000")
                        .statusDescription("Success")
                        .build());
    }

    // Mode Six related services
    public Mono<CommonResponse> addModeSix(ModeSixDto modeSixDto) {
        return Mono.just(modeSixDto)
                .doOnNext(modeSixDto1 -> log.info("MOde six add request received [{}]", modeSixDto1))
                .flatMap(modeSixDto1 -> modeSixRepository.findBySessionID(modeSixDto1.getDefaultConfigurations().getSessionId()))
                .flatMap(modeSix -> Mono.just(CommonResponse.builder()
                        .status("E1010")
                        .statusDescription("Mode Already exist with taskID, Session Id")
                        .build())

                )
                .switchIfEmpty(saveModeSix(modeSixDto))
                .doOnError(e ->
                        CommonResponse.builder()
                                .status("E1000")
                                .statusDescription("Failed")
                                .build());

    }

    private Mono<CommonResponse> saveModeSix(ModeSixDto modeSixDto) {
        return Mono.just(modeSixMapper.modeSixDtoToModeSix(modeSixDto))
                .doOnNext(modeSix -> {
                    modeSix.setStatus("ACTIVE");
                    modeSix.setCreatedDateTime(LocalDateTime.now());
                    modeSix.setLastUpdatedDateTime(LocalDateTime.now());
                })
                .flatMap(modeSixRepository::save)
                .doOnSuccess(device -> log.info("Successfully saved the Mode Six [{}]", device))
                .map(device -> CommonResponse.builder()
                        .status("S1000")
                        .statusDescription("Success")
                        .build());
    }

    public Mono<ModeOnesResponse> getAllModeOne() {
        return modeOneRepository.findAll()
                .flatMap(modeOne -> {
                    log.info("Mode one found with id [{}]", modeOne.getDefaultConfigurations().getSessionId());
                    return Mono.just(modeOneMapper.modeOneToModeOneDto(modeOne));
                })
                .collectList()
                .flatMap(modeOneDtos -> Mono.just(ModeOnesResponse.builder()
                        .status("S1000")
                        .statusDescription("Success")
                        .sessions(modeOneDtos)
                        .build()));
    }

    public Mono<ModeTwosResponse> getAllModeTwos() {
        return modeTwoRepository.findAll()
                .flatMap(modeTwo -> {
                    log.info("Mode two found with id [{}]", modeTwo.getDefaultConfigurations().getSessionId());
                    return Mono.just(modeTwoMapper.modeTwoToModeTwoDto(modeTwo));
                })
                .collectList()
                .flatMap(modeTwoDtos -> Mono.just(ModeTwosResponse.builder()
                        .status("S1000")
                        .statusDescription("Success")
                        .sessions(modeTwoDtos)
                        .build()));
    }

    public Mono<ModeThreesResponse> getAllModeThrees() {
        return modeThreeRepository.findAll()
                .flatMap(modeThree -> {
                    log.info("Mode three found with id [{}]", modeThree.getDefaultConfigurations().getSessionId());
                    return Mono.just(modeThreeMapper.modeThreeToModeThreeDto(modeThree));
                })
                .collectList()
                .flatMap(modeThreeDtos -> Mono.just(ModeThreesResponse.builder()
                        .status("S1000")
                        .statusDescription("Success")
                        .sessions(modeThreeDtos)
                        .build()));
    }

    public Mono<ModeFoursResponse> getAllModeFour() {
        return modeFourRepository.findAll()
                .flatMap(modeFour -> {
                    log.info("Mode four found with id [{}]", modeFour.getDefaultConfigurations().getSessionId());
                    return Mono.just(modeFourMapper.modeFourToModeFourDto(modeFour));
                })
                .collectList()
                .flatMap(modeFourDtos -> Mono.just(ModeFoursResponse.builder()
                        .status("S1000")
                        .statusDescription("Success")
                        .sessions(modeFourDtos)
                        .build()));
    }

    public Mono<ModeSixResponse> getAllModeSix() {
        return modeSixRepository.findAll()
                .flatMap(modeSix -> {
                    log.info("Mode six found with id [{}]", modeSix.getDefaultConfigurations().getSessionId());
                    return Mono.just(modeSixMapper.modeSixToModeSixDto(modeSix));
                })
                .collectList()
                .flatMap(modeFourDtos -> Mono.just(ModeSixResponse.builder()
                        .status("S1000")
                        .statusDescription("Success")
                        .sessions(modeFourDtos)
                        .build()));
    }

    public Mono<ModeFiveResponse> getAllModeFive() {
        return modeFiveRepository.findAll()
                .flatMap(modeFive -> {
                    log.info("Mode five found with id [{}]", modeFive.getDefaultConfigurations().getSessionId());
                    return Mono.just(modeFiveMapper.modeFiveToModeFiveDto(modeFive));
                })
                .collectList()
                .flatMap(modeFiveDtos -> Mono.just(ModeFiveResponse.builder()
                        .status("S1000")
                        .statusDescription("Success")
                        .sessions(modeFiveDtos)
                        .build()));
    }
}
