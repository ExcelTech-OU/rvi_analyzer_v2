package com.elextrone.achilles.repo;

import com.elextrone.achilles.repo.entity.Heater;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface HeaterRepository extends CrudRepository<Heater, Long> {

    @Query("SELECT h FROM heater h WHERE device_id = :id")
    Heater findHeaterByDeviceId(@Param("id") Long id);

}
