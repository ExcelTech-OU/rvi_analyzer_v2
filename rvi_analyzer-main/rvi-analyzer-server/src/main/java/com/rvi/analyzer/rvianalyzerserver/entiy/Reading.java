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
public class Reading {
    private String temperature;
    private String current;
    private String voltage;
    @Field(name = "read-at")
    private LocalDateTime readAt;
    private String result;
}
