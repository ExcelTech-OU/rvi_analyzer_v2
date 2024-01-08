package com.rvi.analyzer.rvianalyzerserver.mappers;

import com.rvi.analyzer.rvianalyzerserver.dto.SessionConfigurationModeSixDto;
import com.rvi.analyzer.rvianalyzerserver.entiy.SessionConfigurationModeSix;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface SessionConfigurationModeSixMapper {
    SessionConfigurationModeSix sessionConfigurationModeSixDtoToSessionConfigurationModeSix(SessionConfigurationModeSixDto sessionConfigurationModeSixDto);

    SessionConfigurationModeSixDto sessionConfigurationModeSixToSessionConfigurationModeSixDto(SessionConfigurationModeSix sessionConfigurationModeSix);
}
