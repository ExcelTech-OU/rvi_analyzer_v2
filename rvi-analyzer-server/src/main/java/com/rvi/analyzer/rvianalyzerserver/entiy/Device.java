package com.rvi.analyzer.rvianalyzerserver.entiy;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.annotation.CreatedDate;
 // import org.springframework.data.mongodb.core.mapping.Document;
 // import org.springframework.data.mongodb.core.mapping.Field;

import java.time.LocalDateTime;

 // @Document
@Builder
@Getter
@Setter
public class Device {
    private String _id;
    private String name;
    // @Field(name = "created-by")
    private String createdBy;
    // @Field(name = "assign-to")
    private String assignTo;
    // @Field(name = "mac-address")
    private String macAddress;
    private String status;
    // @Field(name = "created-date")
    @CreatedDate
    private LocalDateTime createdDateTime;
}
