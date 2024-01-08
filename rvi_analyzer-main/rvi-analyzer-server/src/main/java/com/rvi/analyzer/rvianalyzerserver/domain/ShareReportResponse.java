package com.rvi.analyzer.rvianalyzerserver.domain;

import com.rvi.analyzer.rvianalyzerserver.dto.ModeOneDto;
import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class ShareReportResponse {
    private String status;
    private String statusDescription;
    private String url;
    private String password;
}
