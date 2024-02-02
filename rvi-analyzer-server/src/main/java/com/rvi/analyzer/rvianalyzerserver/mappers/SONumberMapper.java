package com.rvi.analyzer.rvianalyzerserver.mappers;

import com.rvi.analyzer.rvianalyzerserver.dto.CustomerPODto;
import com.rvi.analyzer.rvianalyzerserver.dto.SONumberDto;
import com.rvi.analyzer.rvianalyzerserver.dto.StyleDto;
import com.rvi.analyzer.rvianalyzerserver.dto.UserDto;
import com.rvi.analyzer.rvianalyzerserver.entiy.*;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface SONumberMapper {
    @Mapping(target = "createdDateTime", ignore = true)
    @Mapping(target = "createdBy", ignore = true)
    SONumber soNumberDtoToSONumber(SONumberDto soNumberDto);

    SONumberDto soNumberToSONumberDto(SONumber soNumber);
}
