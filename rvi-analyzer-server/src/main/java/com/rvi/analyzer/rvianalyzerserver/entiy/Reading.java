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
@Table(name = "Reading")
public class Reading {
    @Id
    private Long _id;
    @Column
    private String temperature;
    @Column
    private String readingCurrent;
    @Column
    private String voltage;
    @Column
    private LocalDateTime readAt;
    @Column
    private String result;
}
