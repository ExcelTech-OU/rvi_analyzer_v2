package com.rvi.analyzer.rvianalyzerserver.repository;

import com.rvi.analyzer.rvianalyzerserver.entiy.ModeSix;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.ReactiveMongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Repository;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.util.List;

@Repository
public class ModeSixRepository {
    @Autowired
    ReactiveMongoTemplate template;

    public Flux<ModeSix> findByFilters(Query query) {
        return template.find(query, ModeSix.class);
    }

    public Mono<ModeSix> findBySessionID(String sessionId) {
        Query query = new Query();
        query.addCriteria(Criteria.where("default-configurations.session-id").is(sessionId));
        return template.findOne(query, ModeSix.class);
    }

    public Mono<ModeSix> save(ModeSix modeSix) {
        return template.save(modeSix);
    }

    public Mono<Long> countSessionsByUsers(List<String> users) {
        Query query = new Query();
        query.addCriteria(Criteria.where("created-by").in(users));
        return template.count(query, ModeSix.class);
    }
}
