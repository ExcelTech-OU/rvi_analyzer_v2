//package com.rvi.analyzer.rvianalyzerserver.repository;
//
//import com.rvi.analyzer.rvianalyzerserver.entiy.Customer;
// // import org.springframework.data.mongodb.repository.Query;
// // import org.springframework.data.mongodb.repository.ReactiveMongoRepository;
//import reactor.core.publisher.Flux;
//import reactor.core.publisher.Mono;
//
//public interface CustomerRepository extends ReactiveMongoRepository<Customer, String> {
//    @Query(
//            value = """
//                    {
//                        "name" : {
//                            $eq: ?0
//                        }
//                    }
//                    """
//    )
//    Mono<Customer> findByName(String name);
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
//    Flux<Customer> findByCreatedBy(String createdBy);
//}
