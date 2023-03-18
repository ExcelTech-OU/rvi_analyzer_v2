package com.elextrone.achilles.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.relational.core.mapping.Column;

import java.util.List;
import java.util.Map;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserFeedBackRequest {
    private List<Map<String, String>> answers;
    private String deviceId;
    private String protocolId;
    private String temperature;
    private String finalTemperature;
    private String painLevel;
    private String feedbackPainLevel;
    private String remainingTime;
    private String initialBatteryLevel;
    private String finalBatteryLevel;
    private String initialSelectedTime;
    private String status;
}
