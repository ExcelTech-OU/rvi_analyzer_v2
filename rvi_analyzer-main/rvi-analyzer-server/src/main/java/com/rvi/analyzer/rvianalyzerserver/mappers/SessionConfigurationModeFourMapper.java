package com.rvi.analyzer.rvianalyzerserver.mappers;

import com.rvi.analyzer.rvianalyzerserver.dto.SessionConfigurationModeFourDto;
import com.rvi.analyzer.rvianalyzerserver.entiy.SessionConfigurationModeFour;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface SessionConfigurationModeFourMapper {
    SessionConfigurationModeFour sessionConfigurationModeFourDtoToSessionConfigurationModeFour(SessionConfigurationModeFourDto sessionConfigurationModeFourDto);

    SessionConfigurationModeFourDto sessionConfigurationModeFourToSessionConfigurationModeFourDto(SessionConfigurationModeFour sessionConfigurationModeFour);
}
