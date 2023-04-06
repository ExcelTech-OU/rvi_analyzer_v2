package com.rvi.analyzer.rvianalyzerserver.service;

import com.rvi.analyzer.rvianalyzerserver.domain.CommonResponse;
import com.rvi.analyzer.rvianalyzerserver.dto.ModeOneDto;
import com.rvi.analyzer.rvianalyzerserver.dto.ModeThreeDto;
import com.rvi.analyzer.rvianalyzerserver.dto.ModeTwoDto;
import com.rvi.analyzer.rvianalyzerserver.entiy.ModeOne;
import com.rvi.analyzer.rvianalyzerserver.entiy.ModeThree;
import com.rvi.analyzer.rvianalyzerserver.entiy.ModeTwo;
import com.rvi.analyzer.rvianalyzerserver.mappers.ModeOneMapper;
import com.rvi.analyzer.rvianalyzerserver.mappers.ModeThreeMapper;
import com.rvi.analyzer.rvianalyzerserver.mappers.ModeTwoMapper;
import com.rvi.analyzer.rvianalyzerserver.repository.ModeOneRepository;
import com.rvi.analyzer.rvianalyzerserver.repository.ModeThreeRepository;
import com.rvi.analyzer.rvianalyzerserver.repository.ModeTwoRepository;
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
    final private ModeOneRepository modeOneRepository;
    final private ModeTwoRepository modeTwoRepository;
    final private ModeThreeRepository modeThreeRepository;

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
        return Mono.just(modeTwo)
                .doOnNext(modeOne1 -> {
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
                .doOnNext(modeThreeDto1 -> log.info("MOde Two add request received [{}]", modeThreeDto1))
                .flatMap(modeThreeDto1 -> modeThreeRepository.findBySessionID(modeThreeDto1.getDefaultConfigurations().getSessionId()))
                .flatMap(modeThree -> Mono.just(modeThree)
                        .filter(mOne -> Objects.equals(mOne.getResults().getTestId(), modeThreeDto.getResults().getTestId()))
                        .flatMap(modeThree1 ->
                                Mono.just(CommonResponse.builder()
                                        .status("E1010")
                                        .statusDescription("Mode Already exist with taskID, Session Id")
                                        .build())
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
        return Mono.just(modeThreeMapper.ModeThreeDtoToModeThree(ModeThreeDto))
                .doOnNext(modeThree -> {
                    modeThree.setStatus("ACTIVE");
                    modeThree.setCreatedDateTime(LocalDateTime.now());
                    modeThree.setLastUpdatedDateTime(LocalDateTime.now());
                    modeThree.getResults().getReadings().get(0).setReadAt(LocalDateTime.now());
                })
                .flatMap(modeThreeRepository::save)
                .doOnSuccess(device -> log.info("Successfully saved the Mode Three [{}]", device))
                .map(device -> CommonResponse.builder()
                        .status("S1000")
                        .statusDescription("Success")
                        .build());
    }
}
