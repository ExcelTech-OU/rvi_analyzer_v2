package com.elextrone.achilles.controller;

import com.elextrone.achilles.model.HeaterByDeviceIdResponse;
import com.elextrone.achilles.service.HeaterService;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Mono;

@AllArgsConstructor
@RestController
public class HeaterController {

    private HeaterService heaterService;

    @GetMapping("/heater/{id}")
    @PreAuthorize("hasRole('USER')")
    public Mono<ResponseEntity<HeaterByDeviceIdResponse>> getHeaterByDeviceId(@RequestHeader("Authorization") String auth, @PathVariable String id) {
        return heaterService.getHeaterByDeviceId(Long.parseLong(id));
    }

}
