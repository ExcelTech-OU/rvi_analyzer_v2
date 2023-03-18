package com.elextrone.achilles.model;

import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
@Builder
public class UserObj {
    private Long id;
    private String name;
    private String username;

    private String email;
    private int age;
    private String occupation;
    private String condition;
    private int roleId;
    private Boolean enabled;
    private Date createdDate;
    private Date lastUpdatedDate;
}
