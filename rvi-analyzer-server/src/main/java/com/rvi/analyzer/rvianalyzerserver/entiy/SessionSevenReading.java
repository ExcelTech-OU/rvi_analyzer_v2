package com.rvi.analyzer.rvianalyzerserver.entiy;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.time.LocalDateTime;

@Document
@Builder
@Getter
@Setter
public class SessionSevenReading {

    @Field(name = "mac-address")
    private String macAddress;
    private String current;
    private String voltage;
    private String resistance;
    private String result;
    @Field(name = "read-at")
    private LocalDateTime readAt;
}
