//package com.rvi.analyzer.rvianalyzerserver.repository;
//
//import com.rvi.analyzer.rvianalyzerserver.entiy.Material;
//import com.rvi.analyzer.rvianalyzerserver.entiy.User;
// // import org.springframework.data.mongodb.repository.Query;
// // import org.springframework.data.mongodb.repository.ReactiveMongoRepository;
//import reactor.core.publisher.Mono;
//
//public interface MaterialRepository extends ReactiveMongoRepository<Material, String> {
//    @Query(
//            value = """
//                    {
//                        "name" : {
//                            $eq: ?0
//                        }
//                    }
//                    """
//    )
//    Mono<Material> findByName(String name);
//}
