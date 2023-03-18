package com.elextrone.achilles.repo;

import com.elextrone.achilles.repo.entity.User;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;

@Repository
public interface UserRepository extends CrudRepository<User, Long> {

    @Query("SELECT u FROM users u WHERE username = :username")
    User findByUsername(@Param("username") String username);

    @Query("SELECT u FROM users u WHERE email = :email")
    User findByEmail(@Param("email") String email);
    @Transactional
    @Modifying
    @Query("UPDATE users SET enabled = :status, condition = :condition, age = :age, occupation = :occupation WHERE email = :email")
    void updateUser(@Param("status") boolean status, @Param("occupation") String occupation,
                    @Param("condition") String condition, @Param("age") int age,
                    @Param("email") String email);

    @Query("SELECT COUNT(id) FROM users WHERE enabled = :status")
    int getTotalUsers(@Param("status") boolean status);
}
