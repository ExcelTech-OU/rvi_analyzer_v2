package com.elextrone.achilles.model;

import com.elextrone.achilles.repo.entity.Answer;
import com.elextrone.achilles.repo.entity.Question;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class QuestionResponse {
    private Question question;
    private List<Answer> answers;
}
