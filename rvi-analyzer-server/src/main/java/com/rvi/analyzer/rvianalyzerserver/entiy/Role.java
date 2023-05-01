package com.rvi.analyzer.rvianalyzerserver.entiy;

import com.rvi.analyzer.rvianalyzerserver.domain.UserRoles;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

@Document
@Builder
@Getter
@Setter
public class Role {
    @Field(name = "role-id")
    private String roleId;
    @Field(name = "role-name")
    private UserRoles roleName;
}
