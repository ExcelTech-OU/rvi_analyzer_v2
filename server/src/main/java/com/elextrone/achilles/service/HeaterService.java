package com.elextrone.achilles.service;

import com.elextrone.achilles.model.HeaterByDeviceIdResponse;
import org.springframework.http.ResponseEntity;
import reactor.core.publisher.Mono;

public interface HeaterService {
    Mono<ResponseEntity<HeaterByDeviceIdResponse>> getHeaterByDeviceId(Long id);
}
