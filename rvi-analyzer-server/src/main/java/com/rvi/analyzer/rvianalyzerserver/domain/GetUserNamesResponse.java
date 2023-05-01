package com.rvi.analyzer.rvianalyzerserver.domain;

import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class GetUserNamesResponse {
    private String status;
    private String statusDescription;
    private List<String> usernames;
}
