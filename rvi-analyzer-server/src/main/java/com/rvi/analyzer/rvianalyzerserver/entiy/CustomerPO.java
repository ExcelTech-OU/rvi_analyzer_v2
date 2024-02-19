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
public class CustomerPO {
    private String _id;
    private String name;
    private String rawMaterial;

    // @Field(name = "created-by")
    private String createdBy;
    // @Field(name = "created-date")
    @CreatedDate
    private LocalDateTime createdDateTime;

}
