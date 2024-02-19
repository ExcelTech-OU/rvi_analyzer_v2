//package com.rvi.analyzer.rvianalyzerserver.repository;
//
//import com.rvi.analyzer.rvianalyzerserver.entiy.Material;
//import com.rvi.analyzer.rvianalyzerserver.entiy.SONumber;
//import com.rvi.analyzer.rvianalyzerserver.entiy.Test;
//import com.rvi.analyzer.rvianalyzerserver.entiy.User;
// // import org.springframework.data.mongodb.repository.Query;
// // import org.springframework.data.mongodb.repository.ReactiveMongoRepository;
//import reactor.core.publisher.Flux;
//import reactor.core.publisher.Mono;
//
//public interface SONumberRepository extends ReactiveMongoRepository<SONumber, String> {
//    @Query(
//            value = """
//                    {
//                        "soNumber" : {
//                            $eq: ?0
//                        }
//                    }
//                    """
//    )
//    Mono<SONumber> findBySONumber(String number);
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
//    Flux<SONumber> findByCreatedBy(String createdBy);
//}
