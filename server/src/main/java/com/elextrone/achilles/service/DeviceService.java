package com.elextrone.achilles.service;

import com.elextrone.achilles.model.*;
import com.elextrone.achilles.model.auth.ValidateResponse;
import com.elextrone.achilles.repo.entity.Device;
import com.elextrone.achilles.repo.utill.DeviceStatus;
import org.springframework.http.ResponseEntity;
import reactor.core.publisher.Mono;

import java.util.List;

public interface DeviceService {
    List<Device> getActiveDevicesByUserId(Long userId, DeviceStatus deviceStatus);

    Mono<ResponseEntity<ValidateResponse>> validateDeviceByMac(DeviceValidateRequestByMac dvr);

    Mono<ResponseEntity<ValidateResponse>> validateDeviceByName(String deviceName);

    Mono<ResponseEntity<ValidateResponse>> removeDeviceById(String username, String id);

    Mono<ResponseEntity<DeviceListResponse>> getDevices(String pageNo, String status);

    Mono<ResponseEntity<DeviceResponse>> getDeviceByName(String name);

    Mono<ResponseEntity<ValidateResponse>> updateDevice(UpdateDeviceRequestByName req);

    Mono<ResponseEntity<ValidateResponse>> addNewDevice(AddNewDeviceRequest dvr);

    Mono<ResponseEntity<DashBoardSummaryResponse>> getSummaryData();

}
