package com.elextrone.achilles.repo;

import com.elextrone.achilles.repo.entity.Device;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;
import java.util.List;

@Repository
public interface DeviceRepository extends JpaRepository<Device, Long> {

    @Query(value = "SELECT * FROM device WHERE id in (SELECT device_id FROM user_device where user_id = :id AND enabled = :bool) AND status = :status",
            nativeQuery = true)
    List<Device> findActiveDevicesByUsername(@Param("id") Long id, @Param("bool") boolean bool, @Param("status") String status);

    @Query("SELECT d FROM device d WHERE mac_address = :mac AND status = :status")
    Device findActiveDeviceByMac(@Param("mac") String mac, @Param("status") String status);

    @Query(value = "SELECT d FROM device d WHERE name = :name AND status = :status")
    Device findActiveDeviceByName(@Param("name") String name, @Param("status") String status);

    @Query("SELECT d FROM device d ORDER BY last_updated_date desc")
    List<Device> findDevices(int skip, String status);

    Device findDeviceByName(String name);
    @Transactional
    @Modifying
    @Query("UPDATE device SET status = :status, batch_no = :batchNo, firmware_version = :firmwareVersion WHERE name = :name")
    void updateDevice(@Param("status") String status, @Param("name") String name,
                      @Param("firmwareVersion") String firmwareVersion, @Param("batchNo") String batchNo);

    @Query("SELECT COUNT(id) FROM device WHERE status = :status")
    int getTotalDevices(@Param("status") String status);

}
