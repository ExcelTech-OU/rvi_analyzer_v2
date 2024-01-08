package com.rvi.analyzer.rvianalyzerserver.domain;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class DashboardResponse {
    final String status;
    final String statusDescription;
    private int modeOne;
    private int modeTwo;
    private int modeThree;
    private int modeFour;
    private int modeFive;
    private int modeSix;
    private int devices;
    private int users;

}
