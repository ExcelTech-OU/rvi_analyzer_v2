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
@Table(name = "SessionConfigurationModeFour")
public class SessionConfigurationModeFour {
    @Id
    private Long _id;
    @Column
    private String startingCurrent;
    @Column
    private String desiredCurrent;
    @Column
    private String maxVoltage;
    @Column
    private String currentResolution;
    @Column
    private String chargeInTime;
}
