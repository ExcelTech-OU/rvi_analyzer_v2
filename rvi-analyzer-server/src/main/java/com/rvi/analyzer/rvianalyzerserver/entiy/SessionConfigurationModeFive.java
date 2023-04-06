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
public class SessionConfigurationModeFive {
    @Field(name = "fixed-voltage")
    private String fixedVoltage;
    @Field(name = "max-current")
    private String maxCurrent;
    @Field(name = "time-duration")
    private String timeDuration;
}
