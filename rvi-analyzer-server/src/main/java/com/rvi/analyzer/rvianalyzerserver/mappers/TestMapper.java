package com.rvi.analyzer.rvianalyzerserver.mappers;

import com.rvi.analyzer.rvianalyzerserver.dto.MaterialDto;
import com.rvi.analyzer.rvianalyzerserver.dto.TestDto;
import com.rvi.analyzer.rvianalyzerserver.dto.UserDto;
import com.rvi.analyzer.rvianalyzerserver.entiy.Material;
import com.rvi.analyzer.rvianalyzerserver.entiy.Test;
import com.rvi.analyzer.rvianalyzerserver.entiy.User;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface TestMapper {
    Test testDtoToTest(TestDto testDto);

    TestDto testToTestDto(Test test);
}
