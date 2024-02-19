package com.rvi.analyzer.rvianalyzerserver.entiy;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


import java.time.LocalDateTime;

@Builder
@Getter
@Setter
@ToString
public class Customer {
    private String _id;
    private String name;
    private String createdBy;
    private String status;
    //    private String plant;
    private LocalDateTime createdDateTime;
    private LocalDateTime lastUpdatedDateTime;
}
