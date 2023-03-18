package com.elextrone.achilles.repo.entity;

import lombok.*;

import javax.persistence.*;
import java.util.AbstractCollection;
import java.util.Date;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Entity(name = "user_treatment_answering_session")
public class UserTreatmentAnsweringSession {

    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    private Long id;
    @ManyToOne
    @JoinColumn(name="session_id", nullable=false)
    private UserTreatmentSession session;

    @Column(name = "question_id")
    private long question;

    @Column(name = "answer_id")
    private long answer;

    @Column(name = "answer")
    private String answerText;

    @Column(name = "created_date")
    private Date createdDate;

    @PrePersist
    protected void onCreate() {
        createdDate = new Date();
    }

}


