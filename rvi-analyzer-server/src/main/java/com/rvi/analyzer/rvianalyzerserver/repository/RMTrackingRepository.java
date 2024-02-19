//package com.rvi.analyzer.rvianalyzerserver.repository;
//
//import com.rvi.analyzer.rvianalyzerserver.entiy.RMTracking;
//import com.rvi.analyzer.rvianalyzerserver.entiy.Style;
//import com.rvi.analyzer.rvianalyzerserver.entiy.User;
// // import org.springframework.data.mongodb.repository.Query;
// // import org.springframework.data.mongodb.repository.ReactiveMongoRepository;
//import reactor.core.publisher.Flux;
//import reactor.core.publisher.Mono;
//
//public interface RMTrackingRepository extends ReactiveMongoRepository<RMTracking, String> {
//
//    @Query(
//            value = """
//                    {
//                        "userId" : {
//                            $eq: ?0
//                        }
//                    }
//                    """
//    )
//    Mono<RMTracking> findByUserId(String name);
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
//    Flux<RMTracking> findByCreatedBy(String createdBy);
//}
