package com.rvi.analyzer.rvianalyzerserver.repository;

import com.rvi.analyzer.rvianalyzerserver.entiy.Material;
import com.rvi.analyzer.rvianalyzerserver.entiy.Test;
import com.rvi.analyzer.rvianalyzerserver.entiy.TestResult;
import com.rvi.analyzer.rvianalyzerserver.entiy.User;
import org.springframework.data.mongodb.repository.Query;
import org.springframework.data.mongodb.repository.ReactiveMongoRepository;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

public interface TestResultRepository extends ReactiveMongoRepository<TestResult, String> {
    @Query(
            value = """
                    {
                        "productId" : {
                            $eq: ?0
                        }
                    }
                    """
    )
    Mono<TestResult> findByProductId(String productId);

    @Query(
            value = """
                    {
                        "created-by" : {
                            $eq: ?0
                        }
                    }
                    """
    )
    Flux<TestResult> findByCreatedBy(String createdBy);
}
