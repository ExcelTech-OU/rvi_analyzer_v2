package com.rvi.analyzer.rvianalyzerserver.service;

import com.rvi.analyzer.rvianalyzerserver.domain.LoginRequest;
import com.rvi.analyzer.rvianalyzerserver.domain.LoginResponse;
import com.rvi.analyzer.rvianalyzerserver.domain.NewUserResponse;
import com.rvi.analyzer.rvianalyzerserver.dto.UserDto;
import com.rvi.analyzer.rvianalyzerserver.mappers.UserMapper;
import com.rvi.analyzer.rvianalyzerserver.repository.UserRepository;
import com.rvi.analyzer.rvianalyzerserver.security.JwtUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Mono;

import java.time.LocalDateTime;
import java.util.Objects;

@Service
@RequiredArgsConstructor
@Slf4j
public class UserService {

    final private UserRepository userRepository;
    final private UserMapper userMapper;

    final private JwtUtils jwtUtils;

    final private PasswordEncoder encoder;

    public Mono<UserDto> getUserByUsername(String username) {
        return Mono.just(username)
                .doOnNext(uName -> log.info("Finding user for username [{}]", uName))
                .flatMap(userRepository::findByUserName)
                .map(userMapper::userToUserDto);
    }

    public Mono<NewUserResponse> addAdmin(UserDto userDto) {
        return Mono.just(userDto)
                .doOnNext(userDto1 -> log.info("Admin add request received [{}]", userDto))
                .flatMap(request -> userRepository.findByUserName(request.getUserName()))
                .flatMap(user -> Mono.just(NewUserResponse.builder()
                        .status("E1002")
                        .statusDescription("User Already exists")
                        .build()))
                .switchIfEmpty(addAdminUser(userDto))
                .doOnError(e ->
                        NewUserResponse.builder()
                                .status("E1000")
                                .statusDescription("Failed")
                                .build());

    }

    private Mono<NewUserResponse> addAdminUser(UserDto userDto) {
        return Mono.just(userDto)
                .map(userMapper::userDtoToUser)
                .doOnNext(user -> {
                    user.setType("ROLE_ADMIN");
                    user.setStatus("ACTIVE");
                    user.setCreatedDateTime(LocalDateTime.now());
                    user.setLastUpdatedDateTime(LocalDateTime.now());
                    user.setPassword(encoder.encode("password"));
                })
                .flatMap(userRepository::insert)
                .doOnSuccess(user -> log.info("Successfully saved the user [{}]", user))
                .map(user -> NewUserResponse.builder()
                        .status("S1000")
                        .statusDescription("Success")
                        .userName(user.getUserName())
                        .build());
    }

    public Mono<ResponseEntity<LoginResponse>> login(LoginRequest loginRequest, String userType) {
        return Mono.just(loginRequest)
                .doOnNext(request -> log.info("Login request received [{}]", request.getUserName()))
                .flatMap(request -> userRepository.findByUserName(request.getUserName()))
                .filter(user -> user != null && Objects.equals(encoder.encode(loginRequest.getPassword()), user.getPassword())
                        && user.getType().equals(userType))
                .flatMap(user -> Mono.just(ResponseEntity.ok(LoginResponse.builder()
                        .user(userMapper.userToUserDto(user))
                        .jwt(jwtUtils.createToken(user))
                        .state("S1000")
                        .stateDescription("Success").build()))
                )
                .switchIfEmpty(Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(LoginResponse.builder()
                        .state("E1000")
                        .stateDescription("Login Failed").build())));
    }
}
