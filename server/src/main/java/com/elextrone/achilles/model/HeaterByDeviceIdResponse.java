package com.elextrone.achilles.model;

import com.elextrone.achilles.repo.entity.Heater;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class HeaterByDeviceIdResponse {
    private String status;
    private Heater heater;
}
