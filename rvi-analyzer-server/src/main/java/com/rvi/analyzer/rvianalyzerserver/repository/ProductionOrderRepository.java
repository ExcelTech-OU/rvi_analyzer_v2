//package com.rvi.analyzer.rvianalyzerserver.repository;
//
//import com.rvi.analyzer.rvianalyzerserver.entiy.*;
// // import org.springframework.data.mongodb.repository.Query;
// // import org.springframework.data.mongodb.repository.ReactiveMongoRepository;
//import reactor.core.publisher.Flux;
//import reactor.core.publisher.Mono;
//
//public interface ProductionOrderRepository extends ReactiveMongoRepository<ProductionOrder, String> {
//    @Query(
//            value = """
//                    {
//                        "orderId" : {
//                            $eq: ?0
//                        }
//                    }
//                    """
//    )
//    Mono<ProductionOrder> findByOrderId(String orderId);
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
//    Flux<ProductionOrder> findByCreatedBy(String createdBy);
//}
