package com.elextrone.achilles.controller;

import com.elextrone.achilles.auth.JWTUtil;
import com.elextrone.achilles.model.*;
import com.elextrone.achilles.model.auth.*;
import com.elextrone.achilles.repo.entity.User;
import com.elextrone.achilles.service.QuestionService;
import com.elextrone.achilles.service.UserService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Mono;

import java.util.List;

@AllArgsConstructor
@RestController
@Slf4j
public class UserController {

    private UserService userService;
    private QuestionService questionService;
    private JWTUtil jwtUtil;

    @PostMapping("/user/login")
    public Mono<ResponseEntity<AuthResponse>> login(@RequestBody AuthRequest ar) {
        log.info("Login request received from user [{}]", ar.getUsername());
        return userService.findByUsername(ar);
    }

    @PostMapping("/user/admin/login")
    public Mono<ResponseEntity<AuthResponse>> loginAdmin(@RequestBody AuthRequest ar) {
        log.info("Admin Login request received [{}]", ar);
        return userService.findAdminByUsername(ar);
    }


    @PostMapping("/user/login/google")
    public Mono<ResponseEntity<AuthResponse>> loginWithGoogle(@RequestBody GoogleAuthRequest ar) {
        log.info("Google Login request received [{}]", ar);
        return userService.validateGoogleUser(ar);
    }

    @GetMapping("/user/details")
    public Mono<ResponseEntity<SimpleUser>> getUser(@RequestHeader("Authorization") String auth) {
        log.info("User details request received [{}]", auth);
        return userService.getBasicUSer(jwtUtil.getUsernameBuAuth(auth));
    }

    @PostMapping("/user/email/validate")
    public Mono<ResponseEntity<ValidateResponse>> emailValidate(@RequestBody EmailValidateRequest ar) {
        log.info("validate email request received [{}]", ar);
        return userService.validateEmail(ar);
    }

    @PostMapping("/user/username/validate")
    public Mono<ResponseEntity<ValidateResponse>> usernameValidate(@RequestBody UsernameValidateRequest ar) {
        log.info("validate username request received [{}]", ar);
        return userService.validateUsername(ar);
    }

    @PostMapping("/user/password/reset")
    public Mono<ResponseEntity<PasswordResetResponse>> passwordReset(@RequestHeader("Authorization") String auth, @RequestBody PasswordResetRequest ar) {
        log.info("reset password request received [{}]", ar);
        return userService.resetPassword(jwtUtil.getUsernameBuAuth(auth), ar);
    }

    @PostMapping("/user/password/validate")
    public Mono<ResponseEntity<ValidateResponse>> passwordValidate(@RequestHeader("Authorization") String auth, @RequestBody PasswordValidateRequest ar) {
        log.info("validate password request received [{}]", ar);
        return userService.validatePassword(jwtUtil.getUsernameBuAuth(auth), ar);
    }

    @PostMapping("/user/register")
    public Mono<ResponseEntity<UserRegisterResponse>> register(@RequestBody User user) {
        return userService.save(user);
    }

    @GetMapping("/user/devices")
    @PreAuthorize("hasRole('USER')")
    public Mono<ResponseEntity<UserDevicesResponse>> getDevices(@RequestHeader("Authorization") String auth) {
        return userService.getActiveDevices(jwtUtil.getUsernameBuAuth(auth));
    }

    @GetMapping("/user/history")
    @PreAuthorize("hasRole('USER')")
    public Mono<ResponseEntity<UserHistoryResponse>> getHistory(@RequestHeader("Authorization") String auth) {
        return userService.getUserHistory(jwtUtil.getUsernameBuAuth(auth));
    }

    @GetMapping("/resource/questions")
    @PreAuthorize("hasRole('USER')")
    public Mono<ResponseEntity<List<QuestionResponse>>> getQuestions(@RequestHeader("Authorization") String auth) {
        return questionService.getQuestions();
    }

    @GetMapping("/resource/admin")
    @PreAuthorize("hasRole('ADMIN')")
    public Mono<ResponseEntity<String>> admin() {
        return Mono.just(ResponseEntity.ok("Content for admin"));
    }

    @PostMapping("/user/save/feedback")
    public Mono<ResponseEntity<UserRegisterResponse>> saveFeedBack(@RequestHeader("Authorization") String auth, @RequestBody UserFeedBackRequest feedback) {
        System.out.println("feedback request : " + feedback);
        return userService.saveFeedback(jwtUtil.getUsernameBuAuth(auth), feedback);
    }

    @GetMapping("/users")
    public Mono<ResponseEntity<UserListResponse>> getUsers() {
        return userService.getUsers();
    }

    @PostMapping("/user/update")
    public Mono<ResponseEntity<ValidateResponse>> updateUserStatus(@RequestBody UpdateUserRequestByEmail req) {
        return userService.updateUser(req);
    }

    @GetMapping("/user/sessions/{type}/{id}")
    public Mono<ResponseEntity<ViewSessionsResponse>> getUserSessions(@PathVariable String type, @PathVariable String id) {
        return userService.getUserSessions(type, id);
    }

    @PostMapping("/user/sessions/feedback")
    public Mono<ResponseEntity<UserSessionFeedBackResponse>> getUserSessionQuestionBySessionId(@RequestBody GetFeedBackUsingSessionIDRequest req) {
        return userService.getUserSessionQuestionBySessionId(req);
    }
    @GetMapping("/resource/questions/admin")
    public Mono<ResponseEntity<QuestionListResponseAdmin>> getQuestionsAdmin() {
        return questionService.getQuestionsAdmin();
    }

    @PostMapping("/resource/questions/admin/update")
    public Mono<ResponseEntity<ValidateResponse>> updateQuestion(@RequestBody UpdateQuestionRequest req) {
        return questionService.updateQuestion(req);
    }

}
