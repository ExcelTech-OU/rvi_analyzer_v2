package com.rvi.analyzer.rvianalyzerserver.mappers;

import com.rvi.analyzer.rvianalyzerserver.dto.DefaultConfigurationDto;
import com.rvi.analyzer.rvianalyzerserver.dto.SessionResultDto;
import com.rvi.analyzer.rvianalyzerserver.entiy.DefaultConfiguration;
import com.rvi.analyzer.rvianalyzerserver.entiy.SessionResult;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface DefaultConfigurationMapper {
    DefaultConfiguration defaultConfigurationDtoToDefaultConfiguration(DefaultConfigurationDto defaultConfigurationDto);
    DefaultConfigurationDto defaultConfigurationToDefaultConfigurationDto(DefaultConfiguration defaultConfiguration);
}
