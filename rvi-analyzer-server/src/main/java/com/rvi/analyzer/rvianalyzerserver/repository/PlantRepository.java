//package com.rvi.analyzer.rvianalyzerserver.repository;
//
//import com.rvi.analyzer.rvianalyzerserver.entiy.Plant;
// // import org.springframework.data.mongodb.repository.Query;
// // import org.springframework.data.mongodb.repository.ReactiveMongoRepository;
//import reactor.core.publisher.Flux;
//import reactor.core.publisher.Mono;
//
//public interface PlantRepository extends ReactiveMongoRepository<Plant, String> {
//    @Query(
//            value = """
//                    {
//                        "name" : {
//                            $eq: ?0
//                        }
//                    }
//                    """
//    )
//    Mono<Plant> findByName(String name);
//
//    @Query(
//            value = """
//                    {
//                        "created-by" : {
//                            $eq: ?0
//                        }
//                    }
//                    """
//    )
//    Flux<Plant> findByCreatedBy(String createdBy);
//}
