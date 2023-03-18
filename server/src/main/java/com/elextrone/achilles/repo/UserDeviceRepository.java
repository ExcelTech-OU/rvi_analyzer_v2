package com.elextrone.achilles.repo;

import com.elextrone.achilles.repo.entity.UserDevice;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;
import java.util.List;

@Repository
public interface UserDeviceRepository extends CrudRepository<UserDevice, Long> {

    @Query("SELECT ud FROM user_device ud WHERE user_id = :id AND enabled = :enabled")
    List<UserDevice> findActiveDevicesByUSerID(@Param("id") Long id, @Param("enabled") boolean enabled);
    @Transactional
    @Modifying
    @Query("UPDATE user_device SET enabled = :enabled WHERE user_id = :id AND device_id = :deviceId")
    void removeUserDevice(@Param("id") Long id, @Param("deviceId") Long deviceId, @Param("enabled") boolean enabled);

}
