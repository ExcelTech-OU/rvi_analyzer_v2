package com.elextrone.achilles.repo;

import com.elextrone.achilles.repo.entity.Answer;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AnswerRepository extends CrudRepository<Answer, Long> {

    @Query("SELECT a FROM answer a WHERE question_id = :id")
    List<Answer> findAnswers(@Param("id") Long id);

}
