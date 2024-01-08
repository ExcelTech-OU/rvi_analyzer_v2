package com.rvi.analyzer.rvianalyzerserver.mappers;

import com.rvi.analyzer.rvianalyzerserver.dto.ModeFourDto;
import com.rvi.analyzer.rvianalyzerserver.entiy.ModeFour;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface ModeFourMapper {
    ModeFour modeFourDtoToModeFour(ModeFourDto modeFourDto);

    ModeFourDto modeFourToModeFourDto(ModeFour modeFour);
}
