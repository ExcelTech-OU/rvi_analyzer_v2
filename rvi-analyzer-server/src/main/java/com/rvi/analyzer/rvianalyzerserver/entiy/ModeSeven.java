package com.rvi.analyzer.rvianalyzerserver.entiy;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.time.LocalDateTime;

@Document
@Builder
@Getter
@Setter
public class ModeSeven {

    private String _id;
    @Field(name = "mac-address")
    private String macAddress;
    private String voltage;
    private String current;
    private String resistance;
    private String result;
    private String customer;
    private String soNumber;
    private String test;
    @Field(name = "created-date")
    @CreatedDate
    private LocalDateTime createdDateTime;
}
