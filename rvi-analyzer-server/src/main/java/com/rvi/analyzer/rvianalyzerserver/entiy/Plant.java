package com.rvi.analyzer.rvianalyzerserver.entiy;

import lombok.*;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

import java.time.LocalDateTime;

@Data
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "Plant")
public class Plant {
    @Id
    private Long _id;
    @Column
    private String name;
    @Column
    private String createdBy;
    //    private String status;
    //    private Customer customer;
    @Column
    private LocalDateTime createdDateTime;
    @Column
    private LocalDateTime lastUpdatedDateTime;
}
