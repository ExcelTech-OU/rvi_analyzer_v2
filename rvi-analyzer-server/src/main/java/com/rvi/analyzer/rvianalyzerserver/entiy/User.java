package com.rvi.analyzer.rvianalyzerserver.entiy;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.time.LocalDateTime;

@Document
@Builder
@Getter
@Setter
public class User {

    private String _id;
    private String username;
    private String password;
//    private String supervisor;

    @Field(name = "password-type")
    private String passwordType;
    private String group;
    private String status;
    @Field(name = "created-by")
    private String createdBy;
    @Field(name = "created-date")
    @CreatedDate
    private LocalDateTime createdDateTime;
    @Field(name = "last-updated-date")
    @LastModifiedDate
    private LocalDateTime lastUpdatedDateTime;


}
