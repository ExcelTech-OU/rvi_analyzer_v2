package com.rvi.analyzer.rvianalyzerserver.repository;

import com.rvi.analyzer.rvianalyzerserver.entiy.Device;
import com.rvi.analyzer.rvianalyzerserver.entiy.User;
import org.springframework.data.mongodb.repository.Aggregation;
import org.springframework.data.mongodb.repository.Query;
import org.springframework.data.mongodb.repository.ReactiveMongoRepository;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

public interface DeviceRepository extends ReactiveMongoRepository<Device, String> {

    @Query(
            value = """
    {
        "mac-address" : {
            "$eq" : ?0
        }
    }
    """
    )
    Mono<Device> findByMacAddress(String mac);


//    @Aggregation("{'created-by': ?3}")
    @Query(
            value = """
    {
        "assign-to" : {
            "$eq" : ?3
        }
    }
    """
    )
    Flux<Device> findDevicesByNameStatusPageUserName(String name, String status, String page, String username);


    @Query(value = "{ 'assign-to': ?0 }", count = true)
    Mono<Long> countDevicesByUsername(String username);

}
