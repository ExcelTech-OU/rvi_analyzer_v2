package com.elextrone.achilles.repo.entity;

import com.elextrone.achilles.repo.utill.DeviceStatus;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.*;

import javax.persistence.*;
import java.util.Date;
import java.util.LinkedHashSet;
import java.util.Set;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
@Setter
@Entity(name = "device")
public class Device {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    @Column(unique = true)
    private String name;
    @Column(name = "mac_address", unique = true)
    private String macAddress;
    @Column(name = "batch_no")
    private String batchNo;
    @Column(name = "firmware_version")
    private String firmwareVersion;
    @Column(name = "connected_network_id")
    private String connectedNetworkId;
    private String status;
    @OneToMany(mappedBy = "device", fetch = FetchType.LAZY)
    @JsonIgnore
    private Set<UserTreatmentSession> sessions = new LinkedHashSet<>();
    @Column(name = "created_date")
    private Date createdDate;
    @Column(name = "last_updated_date")
    private Date lastUpdatedDate;

    @PrePersist
    protected void onCreate() {
        createdDate = new Date();
    }

    @PreUpdate
    protected void onUpdate() {
        lastUpdatedDate = new Date();
    }

}
