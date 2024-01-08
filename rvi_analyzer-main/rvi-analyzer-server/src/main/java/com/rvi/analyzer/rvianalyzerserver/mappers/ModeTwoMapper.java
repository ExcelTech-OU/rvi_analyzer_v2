package com.rvi.analyzer.rvianalyzerserver.mappers;

import com.rvi.analyzer.rvianalyzerserver.dto.ModeTwoDto;
import com.rvi.analyzer.rvianalyzerserver.entiy.ModeTwo;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface ModeTwoMapper {
    ModeTwo modeTwoDtoToModeTwo(ModeTwoDto modeTwoDto);

    ModeTwoDto modeTwoToModeTwoDto(ModeTwo modeTwo);
}
