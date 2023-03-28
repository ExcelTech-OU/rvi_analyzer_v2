package com.rvi.analyzer.rvianalyzerserver.service;

import com.rvi.analyzer.rvianalyzerserver.domain.CommonResponse;
import com.rvi.analyzer.rvianalyzerserver.dto.DeviceDto;
import com.rvi.analyzer.rvianalyzerserver.mappers.DeviceMapper;
import com.rvi.analyzer.rvianalyzerserver.repository.DeviceRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Mono;

import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
@Slf4j
public class DeviceService {

    final private DeviceRepository deviceRepository;

    final private DeviceMapper deviceMapper;

    public Mono<CommonResponse> addDevice(DeviceDto deviceDto) {
        return Mono.just(deviceDto)
                .doOnNext(deviceDto1 -> log.info("Device add request received [{}]", deviceDto1))
                .flatMap(deviceDto1 -> deviceRepository.findByMacAddress(deviceDto1.getMacAddress()))
                .flatMap(device -> Mono.just(CommonResponse.builder()
                        .status("E1001")
                        .statusDescription("Device Already exist with mac")
                        .build()))
                .switchIfEmpty(saveDevice(deviceDto))
                .doOnError(e ->
                        CommonResponse.builder()
                                .status("E1000")
                                .statusDescription("Failed")
                                .build());

    }

    Mono<CommonResponse> saveDevice(DeviceDto deviceDto) {
        return Mono.just(deviceMapper.deviceDtoToDevice(deviceDto))
                .doOnNext(device -> {
                    device.setStatus("ACTIVE");
                    device.setCreatedDateTime(LocalDateTime.now());
                })
                .flatMap(deviceRepository::insert)
                .doOnSuccess(device -> log.info("Successfully saved the device [{}]", device))
                .map(device -> CommonResponse.builder()
                        .status("S1000")
                        .statusDescription("Success")
                        .build());
    }
}
