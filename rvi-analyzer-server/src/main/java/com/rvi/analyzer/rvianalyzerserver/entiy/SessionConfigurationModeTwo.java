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
public class SessionConfigurationModeTwo {
    private String current;
    // @Field(name = "max-voltage")
    private String maxVoltage;
    // @Field(name = "pass-min-voltage")
    private String passMinVoltage;
    // @Field(name = "pass-max-voltage")
    private String passMaxVoltage;
}
