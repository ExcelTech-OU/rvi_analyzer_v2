package com.elextrone.achilles.repo.entity;

import com.elextrone.achilles.model.auth.Roles;
import lombok.*;

import javax.persistence.*;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Entity(name = "role")
public class Role {

    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    private Integer id;
    private Roles roles;
}
