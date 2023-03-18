package com.elextrone.achilles.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserHistoryResponse {
    private String temperature;
    private String painLevel;
    private String name;
    private String totalTime;
}
