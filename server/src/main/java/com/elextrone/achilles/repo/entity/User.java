package com.elextrone.achilles.repo.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.*;

import javax.persistence.*;
import java.util.Date;
import java.util.LinkedHashSet;
import java.util.Set;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Getter
@Setter
@Entity(name = "users")
public class User {

    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    private Long id;
    private String name;
    private String email;
    private String username;
    private String password;
    private int age;
    private String occupation;
    @Column(name = "user_condition")
    private String condition;
    @Column(name = "role_id")
    private int roleId;
    @Column(name = "password_reset_pin")
    private int pin;
    @Column(name = "is_pin_validated")
    private boolean isPinValidated;
    private boolean enabled;
    @Column(name = "created_date")
    private Date createdDate;
    @Column(name = "last_updated_date")
    private Date lastUpdatedDate;

    @OneToMany(mappedBy="user", fetch = FetchType.LAZY)
    @JsonIgnore
    private Set<UserTreatmentSession> sessions = new LinkedHashSet<>();

    @PrePersist
    protected void onCreate() {
        createdDate = new Date();
    }

    @PreUpdate
    protected void onUpdate() {
        lastUpdatedDate = new Date();
    }
}
