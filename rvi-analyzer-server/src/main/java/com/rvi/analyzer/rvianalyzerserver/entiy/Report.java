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
@Table(name = "Report")
public class Report {
    @Id
    private Long _id;
    @Column
    private String createdBy;
    @Column
    private String password;
    @Column
    private String sessionId;
    @Column
    private int modeType;
    @Column
    private String testId;
    @Column
    private String urlHash;
    @Column
    private String status;
    @Column
    private int accessAttempts;
    @Column
    @CreatedDate
    private LocalDateTime createdDateTime;
}
