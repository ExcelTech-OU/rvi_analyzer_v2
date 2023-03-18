package com.elextrone.achilles.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UpdateDeviceRequestByName {
    private String name;
    private String batchNo;
    private String firmwareVersion;
    private String status;
}
