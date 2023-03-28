package com.rvi.analyzer.rvianalyzerserver.repository;

import com.rvi.analyzer.rvianalyzerserver.entiy.Device;
import com.rvi.analyzer.rvianalyzerserver.entiy.User;
import org.springframework.data.mongodb.repository.ReactiveMongoRepository;
import reactor.core.publisher.Mono;

public interface DeviceRepository extends ReactiveMongoRepository<Device, String> {
    Mono<Device> findByMacAddress(String mac);
}
