package com.elextrone.achilles.service;

import com.elextrone.achilles.model.PasswordResetResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Component;

@Component
public class EmailServiceImpl implements EmailService {

    @Autowired
    private JavaMailSender javaMailSender;

    @Override
    public PasswordResetResponse getResetPasswordEmail(String email, String pin) {

        SimpleMailMessage msg = new SimpleMailMessage();
        msg.setTo(email);

        msg.setSubject("Reset password");
        msg.setText("Your code is :  " + pin);

        javaMailSender.send(msg);

        return new PasswordResetResponse("S1000","Success", Integer.parseInt(pin));
    }
}
