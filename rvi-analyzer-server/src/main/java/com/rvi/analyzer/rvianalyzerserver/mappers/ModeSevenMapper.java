package com.rvi.analyzer.rvianalyzerserver.mappers;

import com.rvi.analyzer.rvianalyzerserver.dto.ModeSevenDto;
import com.rvi.analyzer.rvianalyzerserver.entiy.ModeSeven;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface ModeSevenMapper {
    ModeSeven modeSevenDtoToModeSeven(ModeSevenDto modeSevenDto);

    ModeSevenDto modeSevenToModeSevenDto(ModeSeven modeSeven);
}
