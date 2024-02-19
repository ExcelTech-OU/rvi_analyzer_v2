package com.rvi.analyzer.rvianalyzerserver.mappers;

import com.rvi.analyzer.rvianalyzerserver.dto.PlantDto;
import com.rvi.analyzer.rvianalyzerserver.entiy.Plant;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface PlantMapper {
    @Mapping(target = "createdDateTime", ignore = true)
    @Mapping(target = "lastUpdatedDateTime", ignore = true)
    @Mapping(target = "createdBy", ignore = true)
    Plant plantDtoToPlant(PlantDto plantDto);

    PlantDto plantToPlantDto(Plant plant);
}