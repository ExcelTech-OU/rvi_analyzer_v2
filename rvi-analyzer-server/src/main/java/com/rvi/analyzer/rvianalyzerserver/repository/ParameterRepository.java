//package com.rvi.analyzer.rvianalyzerserver.repository;
//
//import com.rvi.analyzer.rvianalyzerserver.entiy.Parameter;
//import com.rvi.analyzer.rvianalyzerserver.entiy.Plant;
// // import org.springframework.data.mongodb.repository.Query;
// // import org.springframework.data.mongodb.repository.ReactiveMongoRepository;
//import reactor.core.publisher.Flux;
//import reactor.core.publisher.Mono;
//
//public interface ParameterRepository extends ReactiveMongoRepository<Parameter, String> {
//    @Query(
//            value = """
//                    {
//                        "name" : {
//                            $eq: ?0
//                        }
//                    }
//                    """
//    )
//    Mono<Parameter> findByName(String name);
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
//    Flux<Parameter> findByCreatedBy(String createdBy);
//}
