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
@Table(name = "Parameter")
public class Parameter {
    @Id
    private Long _id;
    @Column
    private String name;
    @Column
    private String createdBy;
    //    private String plant;
    @Column
    private LocalDateTime createdDateTime;
}
