package com.rvi.analyzer.rvianalyzerserver.entiy;

import com.rvi.analyzer.rvianalyzerserver.domain.UserRoles;
import lombok.*;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

@Data
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "Role")
public class Role {
    @Column
    private Long roleId;
    @Column
    private UserRoles roleName;
}
