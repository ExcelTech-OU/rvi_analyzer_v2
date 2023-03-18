package com.elextrone.achilles.model;

import com.elextrone.achilles.repo.entity.UserTreatmentSession;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ViewSessionsResponse {
    List<UserTreatmentSession> sessions = new ArrayList<>();
}
