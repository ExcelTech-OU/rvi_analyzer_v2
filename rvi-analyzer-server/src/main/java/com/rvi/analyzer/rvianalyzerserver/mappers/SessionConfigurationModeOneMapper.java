package com.rvi.analyzer.rvianalyzerserver.mappers;

import com.rvi.analyzer.rvianalyzerserver.dto.DefaultConfigurationDto;
import com.rvi.analyzer.rvianalyzerserver.dto.SessionConfigurationModeOneDto;
import com.rvi.analyzer.rvianalyzerserver.entiy.DefaultConfiguration;
import com.rvi.analyzer.rvianalyzerserver.entiy.SessionConfigurationModeOne;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface SessionConfigurationModeOneMapper {
    SessionConfigurationModeOne sessionConfigurationModeOneDtoToSessionConfigurationModeOne(SessionConfigurationModeOneDto sessionConfigurationModeOneDto);
    SessionConfigurationModeOneDto sessionConfigurationModeOneToSessionConfigurationModeOneDto(SessionConfigurationModeOne sessionConfigurationModeOne);
}
