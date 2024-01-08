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
public class SessionConfigurationModeSix {
    @Field(name = "fixed-current")
    private String fixedCurrent;
    @Field(name = "max-voltage")
    private String maxVoltage;
    @Field(name = "time-duration")
    private String timeDuration;
}
