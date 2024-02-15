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
@Table(name = "Device")
public class Device {
    @Id
    private Long _id;
    @Column
    private String name;
    @Column
    private String createdBy;
    @Column
    private String assignTo;
    @Column
    private String macAddress;
    @Column
    private String status;
    @Column
    @CreatedDate
    private LocalDateTime createdDateTime;
}
