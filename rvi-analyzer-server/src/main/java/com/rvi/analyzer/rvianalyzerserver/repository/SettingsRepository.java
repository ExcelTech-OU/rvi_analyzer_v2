package com.rvi.analyzer.rvianalyzerserver.repository;

import com.rvi.analyzer.rvianalyzerserver.entiy.Settings;

import org.springframework.data.mongodb.repository.Query;
import org.springframework.data.mongodb.repository.ReactiveMongoRepository;
import reactor.core.publisher.Mono;

public interface SettingsRepository extends ReactiveMongoRepository<Settings, String> {
    @Query(value = """
            {
                "setting-id" : {
                    "$eq" : ?0
                }
            }
            """)
    Mono<Settings> getSettingBySettingId(String settingId);
}