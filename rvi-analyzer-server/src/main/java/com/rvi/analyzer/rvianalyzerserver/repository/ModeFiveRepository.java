//package com.rvi.analyzer.rvianalyzerserver.repository;
//
//import com.rvi.analyzer.rvianalyzerserver.entiy.ModeFive;
//import com.rvi.analyzer.rvianalyzerserver.entiy.ModeFour;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.data.mongodb.core.ReactiveMongoTemplate;
//import org.springframework.data.mongodb.core.query.Criteria;
//import org.springframework.data.mongodb.core.query.Query;
//import org.springframework.stereotype.Repository;
//import reactor.core.publisher.Flux;
//import reactor.core.publisher.Mono;
//
//import java.util.List;
//
//@Repository
//public class ModeFiveRepository {
//    @Autowired
//    ReactiveMongoTemplate template;
//
//    public Flux<ModeFive> findByFilters(Query query) {
//        return template.find(query, ModeFive.class);
//    }
//
//    public Mono<ModeFive> findLatest(Query query) {
//        return template.findOne(query, ModeFive.class);
//    }
//
//
//    public Mono<Long> countByFilters(Query query) {
//        return template.count(query, ModeFive.class);
//    }
//
//    public Mono<ModeFive> findBySessionID(String sessionId) {
//        Query query = new Query();
//        query.addCriteria(Criteria.where("default-configurations.session-id").is(sessionId));
//        return template.findOne(query, ModeFive.class);
//    }
//
//    public Mono<ModeFive> save(ModeFive modeFive) {
//        return template.save(modeFive);
//    }
//
//    public Mono<Long> countSessionsByUsers(List<String> users) {
//        Query query = new Query();
//        query.addCriteria(Criteria.where("created-by").in(users));
//        return template.count(query, ModeFive.class);
//    }
//}
