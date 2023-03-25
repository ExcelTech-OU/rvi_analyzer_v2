package com.rvi.analyzer.rvianalyzerserver.entiy;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

@Document
@Builder
@Getter
@Setter
public class SessionConfigurationModeOne {
    private String voltage;
    @Field(name = "max-current")
    private String maxCurrent;
    @Field(name = "batch-no")
    private String batchNo;
    @Field(name = "session-id")
    private String sessionId;
}
