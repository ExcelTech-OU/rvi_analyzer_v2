package com.elextrone.achilles.repo.entity;

import com.elextrone.achilles.repo.utill.HeaterConnectedStatus;
import lombok.*;

import javax.persistence.*;
import java.util.Date;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
@Setter
@Entity(name = "heater")
public class Heater {

    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    private Long id;

    @Column(name = "batch_no")
    private String batchNo;

    @Column(name = "manufactured_resistance")
    private float manufacturedResistance;

    @Column(name = "current_resistance")
    private float currentResistance;

    @OneToOne(
            fetch = FetchType.LAZY
    )
    @JoinColumn(
            name = "device_id",
            referencedColumnName = "id"
    )
    private Device device;

    @Column(name = "connected_status")
    private HeaterConnectedStatus connectedStatus;

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
