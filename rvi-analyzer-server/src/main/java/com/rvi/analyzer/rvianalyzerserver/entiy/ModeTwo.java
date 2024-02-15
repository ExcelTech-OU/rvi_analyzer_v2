package com.rvi.analyzer.rvianalyzerserver.entiy;

import lombok.*;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.Id;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

import java.time.LocalDateTime;
import java.util.List;

@Data
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "ModeTwo")
public class ModeTwo {
    @Id
    private Long _id;
    @Column
    private String createdBy;
    @Column
    private DefaultConfiguration defaultConfigurations;
    @Column
    private SessionConfigurationModeTwo sessionConfigurationModeTwo;
    @Column
    private List<SessionResult> results;
    @Column
    private String status;
    @Column
    @CreatedDate
    private LocalDateTime createdDateTime;
    @Column
    @LastModifiedDate
    private LocalDateTime lastUpdatedDateTime;
}
