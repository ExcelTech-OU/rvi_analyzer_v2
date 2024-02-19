package com.rvi.analyzer.rvianalyzerserver.mappers;

import com.rvi.analyzer.rvianalyzerserver.dto.SessionConfigurationModeFiveDto;
import com.rvi.analyzer.rvianalyzerserver.entiy.SessionConfigurationModeFive;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface SessionConfigurationModeFiveMapper {
    SessionConfigurationModeFive sessionConfigurationModeFiveDtoToSessionConfigurationModeFive(SessionConfigurationModeFiveDto sessionConfigurationModeFiveDto);

    SessionConfigurationModeFiveDto sessionConfigurationModeFiveToSessionConfigurationModeFiveDto(SessionConfigurationModeFive sessionConfigurationModeFive);
}
