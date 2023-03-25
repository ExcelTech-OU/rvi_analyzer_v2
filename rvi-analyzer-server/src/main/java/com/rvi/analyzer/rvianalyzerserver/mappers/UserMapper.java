package com.rvi.analyzer.rvianalyzerserver.mappers;

import com.rvi.analyzer.rvianalyzerserver.dto.UserDto;
import com.rvi.analyzer.rvianalyzerserver.entiy.User;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface UserMapper {
    @Mapping(target = "createdDateTime", ignore = true)
    @Mapping(target = "lastUpdatedDateTime", ignore = true)
    User userToUserDto(UserDto userDto);
    UserDto userDtoToUser(User user);
}
