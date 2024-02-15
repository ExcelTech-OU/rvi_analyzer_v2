package com.rvi.analyzer.rvianalyzerserver.repository;

import com.rvi.analyzer.rvianalyzerserver.entiy.Device;
import org.springframework.data.r2dbc.repository.Query;
import org.springframework.data.r2dbc.repository.R2dbcRepository;
import org.springframework.stereotype.Repository;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

@Repository
public interface DeviceRepository extends R2dbcRepository<Device, Integer> {
    Mono<Device> findBymacAddress(String mac);

    @Query("""
            SELECT *
            FROM Device d
            WHERE (name LIKE CONCAT('%', :name, '%') OR :name IS NULL)
              AND (status = :status OR :status IS NULL)
              AND (createdBy = :username OR :username IS NULL)
            ORDER BY createdDateTime DESC
            LIMIT :limit OFFSET :offset;
            """)
    Flux<Device> findDevicesByNameStatusPageUserName(String name, String status, String page, String username);
//    Mono<Long> countDevicesByUsername(String username);

}
