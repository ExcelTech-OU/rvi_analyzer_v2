package com.rvi.analyzer.rvianalyzerserver.service;

import com.rvi.analyzer.rvianalyzerserver.domain.*;
import com.rvi.analyzer.rvianalyzerserver.dto.UserDto;
import com.rvi.analyzer.rvianalyzerserver.entiy.User;
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
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

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
                .flatMap(userRepository::findByUsername)
                .map(userMapper::userToUserDto);
    }

    public Mono<User> getUser(String username) {
        return Mono.just(username)
                .doOnNext(s -> log.info("Finding user by userName [{}]", s))
                .flatMap(userRepository::findByUsername);
    }

    public Mono<List<String>> getUsersByAdmin(String username) {
        return Mono.just(username)
                .doOnNext(s -> log.info("Finding users by userName [{}]", s))
                .flatMapMany(userRepository::findByCreatedBy)
                .collectList()
                .map(users -> users.stream().map(user -> user.getUsername()).collect(Collectors.toList()));
    }

    public Mono<NewUserResponse> addUser(UserDto userDto, String jwt) {
        return Mono.just(userDto)
                .doOnNext(userDto1 -> log.info("User add request received [{}]", userDto))
                .flatMap(request -> userRepository.findByUsername(request.getUsername()))
                .flatMap(user -> Mono.just(NewUserResponse.builder()
                        .status("E1002")
                        .statusDescription("User Already exists")
                        .build()))
                .switchIfEmpty(
                        createUser(userDto, jwtUtils.getUsername(jwt))
                )
                .doOnError(e ->
                        NewUserResponse.builder()
                                .status("E1000")
                                .statusDescription("Failed")
                                .build());
    }

    private Mono<NewUserResponse> createUser(UserDto userDto, String username) {
        return userRepository.findByUsername(username)
                .flatMap(creatingUser -> userGroupRoleService.getUserRolesByUserGroup(creatingUser.getGroup())
                        .flatMap(userRoles -> {
                            log.info(userDto.getGroup());
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
                        .userName(user.getUsername())
                        .build());
    }

    public Mono<ResponseEntity<LoginResponse>> login(LoginRequest loginRequest) {
        return Mono.just(loginRequest)
                .doOnNext(request -> log.info("Login request received [{}]", request.getUserName()))
                .flatMap(request -> userRepository.findByUsername(request.getUserName()))
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
                                                            .roles(roles)
                                                            .state("S1000")
                                                            .stateDescription("Success").build()));
                                                } else if (loginRequest.getSource().equals("MOBILE") && roles.contains(UserRoles.LOGIN_APP)) {
                                                    return Mono.just(ResponseEntity.ok(LoginResponse.builder()
                                                            .user(userMapper.userToUserDto(user))
                                                            .jwt(jwtUtils.createToken(user))
                                                            .roles(roles)
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

    public Mono<ResponseEntity<CommonResponse>> resetPassword(String userName, String auth) {
        return userRepository.findByUsername(jwtUtils.getUsername(auth))
                .flatMap(requestedUser -> userGroupRoleService.getUserRolesByUserGroup(requestedUser.getGroup())
                        .flatMap(userRoles -> {
                            if (userRoles.contains(UserRoles.RESET_PASSWORD)) {
                                return userRepository.findByUsername(userName)
                                        .flatMap(user -> {
                                            user.setPasswordType("RESET");
                                            user.setPassword(encoder.encode("default@rvi"));
                                            return userRepository.save(user)
                                                    .flatMap(user1 -> Mono.just(
                                                            ResponseEntity.ok(CommonResponse.builder()
                                                                    .status("S1000")
                                                                    .statusDescription("Success").build(
                                                                    )
                                                            )));
                                        })
                                        .switchIfEmpty(Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(CommonResponse.builder()
                                                .status("E1000")
                                                .statusDescription("Failed").build())));
                            } else {
                                return Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(CommonResponse.builder()
                                        .status("E1200")
                                        .statusDescription("You are not authorized to use this service").build()));
                            }
                        })
                )
                .switchIfEmpty(Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(CommonResponse.builder()
                        .status("E1000")
                        .statusDescription("Failed").build())));
    }

    public Mono<ResponseEntity<CommonResponse>> resetPassword(String auth, PasswordResetRequest request) {
        return userRepository.findByUsername(jwtUtils.getUsername(auth))
                .flatMap(user -> {
                    if (user.getPasswordType().equals("DEFAULT") || user.getPasswordType().equals("RESET")) {
                        user.setPasswordType("PASSWORD");
                        user.setPassword(encoder.encode(request.getPassword()));
                        return userRepository.save(user)
                                .flatMap(user1 -> Mono.just(
                                        ResponseEntity.ok(CommonResponse.builder()
                                                .status("S1000")
                                                .statusDescription("Success").build(
                                                )
                                        )));
                    } else {
                        return Mono.just(ResponseEntity.ok(CommonResponse.builder()
                                .status("E1030")
                                .statusDescription("You didn't have requested password reset").build()));
                    }
                })
                .switchIfEmpty(Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(CommonResponse.builder()
                        .status("E1000")
                        .statusDescription("Failed").build())));
    }

    public Mono<ResponseEntity<GetUserNamesResponse>> getUserNames(GetUserNamesRequest request) {
        log.info("Get usernames req received with pattern [{}]", request.getPattern());
        return userRepository.findByUserNamePattern(request.getPattern())
                .collectList()
                .flatMap(users -> Mono.just(ResponseEntity.ok(GetUserNamesResponse.builder()
                        .status("S1000")
                        .statusDescription("Success")
                        .usernames(users.stream().map(User::getUsername).toList())
                        .build()
                )));
    }

    public Mono<Long> getUserCountByUserName(String username) {
        return userRepository.findByCreatedBy(username)
                .collectList()
                .flatMap(users -> userRepository.countUsersByUsername(username));
    }

    public Mono<ResponseEntity<UsersResponse>> getUsers(String auth) {
        log.info("get users request received with jwt [{}]", auth);

        return userRepository.findByUsername(jwtUtils.getUsername(auth))
                .flatMap(requestedUser -> userGroupRoleService.getUserRolesByUserGroup(requestedUser.getGroup())
                        .flatMap(userRoles -> {
                            if (userRoles.contains(UserRoles.GET_USERS)) {
                                return userRepository.findByCreatedBy(requestedUser.getUsername())
                                        .map(userMapper::userToUserDto)
                                        .collectList()
                                        .flatMap(userDtos -> Mono.just(ResponseEntity.ok(UsersResponse.builder()
                                                .status("S1000")
                                                .statusDescription("Success")
                                                .users(userDtos)
                                                .build()
                                        )));
                            } else if (userRoles.contains(UserRoles.GET_ALL_USERS)) {
                                return userRepository.findAll()
                                        .map(userMapper::userToUserDto)
                                        .collectList()
                                        .flatMap(userDtos -> Mono.just(ResponseEntity.ok(UsersResponse.builder()
                                                .status("S1000")
                                                .statusDescription("Success")
                                                .users(userDtos)
                                                .build()
                                        )));
                            } else {
                                return Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(UsersResponse.builder()
                                        .status("E1200")
                                        .statusDescription("You are not authorized to use this service").build()));
                            }
                        })
                )
                .switchIfEmpty(Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(UsersResponse.builder()
                        .status("E1000")
                        .statusDescription("Failed").build())));
    }

    public Mono<ResponseEntity<CommonResponse>> updateUser(UserUpdateRequest request, String auth) {
        log.info("update user request received  [{}] ", request);

        return userRepository.findByUsername(jwtUtils.getUsername(auth))
                .flatMap(requestedUser -> userGroupRoleService.getUserRolesByUserGroup(requestedUser.getGroup())
                        .flatMap(userRoles -> userRepository.findByUsername(request.getUsername())
                                .flatMap(user -> {
                                    if (user.getGroup().equals("USER") && userRoles.contains(UserRoles.UPDATE_USER)) {
                                        user.setStatus(request.getStatus());
                                        return userRepository.save(user)
                                                .flatMap(userDtos -> Mono.just(ResponseEntity.ok(CommonResponse.success()
                                                )))
                                                .switchIfEmpty(Mono.just(ResponseEntity.ok(CommonResponse.fail())));
                                    } else if ((user.getGroup().equals("ADMIN") || user.getGroup().equals("TOP_ADMIN"))
                                            && userRoles.contains(UserRoles.UPDATE_ADMIN_USER)) {
                                        user.setStatus(request.getStatus());
                                        return userRepository.save(user)
                                                .flatMap(userDtos -> Mono.just(ResponseEntity.ok(CommonResponse.success()
                                                )))
                                                .switchIfEmpty(Mono.just(ResponseEntity.ok(CommonResponse.fail())));
                                    } else {
                                        return Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(CommonResponse.builder()
                                                .status("E1200")
                                                .statusDescription("You are not authorized to use this service").build()));
                                    }
                                })
                                .switchIfEmpty(Mono.just(ResponseEntity.ok(CommonResponse.fail()))))
                )
                .switchIfEmpty(Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(CommonResponse.builder()
                        .status("E1000")
                        .statusDescription("Failed").build())));
    }

    public Mono<ResponseEntity<UserRolesResponse>> getUserRoles(String auth) {
        return Mono.just(jwtUtils.getUsername(auth))
                .doOnNext(request -> log.info("User Roles request received for user [{}]", request))
                .flatMap(userRepository::findByUsername)
                .filter(Objects::nonNull)
                .flatMap(user ->
                        {
                            if (user.getPasswordType().equals("DEFAULT") || user.getPasswordType().equals("RESET")) {
                                return Mono.just(
                                        ResponseEntity.ok(UserRolesResponse.builder()
                                                .user(userMapper.userToUserDto(user))
                                                .status("S1010")
                                                .statusDescription("Password Reset Needed").build())
                                );
                            } else {
                                return userGroupRoleService.getUserRolesByUserGroup(user.getGroup())
                                        .flatMap(roles -> {
                                            log.info("user roles [{}] user group [{}]", roles, user.getGroup());
                                            return Mono.just(ResponseEntity.ok(UserRolesResponse.builder()
                                                    .user(userMapper.userToUserDto(user))
                                                    .roles(roles)
                                                    .status("S1000")
                                                    .statusDescription("Success").build()));

                                        });
                            }
                        }
                )
                .switchIfEmpty(Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(UserRolesResponse.builder()
                        .status("E1000")
                        .statusDescription("Login Failed").build())));
    }

    public Mono<ResponseEntity<CommonResponse>> checkJwt(String auth) {
        return userRepository.findByUsername(jwtUtils.getUsername(auth))
                .flatMap(user -> {
                    if (user.getPasswordType().equals("DEFAULT") || user.getPasswordType().equals("RESET")) {
                        return Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(CommonResponse.builder()
                                .status("E1000")
                                .statusDescription("Failed").build()));
                    } else {
                        return Mono.just(
                                ResponseEntity.ok(CommonResponse.builder()
                                        .status("S1000")
                                        .statusDescription("Success").build(
                                        )
                                ));
                    }
                })
                .switchIfEmpty(Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(CommonResponse.builder()
                        .status("E1000")
                        .statusDescription("Failed").build())));
    }
}
