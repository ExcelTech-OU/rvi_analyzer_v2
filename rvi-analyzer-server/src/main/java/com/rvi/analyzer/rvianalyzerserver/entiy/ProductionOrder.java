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
@Table(name = "ProductionOrder")
public class ProductionOrder {
    @Id
    private Long _id;
    @Column
    private String soNumber;
    @Column
    private String orderId;
    @Column
    private String createdBy;
    @Column
    @CreatedDate
    private LocalDateTime createdDateTime;

}
