package com.elextrone.achilles.service;

import com.elextrone.achilles.model.QuestionListResponseAdmin;
import com.elextrone.achilles.model.QuestionResponse;
import com.elextrone.achilles.model.UpdateQuestionRequest;
import com.elextrone.achilles.model.auth.ValidateResponse;
import org.springframework.http.ResponseEntity;
import reactor.core.publisher.Mono;

import java.util.List;

public interface QuestionService {
    Mono<ResponseEntity<List<QuestionResponse>>> getQuestions();

    Mono<ResponseEntity<ValidateResponse>> updateQuestion(UpdateQuestionRequest req);

    Mono<ResponseEntity<QuestionListResponseAdmin>> getQuestionsAdmin();
}
