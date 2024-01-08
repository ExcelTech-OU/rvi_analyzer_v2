package com.rvi.analyzer.rvianalyzerserver.entiy;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.util.List;

@Document
@Builder
@Getter
@Setter
public class SessionResult {
    @Field(name = "test-id")
    private String testId;
    private List<Reading> readings;
}
