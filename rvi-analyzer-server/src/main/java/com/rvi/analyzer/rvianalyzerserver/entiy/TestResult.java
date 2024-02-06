package com.rvi.analyzer.rvianalyzerserver.entiy;

import com.rvi.analyzer.rvianalyzerserver.dto.ParameterModeDto;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.time.LocalDateTime;
import java.util.List;

@Document
@Builder
@Getter
@Setter
public class TestResult {

    private String _id;
    private String testGate;
    private String productionOrder;
    private String productId;
    private String mode01;
    private String mode02;
    private String mode03;
    private String mode04;

    @Field(name = "created-by")
    private String createdBy;
    @Field(name = "created-date")
    @CreatedDate
    private LocalDateTime createdDateTime;
}
