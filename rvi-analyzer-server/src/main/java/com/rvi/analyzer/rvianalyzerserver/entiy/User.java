package com.rvi.analyzer.rvianalyzerserver.entiy;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Table(name = "user")
@Data
@Builder
@Entity
@NoArgsConstructor
@AllArgsConstructor
public class User {

    @Id
    @SequenceGenerator(
            name = "user_sequence",
            sequenceName = "user_sequence",
            allocationSize = 1
    )
    @GeneratedValue(
            strategy = GenerationType.SEQUENCE,
            generator = "user_sequence"
    )
    private String id;
    private String username;
    private String password;
    private String supervisor;
    @Column(name = "password-type")
    private String passwordType;

    @OneToOne
    @JoinColumn(
            name = "group_id",
            referencedColumnName = "group_id"
    )
    private Group userGroup;

    private String status;
    @Column(name = "created-by")
    private String createdBy;
    @Column(
            name = "created-date",
            columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP"
    )
    private LocalDateTime createdDateTime;
    @Column(
            name = "last-updated-date",
            columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"
    )
    private LocalDateTime lastUpdatedDateTime;
}
