package com.rvi.analyzer.rvianalyzerserver.mappers;

import com.rvi.analyzer.rvianalyzerserver.dto.UserDto;
import com.rvi.analyzer.rvianalyzerserver.entiy.User;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import java.time.LocalDateTime;

import static org.junit.jupiter.api.Assertions.*;

@ExtendWith(SpringExtension.class)
@ContextConfiguration(classes = {
        UserMapperImpl.class
})
class UserMapperTest {

    @Autowired
    private UserMapper userMapper;

    @Test
    @DisplayName("User to UserDto")
    void userToUserDto() {
        User user = User.builder()
                .userName("testUser")
                .password("password")
                .type("ADMIN")
                .status("ACTIVE")
                .createdBy("Top admin 01")
                .createdDateTime(LocalDateTime.now())
                .lastUpdatedDateTime(LocalDateTime.now())
                .build();
        UserDto userDto = userMapper.userToUserDto(user);

        assertEquals(user.getUserName(), userDto.getUserName());
        assertEquals(user.getType(), userDto.getType());
    }

    @Test
    @DisplayName("UserDto to User")
    void userDtoToUser() {
        UserDto userDto = UserDto.builder()
                .userName("testUserName")
                .createdBy("helloUser")
                .build();

        User user = userMapper.userDtoToUser(userDto);

        assertNull(user.getType());
        assertEquals(userDto.getUserName(), user.getUserName());
    }
}