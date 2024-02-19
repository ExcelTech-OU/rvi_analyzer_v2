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
public class SONumber {
    private String _id;
    private String soNumber;
    private String customerPO;

    // @Field(name = "created-by")
    private String createdBy;
    // @Field(name = "created-date")
    @CreatedDate
    private LocalDateTime createdDateTime;

}
