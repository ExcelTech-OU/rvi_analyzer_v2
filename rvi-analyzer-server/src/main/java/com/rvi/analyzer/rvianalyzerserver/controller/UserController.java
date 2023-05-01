package com.rvi.analyzer.rvianalyzerserver.controller;

import com.rvi.analyzer.rvianalyzerserver.domain.*;
import com.rvi.analyzer.rvianalyzerserver.dto.UserDto;
import com.rvi.analyzer.rvianalyzerserver.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Mono;

@RestController
@RequiredArgsConstructor
public class UserController {

    final private UserService userService;

    @PostMapping(path = "/register/user")
    public Mono<NewUserResponse> addUser(@RequestBody UserDto userDto, @RequestHeader("Authorization") String auth) {
        return userService.addUser(userDto, auth);
    }

    @PostMapping(path = "/login/user")
    public Mono<ResponseEntity<LoginResponse>> loginUser(@RequestBody LoginRequest loginRequest) {
        return userService.login(loginRequest);
    }

    @GetMapping(path = "/rvi/analyzer/v1/user/resetPassword/{userName}")
    public Mono<ResponseEntity<CommonResponse>> resetPassword(@PathVariable String userName, @RequestHeader("Authorization") String auth) {
        return userService.resetPassword(userName, auth);
    }

    @PostMapping(path = "/rvi/analyzer/v1/user/resetPassword")
    public Mono<ResponseEntity<CommonResponse>> resetPasswordUser(@RequestBody PasswordResetRequest request, @RequestHeader("Authorization") String auth) {
        return userService.resetPassword(auth, request);
    }

    @GetMapping(path = "/rvi/analyzer/v1/user/{userName}")
    public Mono<UserDto> getUserInfo(@PathVariable String userName) {
        return userService.getUserByUsername(userName);
    }
}
