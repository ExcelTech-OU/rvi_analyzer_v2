package com.elextrone.achilles.repo;

import com.elextrone.achilles.repo.entity.Question;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;
import java.util.List;

@Repository
public interface QuestionRepository extends CrudRepository<Question, Long> {

    @Query("SELECT q FROM question q WHERE enabled = :bool")
    List<Question> findQuestions(@Param("bool") boolean bool);

    @Query("SELECT q FROM question q WHERE id = :id")
    Question findQuestion(@Param("id") int id);

    @Transactional
    @Modifying
    @Query(value = "UPDATE question SET enabled = :status, question = :question WHERE id = :id", nativeQuery = true)
    void updateQuestion(@Param("id") Long id, @Param("question") String question, @Param("status") boolean status);
}
