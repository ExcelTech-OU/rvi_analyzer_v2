package com.rvi.analyzer.rvianalyzerserver.entiy;

import lombok.Builder;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.time.LocalDateTime;

@Document
@Builder
public class ModeOne {
    @Field(name = "created-by")
    private String createdBy;
    @Field(name = "default-configurations")
    private DefaultConfiguration defaultConfigurations;
    @Field(name = "created-date")
    @CreatedDate
    private LocalDateTime createdDateTime;
    @Field(name = "last-updated-date")
    @LastModifiedDate
    private LocalDateTime lastUpdatedDateTime;
}
