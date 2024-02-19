package com.rvi.analyzer.rvianalyzerserver.mappers;

import com.rvi.analyzer.rvianalyzerserver.dto.SessionConfigurationModeTwoDto;
import com.rvi.analyzer.rvianalyzerserver.entiy.SessionConfigurationModeTwo;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface SessionConfigurationModeTwoMapper {
    SessionConfigurationModeTwo sessionConfigurationModeTwoDtoToSessionConfigurationModeTwo(SessionConfigurationModeTwoDto sessionConfigurationModeTwoDto);

    SessionConfigurationModeTwoDto sessionConfigurationModeTwoToSessionConfigurationModeTwoDto(SessionConfigurationModeTwo sessionConfigurationModeTwo);
}
