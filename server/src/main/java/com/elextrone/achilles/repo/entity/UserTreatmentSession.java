package com.elextrone.achilles.repo.entity;

import com.elextrone.achilles.model.UserTreatmentSessionStatus;
import lombok.*;

import javax.persistence.*;
import java.util.Date;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
@Setter
@Entity(name = "user_treatment_session")
public class UserTreatmentSession {

    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    private Long id;

    @ManyToOne
    @JoinColumn(name="user_id", nullable=false)
    private User user;

    @ManyToOne
    @JoinColumn(name="device_id", nullable=false)
    private Device device;

    @Column(name = "protocol_id")
    private String protocolId;
    @Column(name = "selected_pain_level")
    private int SelectedPainLevel;
    @Column(name = "selected_temperature")
    private int SelectedTemperature;
    @Column(name = "initial_selected_time")
    private int initialSelectedTime;
    @Column(name = "initial_battery_level")
    private int initialBatteryLevel;
    @Column(name = "final_temperature")
    private int finalTemperature;
    @Column(name = "actual_treatment_time")
    private int actualTreatmentTime;
    @Column(name = "end_battery_level")
    private int endBatteryLevel;
    @Column(name = "feedback_pain_level")
    private String feedbackPainLevel;
    @Column(name = "status")
    private UserTreatmentSessionStatus status;
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
