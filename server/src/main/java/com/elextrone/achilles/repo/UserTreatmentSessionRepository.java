package com.elextrone.achilles.repo;

import com.elextrone.achilles.repo.entity.UserTreatmentSession;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserTreatmentSessionRepository extends CrudRepository<UserTreatmentSession, Long> {

    @Query(name = "SELECT * FROM user_treatment_session  WHERE user_id = :id ORDER BY created_date DESC", nativeQuery = true)
    List<UserTreatmentSession> findLatestTestResultByUserId(@Param("id") Long id);

    @Query("SELECT uts FROM user_treatment_session uts WHERE user_id = :id ORDER BY created_date DESC")
    List<UserTreatmentSession> findAllSessionsByUserId(@Param("id") Long id);
    @Query("SELECT uts FROM user_treatment_session uts WHERE device_id = :id ORDER BY created_date DESC")
    List<UserTreatmentSession> findAllSessionsByDeviceId(@Param("id") Long id);

}
