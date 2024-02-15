package com.rvi.analyzer.rvianalyzerserver.entiy;

import lombok.*;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.Id;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

import java.time.LocalDateTime;

@Data
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "Customer")
public class Customer {
    @Id
    private Long _id;
    @Column
    private String name;
    @Column
    private String createdBy;
    @Column
    private String status;
    //    private String plant;
    @Column
    @CreatedDate
    private LocalDateTime createdDateTime;
    @Column
    @LastModifiedDate
    private LocalDateTime lastUpdatedDateTime;
}
