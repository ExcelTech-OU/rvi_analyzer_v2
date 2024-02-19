//package com.rvi.analyzer.rvianalyzerserver.repository;
//
//import com.rvi.analyzer.rvianalyzerserver.entiy.CustomerPO;
// // import org.springframework.data.mongodb.repository.Query;
// // import org.springframework.data.mongodb.repository.ReactiveMongoRepository;
//import reactor.core.publisher.Flux;
//import reactor.core.publisher.Mono;
//
//public interface CustomerPORepository extends ReactiveMongoRepository<CustomerPO, String> {
//
//    @Query(
//            value = """
//                    {
//                        "name" : {
//                            $eq: ?0
//                        }
//                    }
//                    """
//    )
//    Mono<CustomerPO> findByName(String name);
//
////    @Query(
////            value = """
////    {
////        "username" : {
////            $regex: .*?0.*
////        }
////    }
////    """
////    )
////    Flux<User> findByUserNamePattern(String pattern);
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
//    Flux<CustomerPO> findByCreatedBy(String createdBy);
//}
