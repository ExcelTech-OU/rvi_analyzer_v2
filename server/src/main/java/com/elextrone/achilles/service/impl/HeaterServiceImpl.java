package com.elextrone.achilles.service.impl;

import com.elextrone.achilles.model.HeaterByDeviceIdResponse;
import com.elextrone.achilles.repo.HeaterRepository;
import com.elextrone.achilles.service.HeaterService;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Mono;

@Service
@AllArgsConstructor
public class HeaterServiceImpl implements HeaterService {

    @Autowired
    private HeaterRepository heaterRepository;

    @Override
    public Mono<ResponseEntity<HeaterByDeviceIdResponse>> getHeaterByDeviceId(Long deviceId) {
        return Mono.just(ResponseEntity.ok(new HeaterByDeviceIdResponse( "S1000" ,heaterRepository.findHeaterByDeviceId(deviceId))));
    }
}
