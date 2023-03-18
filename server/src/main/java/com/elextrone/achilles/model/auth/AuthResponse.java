package com.elextrone.achilles.model.auth;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AuthResponse {
    private String state;
    private String stateDescription;
    private  SimpleUser simpleUser;
    private String jwt;
}
