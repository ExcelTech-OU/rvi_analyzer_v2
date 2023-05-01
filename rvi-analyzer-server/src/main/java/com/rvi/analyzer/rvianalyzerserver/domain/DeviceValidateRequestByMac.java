package com.rvi.analyzer.rvianalyzerserver.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DeviceValidateRequestByMac {
    private String mac;
}
