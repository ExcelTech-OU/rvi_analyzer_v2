package com.rvi.analyzer.rvianalyzerserver.entiy;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.time.LocalDateTime;
import java.util.List;

@Document
@Builder
@Getter
@Setter
public class ModeSeven {

    private String _id;
    private String createdBy;
    private DefaultConfiguration defaultConfigurations;
    private SessionResultModeSeven result;
    private String status;
    private LocalDateTime lastUpdatedDateTime;
    @Field(name = "created-date")
    @CreatedDate
    private LocalDateTime createdDateTime;
}
