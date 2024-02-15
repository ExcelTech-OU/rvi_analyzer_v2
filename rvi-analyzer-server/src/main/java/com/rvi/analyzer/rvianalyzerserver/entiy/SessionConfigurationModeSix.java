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
@Table(name = "SessionConfigurationModeSix")
public class SessionConfigurationModeSix {
    @Id
    private Long _id;
    @Column
    private String fixedCurrent;
    @Column
    private String maxVoltage;
    @Column
    private String timeDuration;
}
