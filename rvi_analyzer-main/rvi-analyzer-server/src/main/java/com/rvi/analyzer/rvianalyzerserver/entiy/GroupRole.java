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
public class GroupRole {
    @Field(name = "group-id")
    private String groupId;
    @Field(name = "role-ids")
    private List<String> roleIds;
}
