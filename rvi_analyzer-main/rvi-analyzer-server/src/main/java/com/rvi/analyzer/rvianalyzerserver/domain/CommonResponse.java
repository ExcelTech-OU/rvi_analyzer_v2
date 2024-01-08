package com.rvi.analyzer.rvianalyzerserver.domain;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class CommonResponse {
    private String status;
    private String statusDescription;

    public static CommonResponse success(){
        return CommonResponse.builder()
                .status("S1000")
                .statusDescription("Request was success")
                .build();
    }

    public static CommonResponse fail(){
        return CommonResponse.builder()
                .status("E1000")
                .statusDescription("Request was failed")
                .build();
    }

}
