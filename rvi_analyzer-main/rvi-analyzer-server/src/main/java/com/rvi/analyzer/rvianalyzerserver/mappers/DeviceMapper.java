package com.rvi.analyzer.rvianalyzerserver.mappers;

import com.rvi.analyzer.rvianalyzerserver.dto.DeviceDto;
import com.rvi.analyzer.rvianalyzerserver.entiy.Device;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface DeviceMapper {
    Device deviceDtoToDevice(DeviceDto deviceDto);
    DeviceDto deviceToDeviceDto(Device device);
}
