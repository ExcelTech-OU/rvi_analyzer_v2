package com.rvi.analyzer.rvianalyzerserver.entiy;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.time.LocalDateTime;

@Builder
@Getter
@Setter
@Document
@ToString
public class Customer {
    private String _id;
    private String name;
    private String createdBy;
    private String status;
    //    private String plant;
    @Field(name = "created-date")
    private LocalDateTime createdDateTime;
    @Field(name = "last-updated-date")
    private LocalDateTime lastUpdatedDateTime;
}
