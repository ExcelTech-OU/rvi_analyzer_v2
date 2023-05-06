package com.rvi.analyzer.rvianalyzerserver.service;

import com.rvi.analyzer.rvianalyzerserver.domain.*;
import com.rvi.analyzer.rvianalyzerserver.dto.DeviceDto;
import com.rvi.analyzer.rvianalyzerserver.mappers.DeviceMapper;
import com.rvi.analyzer.rvianalyzerserver.repository.DeviceRepository;
import com.rvi.analyzer.rvianalyzerserver.repository.UserRepository;
import com.rvi.analyzer.rvianalyzerserver.security.JwtUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Mono;

import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
@Slf4j
public class DeviceService {

    final private DeviceRepository deviceRepository;
    final private UserRepository userRepository;
    final private JwtUtils jwtUtils;
    final private UserGroupRoleService userGroupRoleService;

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

    public Mono<ResponseEntity<CommonResponse>> updateDevice(UpdateDeviceRequestByName req, String jwt) {
        return userRepository.findByUsername(jwtUtils.getUsername(jwt))
                .flatMap(user -> userGroupRoleService.getUserRolesByUserGroup(user.getGroup())
                        .flatMap(userRoles -> {
                            if (userRoles.contains(UserRoles.UPDATE_DEVICE)) {
                                return deviceRepository.findByMacAddress(req.getName())
                                        .flatMap(device -> {
                                            device.setStatus(req.getStatus());
                                            log.info("going to save device [{}]", device);
                                            return deviceRepository.save(device)
                                                    .flatMap(device1 -> Mono.just(ResponseEntity.ok(CommonResponse.success())))
                                                    .switchIfEmpty(Mono.just(ResponseEntity.ok(CommonResponse.fail())));
                                        })
                                        .switchIfEmpty(Mono.just(ResponseEntity.ok(CommonResponse.builder()
                                                .status("E1015")
                                                .statusDescription("Device not found")
                                                .build())));
                            }
                            return Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(CommonResponse.builder()
                                    .status("E1200")
                                    .statusDescription("You are not authorized to use this service").build()));
                        })
                )
                .switchIfEmpty(Mono.just(ResponseEntity.ok(CommonResponse.builder()
                        .status("E1015")
                        .statusDescription("User not found")
                        .build())));
    }

    public Mono<ResponseEntity<CommonResponse>> validateDeviceByMac(DeviceValidateRequestByMac dvr, String jwt) {
        log.info("Validate device by mac request received [{}]", dvr.getMac());

        return deviceRepository.findByMacAddress(dvr.getMac())
                .flatMap(device -> userRepository.findByUsername(jwtUtils.getUsername(jwt))
                        .flatMap(user -> {
                            if (user.getCreatedBy().equals(device.getCreatedBy())) {
                                if (device.getStatus().equals("ACTIVE")) {
                                    return Mono.just(ResponseEntity.ok(CommonResponse.success()));
                                }
                                return Mono.just(ResponseEntity.ok(CommonResponse.builder()
                                        .status("E1014")
                                        .statusDescription("Device not active state")
                                        .build()));
                            }
                            return Mono.just(ResponseEntity.ok(CommonResponse.builder()
                                    .status("E1015")
                                    .statusDescription("Device validation failed")
                                    .build()));
                        }))
                .switchIfEmpty(Mono.just(ResponseEntity.ok(CommonResponse.builder()
                        .status("E1016")
                        .statusDescription("Device not active state or Invalid")
                        .build())));
    }

    public Mono<ResponseEntity<DeviceListResponse>> getDevices(String page, String status, String name, String auth) {
        return deviceRepository.findDevicesByNameStatusPageUserName(name, status, String.valueOf(Integer.parseInt(page) * 20), jwtUtils.getUsername(auth))
                .collectList()
                .flatMap(devices -> Mono.just(ResponseEntity.ok(DeviceListResponse.builder()
                        .status("S1000")
                        .statusDescription("Success")
                        .devices(devices.stream().map(deviceMapper::deviceToDeviceDto).toList())
                        .build())));
    }
}
