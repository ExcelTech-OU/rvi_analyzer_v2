package com.rvi.analyzer.rvianalyzerserver.mappers;

import com.rvi.analyzer.rvianalyzerserver.dto.DeviceDto;
import com.rvi.analyzer.rvianalyzerserver.dto.ModeOneDto;
import com.rvi.analyzer.rvianalyzerserver.entiy.Device;
import com.rvi.analyzer.rvianalyzerserver.entiy.ModeOne;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface ModeOneMapper {
    ModeOne modeOneDtoToModeOne(ModeOneDto modeOneDto);

    ModeOneDto modeOneToModeOneDto(ModeOne modeOne);
}
