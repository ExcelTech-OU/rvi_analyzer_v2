//package com.rvi.analyzer.rvianalyzerserver.repository;
//
//import com.rvi.analyzer.rvianalyzerserver.entiy.Report;
// // import org.springframework.data.mongodb.repository.Query;
// // import org.springframework.data.mongodb.repository.ReactiveMongoRepository;
//import reactor.core.publisher.Mono;
//
//public interface ReportRepository extends ReactiveMongoRepository<Report, String> {
//
//    @Query(
//            value = """
//    {
//        "url-hash" : {
//            $eq: ?0
//        }
//    }
//    """
//    )
//    Mono<Report> findByHash(String hash);
//}
