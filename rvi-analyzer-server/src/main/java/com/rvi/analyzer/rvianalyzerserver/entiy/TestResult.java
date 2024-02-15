package com.rvi.analyzer.rvianalyzerserver.entiy;

import lombok.*;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

import java.time.LocalDateTime;

@Data
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "TestResult")
public class TestResult {
    @Id
    private Long _id;
    @Column
    private String testGate;
    @Column
    private String productionOrder;
    @Column
    private String productId;
    @Column
    private String mode01;
    @Column
    private String mode02;
    @Column
    private String mode03;
    @Column
    private String mode04;
    @Column
    private String createdBy;
    @Column
    @CreatedDate
    private LocalDateTime createdDateTime;
}
