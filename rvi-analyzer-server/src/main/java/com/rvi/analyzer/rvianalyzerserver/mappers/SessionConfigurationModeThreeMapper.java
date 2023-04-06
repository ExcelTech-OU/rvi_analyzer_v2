package com.rvi.analyzer.rvianalyzerserver.mappers;

import com.rvi.analyzer.rvianalyzerserver.dto.SessionConfigurationModeThreeDto;
import com.rvi.analyzer.rvianalyzerserver.entiy.SessionConfigurationModeThree;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface SessionConfigurationModeThreeMapper {
    SessionConfigurationModeThree sessionConfigurationModeThreeDtoToSessionConfigurationModeThree(SessionConfigurationModeThreeDto sessionConfigurationModeThreeDto);

    SessionConfigurationModeThreeDto sessionConfigurationModeThreeToSessionConfigurationModeThreeDto(SessionConfigurationModeThree sessionConfigurationModeThree);
}
