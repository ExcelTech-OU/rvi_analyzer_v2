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
@Table(name = "ModeFive")
public class ModeFive {
    @Id
    private Long _id;
    @Column
    private String createdBy;
    @Column
    private DefaultConfiguration defaultConfigurations;
    @Column
    private SessionConfigurationModeFive sessionConfigurationModeFive;
    @Column
    private SessionResult results;
    @Column
    private String status;
    @Column
    @CreatedDate
    private LocalDateTime createdDateTime;
    @Column
    @LastModifiedDate
    private LocalDateTime lastUpdatedDateTime;
}
