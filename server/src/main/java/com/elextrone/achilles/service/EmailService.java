package com.elextrone.achilles.service;

import com.elextrone.achilles.model.PasswordResetResponse;

public interface EmailService {
    PasswordResetResponse getResetPasswordEmail(String email, String pin);
}
