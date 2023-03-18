package com.elextrone.achilles.model.auth;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@AllArgsConstructor
@Data
public class SimpleUser {
    String username;
    String name;
    String email;
    String age = "N/A";
    String gender = "Male";
    String occupation = "N/A";
    String lastLogin;
}
