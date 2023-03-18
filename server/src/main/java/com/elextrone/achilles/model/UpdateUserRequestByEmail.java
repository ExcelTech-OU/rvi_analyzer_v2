package com.elextrone.achilles.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UpdateUserRequestByEmail {
    private String email;
    private String condition;
    private String occupation;
    private String age;
    private String status;
}
