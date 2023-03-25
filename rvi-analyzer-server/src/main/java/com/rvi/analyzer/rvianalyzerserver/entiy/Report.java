package com.rvi.analyzer.rvianalyzerserver.entiy;

import lombok.Builder;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.time.LocalDateTime;

@Document
@Builder
public class Report {
    @Field(name = "created-by")
    private String createdBy;
    private String password;
    @Field(name = "session-id")
    private String sessionId;
    @Field(name = "test-id")
    private String testId;
    @Field(name = "url-hash")
    private String urlHash;
    private String status;
    @Field(name = "created-date")
    @CreatedDate
    private LocalDateTime createdDateTime;
}
