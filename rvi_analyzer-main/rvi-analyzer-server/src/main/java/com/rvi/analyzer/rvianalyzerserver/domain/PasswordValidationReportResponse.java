package com.rvi.analyzer.rvianalyzerserver.domain;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.rvi.analyzer.rvianalyzerserver.dto.*;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
@JsonInclude(JsonInclude.Include.NON_NULL)
public class PasswordValidationReportResponse {
    private String status;
    private String statusDescription;
    private int modeId;
    private ModeOneDto modeOneDto;
    private ModeTwoDto modeTwoDto;
    private ModeThreeDto modeThreeDto;
    private ModeFourDto modeFourDto;
    private ModeSixDto modeSixDto;
    private ModeFiveDto modeFiveDto;
}
