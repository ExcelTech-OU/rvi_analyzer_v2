package com.rvi.analyzer.rvianalyzerserver.repository;

import com.rvi.analyzer.rvianalyzerserver.entiy.ModeThree;
import com.rvi.analyzer.rvianalyzerserver.entiy.ModeTwo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.ReactiveMongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Repository;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.util.List;

@Repository
public class ModeTwoRepository {
    @Autowired
    ReactiveMongoTemplate template;

    public Flux<ModeTwo> findByFilters(Query query) {
        return template.find(query, ModeTwo.class);
    }

    public Mono<ModeTwo> findLatest(Query query) {
        return template.findOne(query, ModeTwo.class);
    }

    public Mono<Long> countByFilters(Query query) {
        return template.count(query, ModeTwo.class);
    }

    public Mono<ModeTwo> findBySessionID(String sessionId) {
        Query query = new Query();
        query.addCriteria(Criteria.where("default-configurations.session-id").is(sessionId));
        return template.findOne(query, ModeTwo.class);
    }

    public Mono<ModeTwo> save(ModeTwo modeTwo) {
        return template.save(modeTwo);
    }

    public Mono<Long> countSessionsByUsers(List<String> users) {
        Query query = new Query();
        query.addCriteria(Criteria.where("created-by").in(users));
        return template.count(query, ModeTwo.class);
    }
}
