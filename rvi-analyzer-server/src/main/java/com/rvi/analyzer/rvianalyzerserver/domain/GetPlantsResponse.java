package com.rvi.analyzer.rvianalyzerserver.domain;

import com.elextrone.smart_store_server.repo.entity.Plant;
import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class GetPlantsResponse {
    private String status;
    private String statusDescription;
    private List<Plant> plants;
    private int total;
}
