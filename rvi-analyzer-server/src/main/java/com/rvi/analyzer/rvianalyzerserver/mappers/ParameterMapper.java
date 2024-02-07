package com.rvi.analyzer.rvianalyzerserver.mappers;

import com.rvi.analyzer.rvianalyzerserver.dto.ParameterDto;
import com.rvi.analyzer.rvianalyzerserver.dto.PlantDto;
import com.rvi.analyzer.rvianalyzerserver.entiy.Parameter;
import com.rvi.analyzer.rvianalyzerserver.entiy.Plant;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface ParameterMapper {
    @Mapping(target = "createdDateTime", ignore = true)
    @Mapping(target = "createdBy", ignore = true)
    Parameter parameterDtoToParameter(ParameterDto parameterDto);

    ParameterDto parameterToParameterDto(Parameter parameter);
}