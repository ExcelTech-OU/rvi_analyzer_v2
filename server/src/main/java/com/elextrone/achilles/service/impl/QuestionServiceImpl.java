package com.elextrone.achilles.service.impl;

import com.elextrone.achilles.model.QuestionListResponseAdmin;
import com.elextrone.achilles.model.QuestionResponse;
import com.elextrone.achilles.model.UpdateQuestionRequest;
import com.elextrone.achilles.model.auth.ValidateResponse;
import com.elextrone.achilles.repo.AnswerRepository;
import com.elextrone.achilles.repo.QuestionRepository;
import com.elextrone.achilles.repo.entity.Question;
import com.elextrone.achilles.service.QuestionService;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Mono;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;


@Service
@AllArgsConstructor
public class QuestionServiceImpl implements QuestionService {

            @Autowired
            private QuestionRepository questionRepository;

    @Autowired
    private AnswerRepository answerRepository;

    @Override
    public Mono<ResponseEntity<List<QuestionResponse>>> getQuestions() {
        List<QuestionResponse> questionResponses = new ArrayList<>();

        List<Question> questions = questionRepository.findQuestions(true);
        if (!questions.isEmpty()) {
            for (Question q : questions
            ) {
                questionResponses.add(questions.indexOf(q), new QuestionResponse(q, answerRepository.findAnswers(q.getId())));
            }
        }
        return Mono.just(ResponseEntity.ok(questionResponses));
    }

    @Override
    public Mono<ResponseEntity<ValidateResponse>> updateQuestion(UpdateQuestionRequest req) {
        Long id = Long.parseLong(req.getId());
        Optional<Question> questions = questionRepository.findById(id);
        if (questions.isPresent()) {
            boolean status = req.getStatus().equals("ACTIVE");
            questionRepository.updateQuestion(id, req.getQuestion(), status);
        }
        return Mono.just(ResponseEntity.ok(new ValidateResponse("S1000", "Success")));
    }

    @Override
    public Mono<ResponseEntity<QuestionListResponseAdmin>> getQuestionsAdmin() {
        List<QuestionResponse> questionResponses = new ArrayList<>();

        List<Question> questions = new ArrayList<>();
        questionRepository.findAll().forEach(questions::add);

        if (!questions.isEmpty()) {
            for (Question q : questions
            ) {
                questionResponses.add(questions.indexOf(q), new QuestionResponse(q, answerRepository.findAnswers(q.getId())));
            }
        }
        return Mono.just(ResponseEntity.ok(new QuestionListResponseAdmin(questionResponses)));
    }
}
