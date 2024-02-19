package com.rvi.analyzer.rvianalyzerserver.repository;

import com.rvi.analyzer.rvianalyzerserver.entiy.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserRepository extends JpaRepository<User, String> {

    User findByUsername(String username);

    List<User> findByUsernameContaining(String username);

    List<User> findByCreatedBy(String createdBy);

    @Query("SELECT COUNT(u) FROM User u WHERE u.createdBy like %:username%")
    Long countUsersByCreatedBy(String username);
}
