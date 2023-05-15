package com.rvi.analyzer.rvianalyzerserver.repository;

import com.rvi.analyzer.rvianalyzerserver.entiy.ModeOne;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.ReactiveMongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Repository;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.util.List;

@Repository
public class ModeOneRepository {
    @Autowired
    ReactiveMongoTemplate template;

    public Flux<ModeOne> findByFilters(Query query) {
        return template.find(query, ModeOne.class);
    }

    public Mono<ModeOne> findBySessionID(String sessionId) {
        Query query = new Query();
        query.addCriteria(Criteria.where("default-configurations.session-id").is(sessionId));
        return template.findOne(query, ModeOne.class);
    }

    public Mono<ModeOne> save(ModeOne modeOne) {
        return template.save(modeOne);
    }

    public Mono<Long> countSessionsByUsers(List<String> users) {
        Query query = new Query();
        query.addCriteria(Criteria.where("created-by").in(users));
        return template.count(query, ModeOne.class);
    }
}
