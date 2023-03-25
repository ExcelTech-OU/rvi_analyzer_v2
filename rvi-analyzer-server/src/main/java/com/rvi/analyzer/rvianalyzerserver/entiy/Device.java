package com.rvi.analyzer.rvianalyzerserver.entiy;

import lombok.Builder;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.time.LocalDateTime;

@Document
@Builder
public class Device {
    @Field(name = "created-by")
    private String createdBy;
    @Field(name = "mac-address")
    private String macAddress;
    private String status;
    @Field(name = "created-date")
    @CreatedDate
    private LocalDateTime createdDateTime;
}
