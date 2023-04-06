package com.rvi.analyzer.rvianalyzerserver.mappers;

import com.rvi.analyzer.rvianalyzerserver.dto.ModeThreeDto;
import com.rvi.analyzer.rvianalyzerserver.entiy.ModeThree;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface ModeThreeMapper {
    ModeThree ModeThreeDtoToModeThree(ModeThreeDto ModeThreeDto);

    ModeThreeDto ModeThreeToModeThreeDto(ModeThree ModeThree);
}
