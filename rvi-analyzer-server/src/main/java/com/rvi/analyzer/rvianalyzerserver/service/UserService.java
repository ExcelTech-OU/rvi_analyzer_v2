package com.rvi.analyzer.rvianalyzerserver.service;

import com.rvi.analyzer.rvianalyzerserver.domain.LoginRequest;
import com.rvi.analyzer.rvianalyzerserver.domain.LoginResponse;
import com.rvi.analyzer.rvianalyzerserver.domain.NewUserResponse;
import com.rvi.analyzer.rvianalyzerserver.domain.UserRoles;
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

    final private UserGroupRoleService userGroupRoleService;

    public Mono<UserDto> getUserByUsername(String username) {
        return Mono.just(username)
                .doOnNext(uName -> log.info("Finding user for username [{}]", uName))
                .flatMap(userRepository::findByUserName)
                .map(userMapper::userToUserDto);
    }

    public Mono<NewUserResponse> addUser(UserDto userDto, String jwt) {
        return Mono.just(userDto)
                .doOnNext(userDto1 -> log.info("User add request received [{}]", userDto))
                .flatMap(request -> userRepository.findByUserName(request.getUserName()))
                .flatMap(user -> Mono.just(NewUserResponse.builder()
                        .status("E1002")
                        .statusDescription("User Already exists")
                        .build()))
                .switchIfEmpty(createUser(userDto, jwtUtils.getUsername(jwt)))
                .doOnError(e ->
                        NewUserResponse.builder()
                                .status("E1000")
                                .statusDescription("Failed")
                                .build());

    }

    private Mono<NewUserResponse> createUser(UserDto userDto, String username) {
        return userRepository.findByUserName(username)
                .flatMap(creatingUser -> userGroupRoleService.getUserRolesByUserGroup(creatingUser.getGroup())
                        .flatMap(userRoles -> {
                            if (userDto.getGroup().equals("TOP_ADMIN") && userRoles.contains(UserRoles.CREATE_TOP_ADMIN)) {
                                return save(userDto, username);
                            } else if (userDto.getGroup().equals("ADMIN") && userRoles.contains(UserRoles.CREATE_ADMIN)) {
                                return save(userDto, username);
                            } else if (userDto.getGroup().equals("USER") && userRoles.contains(UserRoles.CREATE_USER)) {
                                return save(userDto, username);
                            } else {
                                return Mono.just(NewUserResponse.builder()
                                        .status("E1200")
                                        .statusDescription("You are not authorized to use this service").build());
                            }
                        }));
    }

    private Mono<NewUserResponse> save(UserDto userDto, String username) {
        return Mono.just(userDto)
                .map(userMapper::userDtoToUser)
                .doOnNext(user -> {
                    user.setGroup(userDto.getGroup());
                    user.setStatus(userDto.getStatus());
                    user.setCreatedBy(username);
                    user.setCreatedDateTime(LocalDateTime.now());
                    user.setLastUpdatedDateTime(LocalDateTime.now());
                    user.setPassword(encoder.encode("default@rvi"));
                    user.setPasswordType("DEFAULT");
                })
                .flatMap(userRepository::insert)
                .doOnSuccess(user -> log.info("Successfully saved the user [{}]", user))
                .map(user -> NewUserResponse.builder()
                        .status("S1000")
                        .statusDescription("Success")
                        .userName(user.getUserName())
                        .build());
    }

    public Mono<ResponseEntity<LoginResponse>> login(LoginRequest loginRequest) {
        return Mono.just(loginRequest)
                .doOnNext(request -> log.info("Login request received [{}]", request.getUserName()))
                .flatMap(request -> userRepository.findByUserName(request.getUserName()))
                .filter(Objects::nonNull)
                .flatMap(user ->
                        {
                            if (user.getPasswordType().equals("DEFAULT") || user.getPasswordType().equals("RESET")) {
                                return Mono.just(
                                        ResponseEntity.ok(LoginResponse.builder()
                                                .user(userMapper.userToUserDto(user))
                                                .jwt(jwtUtils.createToken(user))
                                                .state("S1010")
                                                .stateDescription("Password Reset Needed").build())
                                );
                            } else {
                                if (Objects.equals(encoder.encode(loginRequest.getPassword()), user.getPassword())) {
                                    return userGroupRoleService.getUserRolesByUserGroup(user.getGroup())
                                            .flatMap(roles -> {
                                                log.info("user roles [{}] user group [{}]", roles, user.getGroup());
                                                if (loginRequest.getSource().equals("WEB") && roles.contains(UserRoles.LOGIN_WEB)) {
                                                    return Mono.just(ResponseEntity.ok(LoginResponse.builder()
                                                            .user(userMapper.userToUserDto(user))
                                                            .jwt(jwtUtils.createToken(user))
                                                            .state("S1000")
                                                            .stateDescription("Success").build()));
                                                } else if (loginRequest.getSource().equals("MOBILE") && roles.contains(UserRoles.LOGIN_APP)) {
                                                    return Mono.just(ResponseEntity.ok(LoginResponse.builder()
                                                            .user(userMapper.userToUserDto(user))
                                                            .jwt(jwtUtils.createToken(user))
                                                            .state("S1000")
                                                            .stateDescription("Success").build()));
                                                } else {
                                                    return Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(LoginResponse.builder()
                                                            .state("E1200")
                                                            .stateDescription("You are not authorized to use this service").build()));
                                                }
                                            });
                                } else {
                                    return Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(LoginResponse.builder()
                                            .state("E1000")
                                            .stateDescription("Login Failed").build()));
                                }
                            }
                        }
                )
                .switchIfEmpty(Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(LoginResponse.builder()
                        .state("E1000")
                        .stateDescription("Login Failed").build())));
    }
}
