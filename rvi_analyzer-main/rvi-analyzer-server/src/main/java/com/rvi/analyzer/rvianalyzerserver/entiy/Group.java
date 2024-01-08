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
public class Group {
    @Field(name = "group-id")
    private String groupId;
    @Field(name = "group-name")
    private String groupName;
}
