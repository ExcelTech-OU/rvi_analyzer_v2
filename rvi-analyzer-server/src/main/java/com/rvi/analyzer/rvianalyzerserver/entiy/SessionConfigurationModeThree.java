package com.rvi.analyzer.rvianalyzerserver.entiy;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
 // import org.springframework.data.mongodb.core.mapping.Document;
 // import org.springframework.data.mongodb.core.mapping.Field;

 // @Document
@Builder
@Getter
@Setter
public class SessionConfigurationModeThree {
    // @Field(name = "starting-voltage")
    private String startingVoltage;
    // @Field(name = "desired-voltage")
    private String desiredVoltage;
    // @Field(name = "max-current")
    private String maxCurrent;
    // @Field(name = "voltage-resolution")
    private String voltageResolution;
    // @Field(name = "change-in-time")
    private String chargeInTime;
}
