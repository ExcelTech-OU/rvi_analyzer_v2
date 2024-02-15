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
@Table(name = "SessionConfigurationModeOne")
public class SessionConfigurationModeOne {
    @Id
    private Long _id;
    @Column
    private String voltage;
    @Column
    private String maxCurrent;
    @Column
    private String passMinCurrent;
    @Column
    private String passMaxCurrent;
}
