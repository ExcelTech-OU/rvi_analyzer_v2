package com.elextrone.achilles.service;

import com.elextrone.achilles.model.*;
import com.elextrone.achilles.model.auth.*;
import com.elextrone.achilles.repo.entity.User;
import org.springframework.http.ResponseEntity;
import reactor.core.publisher.Mono;

public interface UserService {
    Mono<ResponseEntity<AuthResponse>> findByUsername(AuthRequest ar);

    Mono<ResponseEntity<AuthResponse>> findAdminByUsername(AuthRequest ar);

    Mono<ResponseEntity<SimpleUser>> getBasicUSer(String username);

    Mono<ResponseEntity<UserRegisterResponse>> save(User user);

    Mono<ResponseEntity<UserDevicesResponse>> getActiveDevices(String username);

    Mono<ResponseEntity<ValidateResponse>> validatePassword(String username, PasswordValidateRequest ar);

    Mono<ResponseEntity<ValidateResponse>> validateEmail(EmailValidateRequest ar);

    Mono<ResponseEntity<ValidateResponse>> validateUsername(UsernameValidateRequest ar);

    Mono<ResponseEntity<PasswordResetResponse>> resetPassword(String usernameBuAuth, PasswordResetRequest ar);

    Mono<ResponseEntity<UserRegisterResponse>> saveFeedback(String username, UserFeedBackRequest feedback);

    Mono<ResponseEntity<UserHistoryResponse>> getUserHistory(String username);

    Mono<ResponseEntity<UserListResponse>> getUsers();

    Mono<ResponseEntity<ValidateResponse>> updateUser(UpdateUserRequestByEmail req);

    Mono<ResponseEntity<AuthResponse>> validateGoogleUser(GoogleAuthRequest ar);

    Mono<ResponseEntity<ViewSessionsResponse>> getUserSessions(String type, String id);

    Mono<ResponseEntity<UserSessionFeedBackResponse>> getUserSessionQuestionBySessionId(GetFeedBackUsingSessionIDRequest req);
}
