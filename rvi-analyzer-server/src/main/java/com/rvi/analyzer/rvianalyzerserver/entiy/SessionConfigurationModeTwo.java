package com.rvi.analyzer.rvianalyzerserver.entiy;

import lombok.*;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

@Data
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "SessionConfigurationModeTwo")
public class SessionConfigurationModeTwo {
    @Id
    private Long _id;
    @Column
    private String readingCurrent;
    @Column
    private String maxVoltage;
    @Column
    private String passMinVoltage;
    @Column
    private String passMaxVoltage;
}
