package com.rvi.analyzer.rvianalyzerserver.entiy;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

@Getter
@Setter
@Document
@ToString
public class Settings {
    private String _id;
    @Field(name = "setting-id")
    private String settingId;
    private String lowerBound;
    private String upperBound;
}
