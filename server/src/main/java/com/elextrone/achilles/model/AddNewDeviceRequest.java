package com.elextrone.achilles.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AddNewDeviceRequest {
    private String name;
    private String macAddress;
    private String batchNo;
    private String firmwareVersion;
}
