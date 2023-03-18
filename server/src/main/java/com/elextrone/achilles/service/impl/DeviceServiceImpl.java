package com.elextrone.achilles.service.impl;

import com.elextrone.achilles.model.*;
import com.elextrone.achilles.model.auth.ValidateResponse;
import com.elextrone.achilles.repo.*;
import com.elextrone.achilles.repo.entity.Device;
import com.elextrone.achilles.repo.entity.User;
import com.elextrone.achilles.repo.utill.DeviceStatus;
import com.elextrone.achilles.service.DeviceService;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.http.ResponseEntity;
import reactor.core.publisher.Mono;

import java.util.List;


@Service
@AllArgsConstructor
public class DeviceServiceImpl implements DeviceService {

    @Autowired
    private DeviceRepository deviceRepository;

    @Autowired
    private UserDeviceRepository userDeviceRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private QuestionRepository questionRepository;

    @Autowired
    private UserTreatmentSessionRepository userTreatmentSessionRepository;

    @Override
    public List<Device> getActiveDevicesByUserId(Long userId, DeviceStatus deviceStatus) {
        return deviceRepository.findActiveDevicesByUsername(userId, true, deviceStatus.name());
    }

    @Override
    public Mono<ResponseEntity<ValidateResponse>> validateDeviceByMac(DeviceValidateRequestByMac dvr) {
        Device device = deviceRepository.findActiveDeviceByMac(dvr.getMac(), DeviceStatus.ACTIVE.name());
        if (device != null) {
            return Mono.just(ResponseEntity.ok(new ValidateResponse("S1000", "Success")));
        }
        return Mono.just(ResponseEntity.ok(new ValidateResponse("E1003", "Device not active state or Invalid")));
    }

    @Override
    public Mono<ResponseEntity<ValidateResponse>> validateDeviceByName(String deviceName) {
        Device device = deviceRepository.findActiveDeviceByName(deviceName, DeviceStatus.ACTIVE.name()
        );
        if (device != null) {
            return Mono.just(ResponseEntity.ok(new ValidateResponse("S1000", "Success")));
        }
        return Mono.just(ResponseEntity.ok(new ValidateResponse("E1003", "Device not active state or Invalid")));
    }

    @Override
    public Mono<ResponseEntity<ValidateResponse>> removeDeviceById(String username, String id) {
        User user = userRepository.findByUsername(username);
        if (user != null) {
            userDeviceRepository.removeUserDevice(user.getId(), Long.parseLong(id), false);
            return Mono.just(ResponseEntity.ok(new ValidateResponse("S1000", "Success")));
        }
        return Mono.just(ResponseEntity.ok(new ValidateResponse("E1003", "User not found")));
    }

    @Override
    public Mono<ResponseEntity<DeviceListResponse>> getDevices(String pageNo, String status) {
        List<Device> devices = deviceRepository.findDevices(Integer.parseInt(pageNo), DeviceStatus.ACTIVE.name());
        return Mono.just(ResponseEntity.ok(new DeviceListResponse(devices)));
    }

    @Override
    public Mono<ResponseEntity<DeviceResponse>> getDeviceByName(String name) {
        Device device = deviceRepository.findDeviceByName(name);
        return Mono.just(ResponseEntity.ok(new DeviceResponse(device)));
    }

    @Override
    public Mono<ResponseEntity<ValidateResponse>> updateDevice(UpdateDeviceRequestByName req) {
        deviceRepository.updateDevice(DeviceStatus.valueOf(req.getStatus()).name(), req.getName(), req.getFirmwareVersion(), req.getBatchNo());
        return Mono.just(ResponseEntity.ok(new ValidateResponse("S1000", "Success")));
    }

    @Override
    public Mono<ResponseEntity<ValidateResponse>> addNewDevice(AddNewDeviceRequest dvr) {
        Device device = new Device();
        device.setName(dvr.getName());
        device.setBatchNo(dvr.getBatchNo());
        device.setMacAddress(dvr.getMacAddress());
        device.setFirmwareVersion(dvr.getFirmwareVersion());
        device.setStatus(DeviceStatus.ACTIVE.name());
        device.setConnectedNetworkId("null");
        deviceRepository.save(device);
        return Mono.just(ResponseEntity.ok(new ValidateResponse("S1000", "Success")));
    }

    @Override
    public Mono<ResponseEntity<DashBoardSummaryResponse>> getSummaryData() {
        int deviceCount = deviceRepository.getTotalDevices(DeviceStatus.ACTIVE.name());
        int userCount = userRepository.getTotalUsers(true);
        long sessionsCount = userTreatmentSessionRepository.count();
        long questionCount = questionRepository.count();
        return Mono.just(ResponseEntity.ok(new DashBoardSummaryResponse(deviceCount, userCount, sessionsCount, questionCount)));
    }

}
