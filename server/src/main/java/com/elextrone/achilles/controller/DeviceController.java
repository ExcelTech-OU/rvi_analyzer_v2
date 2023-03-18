package com.elextrone.achilles.controller;

import com.elextrone.achilles.auth.JWTUtil;
import com.elextrone.achilles.model.*;
import com.elextrone.achilles.model.auth.ValidateResponse;
import com.elextrone.achilles.service.DeviceService;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Mono;


@AllArgsConstructor
@RestController
public class DeviceController {

    @Autowired
    private DeviceService deviceService;

    private JWTUtil jwtUtil;

    @PostMapping("/device/validate/mac")
    @PreAuthorize("hasRole('USER')")
    public Mono<ResponseEntity<ValidateResponse>> validateDevice(@RequestBody DeviceValidateRequestByMac dvr) {
        return deviceService.validateDeviceByMac(dvr);
    }

    @PostMapping("/device/validate/name")
    @PreAuthorize("hasRole('USER')")
    public Mono<ResponseEntity<ValidateResponse>> validateDeviceByName(@RequestBody DeviceValidateRequestByName dvr) {
        return deviceService.validateDeviceByName(dvr.getName());
    }

    @GetMapping("/device/remove/{id}")
    @PreAuthorize("hasRole('USER')")
    public Mono<ResponseEntity<ValidateResponse>> removeDevice(@RequestHeader("Authorization") String auth, @PathVariable String id) {
        return deviceService.removeDeviceById(jwtUtil.getUsernameBuAuth(auth), id)
                .onErrorResume(e -> Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).build()));
    }

    @GetMapping("/device/{page}/{status}")
//    @PreAuthorize("hasRole('ADMIN')")
    public Mono<ResponseEntity<DeviceListResponse>> getDevices(@PathVariable String page, @PathVariable String status) {
        return deviceService.getDevices(page, status);
    }

    @GetMapping("/device/{name}")
//    @PreAuthorize("hasRole('ADMIN')")
    public Mono<ResponseEntity<DeviceResponse>> getDeviceByName(@PathVariable String name) {
        return deviceService.getDeviceByName(name);
    }

    @PostMapping("/device/update")
    public Mono<ResponseEntity<ValidateResponse>> updateDeviceStatus(@RequestBody UpdateDeviceRequestByName dvr) {
        return deviceService.updateDevice(dvr);
    }

    @PostMapping("/device/add")
    public Mono<ResponseEntity<ValidateResponse>> addNewDevice(@RequestBody AddNewDeviceRequest dvr) {
        return deviceService.addNewDevice(dvr);
    }

    @GetMapping("/device/dashboard")
    public Mono<ResponseEntity<DashBoardSummaryResponse>> getDashBoardData() {
        return deviceService.getSummaryData();
    }

}
