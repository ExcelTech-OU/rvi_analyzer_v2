package com.rvi.analyzer.rvianalyzerserver.domain;

import com.rvi.analyzer.rvianalyzerserver.dto.UserDto;
import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class UsersResponse {
    private String status;
    private String statusDescription;
    private List<UserDto> users;

    public static UsersResponse success(){
        return UsersResponse.builder()
                .status("S1000")
                .statusDescription("Request was success")
                .build();
    }

    public static UsersResponse fail(){
        return UsersResponse.builder()
                .status("E1000")
                .statusDescription("Request was failed")
                .build();
    }

}
