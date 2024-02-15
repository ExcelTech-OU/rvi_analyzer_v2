package com.rvi.analyzer.rvianalyzerserver.repository;

import com.rvi.analyzer.rvianalyzerserver.entiy.Report;
import org.springframework.data.r2dbc.repository.Query;
import org.springframework.data.r2dbc.repository.R2dbcRepository;
import reactor.core.publisher.Mono;

public interface ReportRepository extends R2dbcRepository<Report, Integer> {
    @Query("""
            SELECT *
            FROM Report
            WHERE urlHash = :hash;
            """)
    Mono<Report> findByHash(String hash);
}
