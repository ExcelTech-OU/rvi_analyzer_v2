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
@Table(name = "SessionConfigurationModeThree")
public class SessionConfigurationModeThree {
    @Id
    private Long _id;
    @Column
    private String startingVoltage;
    @Column
    private String desiredVoltage;
    @Column
    private String maxCurrent;
    @Column
    private String voltageResolution;
    @Column
    private String chargeInTime;
}
