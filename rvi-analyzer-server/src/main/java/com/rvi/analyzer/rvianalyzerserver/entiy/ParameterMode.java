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
@Table(name = "ParameterMode")
public class ParameterMode {
    @Id
    private Long _id;
    @Column
    private Long testId;
    @Column
    private String name;
    @Column
    private String parameter;
}
