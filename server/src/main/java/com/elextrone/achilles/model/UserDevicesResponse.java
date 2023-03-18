package com.elextrone.achilles.model;

import com.elextrone.achilles.repo.entity.Device;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserDevicesResponse {
    private String status;
    private List<Device> devices;
}
