package com.rvi.analyzer.rvianalyzerserver.service;

import com.rvi.analyzer.rvianalyzerserver.domain.CommonResponse;
import com.rvi.analyzer.rvianalyzerserver.domain.LoginRequest;
import com.rvi.analyzer.rvianalyzerserver.domain.LoginResponse;
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

    public Mono<UserDto> getUserByUsername(String username){
      return Mono.just(username)
              .doOnNext(uName -> log.info("Finding user for username [{}]", uName))
              .flatMap(userRepository::findByUserName)
              .map(userMapper::userToUserDto);
    }

    public Mono<CommonResponse> addAdmin(UserDto userDto) {
        return Mono.just(userDto)
                .doOnNext(userDto1 -> log.info("Admin add request received [{}]", userDto))
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
                .map(user -> CommonResponse.builder()
                        .status("S1000")
                        .statusDescription("Success")
                        .build())
                .doOnError(e ->
                        CommonResponse.builder()
                                .status("S1000")
                                .statusDescription("Success")
                                .build());

    }

    public Mono<ResponseEntity<LoginResponse>> login(LoginRequest loginRequest) {
        return Mono.just(loginRequest)
                .doOnNext(request -> log.info("Login request received [{}]", request.getUserName()))
                .flatMap(request -> userRepository.findByUserName(request.getUserName()))
                .filter(user -> user != null && Objects.equals(encoder.encode(loginRequest.getPassword()), user.getPassword()))
                .map(user -> {
                    if (user == null) {
                        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
                    } else {
                        return
                                ResponseEntity.ok(LoginResponse.builder()
                                        .user(userMapper.userToUserDto(user))
                                        .jwt(jwtUtils.createToken(user)).build());
                    }
                });
    }
}
