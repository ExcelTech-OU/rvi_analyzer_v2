package com.rvi.analyzer.rvianalyzerserver.mappers;

import com.rvi.analyzer.rvianalyzerserver.dto.ModeFiveDto;
import com.rvi.analyzer.rvianalyzerserver.entiy.ModeFive;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface ModeFiveMapper {
    ModeFive modeFiveDtoToModeFive(ModeFiveDto modeFiveDto);

    ModeFiveDto modeFiveToModeFiveDto(ModeFive modeFive);
}
