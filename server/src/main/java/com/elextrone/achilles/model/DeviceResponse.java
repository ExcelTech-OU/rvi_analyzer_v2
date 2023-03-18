package com.elextrone.achilles.model;

import com.elextrone.achilles.repo.entity.Device;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DeviceResponse {
    Device device = null;
}
