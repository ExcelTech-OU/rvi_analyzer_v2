package com.rvi.analyzer.rvianalyzerserver.mappers;

import com.rvi.analyzer.rvianalyzerserver.dto.ModeSixDto;
import com.rvi.analyzer.rvianalyzerserver.entiy.ModeSix;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface ModeSixMapper {
    ModeSix modeSixDtoToModeSix(ModeSixDto modeSixDto);

    ModeSixDto modeSixToModeSixDto(ModeSix modeSix);
}
