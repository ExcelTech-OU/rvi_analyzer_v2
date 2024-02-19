package com.rvi.analyzer.rvianalyzerserver.entiy;

import jakarta.persistence.*;
import lombok.*;

import java.util.List;

@Builder
@Getter
@Setter
@Table(name = "user_group")
@Entity
@NoArgsConstructor
@AllArgsConstructor
public class Group {

    @Id
    @Column(name = "group_id")
    private String groupId;
    private String groupName;

    @OneToMany(mappedBy = "group")
    private List<GroupRole> groupRole;
}
