package com.rvi.analyzer.rvianalyzerserver.mappers;

import com.rvi.analyzer.rvianalyzerserver.dto.StyleDto;
import com.rvi.analyzer.rvianalyzerserver.dto.UserDto;
import com.rvi.analyzer.rvianalyzerserver.entiy.Style;
import com.rvi.analyzer.rvianalyzerserver.entiy.User;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface StyleMapper {
    @Mapping(target = "createdDateTime", ignore = true)
    @Mapping(target = "createdBy", ignore = true)
    Style styleDtoToStyle(StyleDto styleDto);

    StyleDto styleToStyleDto(Style style);
}
