package com.elextrone.achilles.model;

import com.elextrone.achilles.repo.entity.User;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserListResponse {
    List<UserObj> users = new ArrayList<>();
}
