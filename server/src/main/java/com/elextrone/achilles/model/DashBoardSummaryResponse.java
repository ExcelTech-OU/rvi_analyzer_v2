package com.elextrone.achilles.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DashBoardSummaryResponse {
    int numberOfDevices;
    int numberOfUsers;
    long numberOfSessions;
    long numberOfQuestions;

}
