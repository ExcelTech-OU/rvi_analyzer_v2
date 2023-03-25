package com.rvi.analyzer.rvianalyzerserver.entiy;

import lombok.Builder;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

@Document
@Builder
public class DefaultConfiguration {
    @Field(name = "customer-name")
    private String customerName;
    @Field(name = "operator-id")
    private String operatorId;
    @Field(name = "batch-no")
    private String batchNo;
    @Field(name = "session-id")
    private String sessionId;
}
