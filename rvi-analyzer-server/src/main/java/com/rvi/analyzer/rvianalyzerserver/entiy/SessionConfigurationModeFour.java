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
public class SessionConfigurationModeFour {
    @Field(name = "starting-current")
    private String startingCurrent;
    @Field(name = "desired-current")
    private String desiredCurrent;
    @Field(name = "max-voltage")
    private String maxVoltage;
    @Field(name = "current-resolution")
    private String currentResolution;
    @Field(name = "change-in-time")
    private String chargeInTime;
}
