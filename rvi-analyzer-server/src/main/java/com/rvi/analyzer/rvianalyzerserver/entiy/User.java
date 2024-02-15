package com.rvi.analyzer.rvianalyzerserver.entiy;

import lombok.*;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDateTime;

@Data
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Table(name = "User")
public class User {
    @Id
    @Column("_id")
    private int _id;
    @Column("username")
    private String username;
    @Column("password")
    private String password;
    @Column("supervisor")
    private String supervisor;

    @Column("passwordType")
    private String passwordType;
    @Column("userGroup")
    private String userGroup;
    @Column("status")
    private String status;
    @Column("createdBy")
    private String createdBy;

    //    @CreatedDate
    @Column("createdDateTime")
    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
    private LocalDateTime createdDateTime;

    //    @LastModifiedDate
    @Column("lastUpdatedDateTime")
    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
    private LocalDateTime lastUpdatedDateTime;
}
