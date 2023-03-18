package com.elextrone.achilles.repo;

import com.elextrone.achilles.repo.entity.UserTreatmentAnsweringSession;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserTreatmentAnsweringSessionRepository extends CrudRepository<UserTreatmentAnsweringSession, Long> {
    @Query(name = "SELECT uts FROM user_treatment_answering_session uts WHERE session_id = :id ")
    List<UserTreatmentAnsweringSession> findUTASBySessionId(@Param("id") long id);
}
