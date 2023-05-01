package com.rvi.analyzer.rvianalyzerserver.controller;


import com.rvi.analyzer.rvianalyzerserver.domain.CommonResponse;
import com.rvi.analyzer.rvianalyzerserver.domain.DeviceValidateRequestByMac;
import com.rvi.analyzer.rvianalyzerserver.domain.UpdateDeviceRequestByName;
import com.rvi.analyzer.rvianalyzerserver.dto.DeviceDto;
import com.rvi.analyzer.rvianalyzerserver.service.DeviceService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Mono;

@RestController
@RequiredArgsConstructor
public class DeviceController {

    final private DeviceService deviceService;

    @PostMapping(path = "/rvi/analyzer/v1/device/add")
    public Mono<CommonResponse> addDevice(@RequestBody DeviceDto deviceDto){
        return deviceService.addDevice(deviceDto);
    }

    @PostMapping("/rvi/analyzer/v1/device/validate/mac")
    public Mono<ResponseEntity<CommonResponse>> validateDevice(@RequestBody DeviceValidateRequestByMac dvr, @RequestHeader("Authorization") String auth) {
        return deviceService.validateDeviceByMac(dvr, auth);
    }

    @PostMapping("/device/update")
    public Mono<ResponseEntity<CommonResponse>> updateDevice(@RequestBody UpdateDeviceRequestByName dvr, @RequestHeader("Authorization") String auth) {
        return deviceService.updateDevice(dvr, auth);
    }
}
