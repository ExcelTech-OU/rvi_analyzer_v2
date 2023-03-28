package com.rvi.analyzer.rvianalyzerserver.route;


import com.rvi.analyzer.rvianalyzerserver.domain.CommonResponse;
import com.rvi.analyzer.rvianalyzerserver.dto.DeviceDto;
import com.rvi.analyzer.rvianalyzerserver.dto.UserDto;
import com.rvi.analyzer.rvianalyzerserver.service.DeviceService;
import lombok.RequiredArgsConstructor;
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
}
