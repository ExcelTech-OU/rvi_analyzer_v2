package com.elextrone.achilles.model;

import com.elextrone.achilles.repo.entity.Device;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DeviceListResponse {
    List<Device> devices = new ArrayList<>();
}
