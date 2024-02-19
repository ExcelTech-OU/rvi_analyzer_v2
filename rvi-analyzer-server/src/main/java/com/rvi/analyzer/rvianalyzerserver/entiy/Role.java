package com.rvi.analyzer.rvianalyzerserver.entiy;

import com.rvi.analyzer.rvianalyzerserver.domain.UserRoles;
import jakarta.persistence.*;
import lombok.*;

import java.util.List;

@Table(name = "user_role")
@Builder
@Getter
@Setter
@Entity
@NoArgsConstructor
@AllArgsConstructor
public class Role {

    @Id
    @Column(name = "role_id")
    private String id;

    @Enumerated(EnumType.STRING)
    private UserRoles roleName;

    @OneToMany(mappedBy = "role")
    private List<GroupRole> groupRole;
}
