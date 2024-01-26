package com.rvi.analyzer.rvianalyzerserver.repository;

import com.rvi.analyzer.rvianalyzerserver.entiy.Material;
import com.rvi.analyzer.rvianalyzerserver.entiy.Test;
import com.rvi.analyzer.rvianalyzerserver.entiy.User;
import org.springframework.data.mongodb.repository.Query;
import org.springframework.data.mongodb.repository.ReactiveMongoRepository;
import reactor.core.publisher.Mono;

public interface TestRepository extends ReactiveMongoRepository<Test, String> {
    @Query(
            value = """
                    {
                        "testGate" : {
                            $eq: ?0
                        }
                    }
                    """
    )
    Mono<Test> findByTestGate(String testGate);
}
