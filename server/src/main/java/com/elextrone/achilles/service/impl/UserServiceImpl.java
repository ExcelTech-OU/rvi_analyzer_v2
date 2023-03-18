package com.elextrone.achilles.service.impl;

import com.elextrone.achilles.auth.JWTUtil;
import com.elextrone.achilles.auth.PBKDF2Encoder;
import com.elextrone.achilles.model.*;
import com.elextrone.achilles.model.auth.*;
import com.elextrone.achilles.repo.*;
import com.elextrone.achilles.repo.entity.*;
import com.elextrone.achilles.repo.utill.DeviceStatus;
import com.elextrone.achilles.service.DeviceService;
import com.elextrone.achilles.service.EmailService;
import com.elextrone.achilles.service.UserService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Mono;

import javax.swing.text.html.Option;
import javax.transaction.Transactional;
import java.util.*;
import java.util.concurrent.ThreadLocalRandom;

@Service
@AllArgsConstructor
@Slf4j
public class UserServiceImpl implements UserService {

    private UserRepository userRepository;
    private DeviceRepository deviceRepository;
    private AnswerRepository answerRepository;
    private UserTreatmentSessionRepository userTreatmentSessionRepository;
    private UserTreatmentAnsweringSessionRepository userTreatmentAnsweringSessionRepository;
    private QuestionRepository questionRepository;
    private DeviceService deviceService;
    private EmailService emailService;
    private PBKDF2Encoder passwordEncoder;
    private JWTUtil jwtUtil;

    @Override
    public Mono<ResponseEntity<AuthResponse>> findByUsername(AuthRequest ar) {
        User user = userRepository.findByUsername(ar.getUsername());
        if (user != null) {
            if (passwordEncoder.encode(ar.getPassword()).equals(user.getPassword())) {
                if (user.isEnabled()) {
                    return Mono.just(ResponseEntity.ok(new AuthResponse("S1000", "success",
                            SimpleUser.builder()
                                    .username(user.getUsername())
                                    .name(user.getName())
                                    .email(user.getEmail())
                                    .build(), jwtUtil.generateToken(user))));
                } else {
                    return Mono.just(ResponseEntity.ok(new AuthResponse("E1005", "User Disabled",
                            SimpleUser.builder()
                                    .username(user.getUsername())
                                    .name(user.getName())
                                    .email(user.getEmail())
                                    .build(), jwtUtil.generateToken(user))));
                }
            } else {
                return Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).build());
            }
        } else {
            return Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).build());
        }
    }

    @Override
    public Mono<ResponseEntity<AuthResponse>> findAdminByUsername(AuthRequest ar) {
        User user = userRepository.findByUsername(ar.getUsername());
        if (user != null) {
            if (passwordEncoder.encode(ar.getPassword()).equals(user.getPassword())) {
                if (user.isEnabled() && user.getRoleId() == 1) {
                    return Mono.just(ResponseEntity.ok(new AuthResponse("S1000", "success",
                            SimpleUser.builder()
                                    .username(user.getUsername())
                                    .name(user.getName())
                                    .email(user.getEmail())
                                    .build(), jwtUtil.generateToken(user))));
                } else {
                    return Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).build());
                }
            } else {
                return Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).build());
            }
        } else {
            return Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).build());
        }
    }

    @Override
    @Transactional
    public Mono<ResponseEntity<SimpleUser>> getBasicUSer(String username) {
        User user = userRepository.findByUsername(username);
        if (user != null) {
            return Mono.just(ResponseEntity.ok(SimpleUser.builder()
                    .username(user.getUsername())
                    .name(user.getName())
                    .email(user.getEmail())
                    .lastLogin(user.getLastUpdatedDate() == null ? "N/A" : user.getLastUpdatedDate().toString())
                    .age(String.valueOf(user.getAge()))
                    .gender("Male")
                    .occupation(user.getOccupation() == null ? "N/A" : user.getOccupation())
                    .build()));
        } else {
            return Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).build());
        }
    }


    @Override
    public Mono<ResponseEntity<UserRegisterResponse>> save(User user) {

        String password = passwordEncoder.encode(user.getPassword());
        user.setPassword(password);
        user.setRoleId(2);
        user.setEnabled(true);

        User oldUser = userRepository.findByUsername(user.getUsername());
        if (oldUser != null) {
            return Mono.just(ResponseEntity.ok(new UserRegisterResponse("E1000", "User already exists")));
        } else {
            userRepository.save(user);
            return Mono.just(ResponseEntity.ok(new UserRegisterResponse("S1000", "Success")));
        }
    }

    @Override
    public Mono<ResponseEntity<UserDevicesResponse>> getActiveDevices(String username) {
        User user = userRepository.findByUsername(username);

        if (user != null) {
            List<Device> devices = deviceService.getActiveDevicesByUserId(user.getId(), DeviceStatus.ACTIVE);
            return Mono.just(ResponseEntity.ok(new UserDevicesResponse("S1000", devices)));
        } else {
            return Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).build());
        }
    }

    @Override
    public Mono<ResponseEntity<ValidateResponse>> validatePassword(String username, PasswordValidateRequest ar) {
        User user = userRepository.findByUsername(username);
        if (user != null) {
            if (passwordEncoder.encode(ar.getPassword()).equals(user.getPassword())) {
                return Mono.just(ResponseEntity.ok(new ValidateResponse("S1000", "success")));
            } else {
                return Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).build());
            }
        } else {
            return Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).build());
        }
    }

    @Override
    public Mono<ResponseEntity<ValidateResponse>> validateEmail(EmailValidateRequest ar) {
        User user = userRepository.findByEmail(ar.getEmail());
        if (user != null) {
            return Mono.just(ResponseEntity.ok(new ValidateResponse("E1001", "Email already obtained")));
        } else {
            return Mono.just(ResponseEntity.ok(new ValidateResponse("S1000", "success")));
        }
    }

    @Override
    public Mono<ResponseEntity<ValidateResponse>> validateUsername(UsernameValidateRequest ar) {
        User user = userRepository.findByUsername(ar.getUsername());
        if (user != null) {
            return Mono.just(ResponseEntity.ok(new ValidateResponse("E1001", "Username already used")));
        } else {
            return Mono.just(ResponseEntity.ok(new ValidateResponse("S1000", "success")));
        }
    }

    @Override
    public Mono<ResponseEntity<PasswordResetResponse>> resetPassword(String usernameBuAuth, PasswordResetRequest ar) {
        int pin = getPin();
        User user = userRepository.findByUsername(usernameBuAuth);
        if (user != null) {
            user.setPin(pin);
            user.setPinValidated(false);
            userRepository.save(user);
            return Mono.just(ResponseEntity.ok(emailService.getResetPasswordEmail(ar.getEmail(), String.valueOf(pin))));
        } else {
            return Mono.just(ResponseEntity.ok(new PasswordResetResponse("E1002", "User not found", 0)));
        }
    }

    @Override
    public Mono<ResponseEntity<UserRegisterResponse>> saveFeedback(String username, UserFeedBackRequest feedback) {
        log.info("Received feedback request [{}] from user [{}]", feedback.toString(), username);

        User user = userRepository.findByUsername(username);
        Device device = deviceRepository.findDeviceByName(feedback.getDeviceId());

        if (user != null && device != null) {
            UserTreatmentSession userTreatmentSession = new UserTreatmentSession();
            userTreatmentSession.setUser(user);
            userTreatmentSession.setDevice(device);
            userTreatmentSession.setProtocolId(feedback.getProtocolId());
            userTreatmentSession.setSelectedPainLevel(Integer.parseInt(feedback.getPainLevel()));
            userTreatmentSession.setFeedbackPainLevel(feedback.getPainLevel());
            userTreatmentSession.setSelectedTemperature(Integer.parseInt(feedback.getTemperature()));
            userTreatmentSession.setInitialSelectedTime(Integer.parseInt(feedback.getInitialSelectedTime()));
            userTreatmentSession.setInitialBatteryLevel(Integer.parseInt(feedback.getInitialBatteryLevel()));
            userTreatmentSession.setFinalTemperature(Integer.parseInt(feedback.getFinalTemperature()));
            userTreatmentSession.setActualTreatmentTime(Integer.parseInt(feedback.getRemainingTime()));
            userTreatmentSession.setEndBatteryLevel(Integer.parseInt(feedback.getFinalBatteryLevel()));
            userTreatmentSession.setStatus(UserTreatmentSessionStatus.valueOf(feedback.getStatus()));

            UserTreatmentSession savedEntity = userTreatmentSessionRepository.save(userTreatmentSession);

            for (Map<String, String> answer : feedback.getAnswers()) {
                UserTreatmentAnsweringSession userTreatmentAnsweringSession = new UserTreatmentAnsweringSession();
                Optional<Question> question = questionRepository.findById(Long.parseLong(answer.get("id")));

                if (question.isPresent()) {
                    if (question.get().getFormFieldType().equals("dropdown")) {
                        Optional<Answer> answer1 = answerRepository.findById(Long.parseLong(answer.get("value")));
                        answer1.ifPresent(value -> userTreatmentAnsweringSession.setAnswer(value.getId()));
                    } else {
                        userTreatmentAnsweringSession.setAnswerText(answer.get("value"));
                    }
                    userTreatmentAnsweringSession.setQuestion(question.get().getId());
                    userTreatmentAnsweringSession.setSession(savedEntity);
                    userTreatmentAnsweringSessionRepository.save(userTreatmentAnsweringSession);
                }
            }
        } else {
            return Mono.just(ResponseEntity.ok(new UserRegisterResponse("E1000", "Something went wrong. Please try again")));
        }
        return Mono.just(ResponseEntity.ok(new UserRegisterResponse("S1000", "Success")));
    }

    private int getActualTime(int initialTime, int remainingTime) {
        return initialTime - remainingTime;
    }

    @Override
    public Mono<ResponseEntity<UserHistoryResponse>> getUserHistory(String username) {
        User user = userRepository.findByUsername(username);

        if (user != null) {
            List<UserTreatmentSession> lastSession = userTreatmentSessionRepository.findLatestTestResultByUserId(user.getId());

            if (lastSession.size() > 0) {
                UserTreatmentSession session = lastSession.get(lastSession.size() - 1);
                return Mono.just(ResponseEntity.ok(new UserHistoryResponse(String.valueOf(session.getFinalTemperature()),
                        session.getFeedbackPainLevel(), user.getName(), String.valueOf(session.getActualTreatmentTime()))));
            } else {
                return Mono.just(ResponseEntity.ok(new UserHistoryResponse("", "", user.getName(), "")));
            }
        } else {
            return Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).build());
        }
    }

    @Override
    public Mono<ResponseEntity<UserListResponse>> getUsers() {
        List<UserObj> users = new ArrayList<>();
        userRepository.findAll().forEach(user -> users.add(userMapper(user)));
        return Mono.just(ResponseEntity.ok(new UserListResponse(users)));
    }

    private UserObj userMapper(User user) {
        return UserObj.builder()
                .id(user.getId())
                .name(user.getName())
                .username(user.getUsername())
                .age(user.getAge())
                .occupation(user.getOccupation())
                .email(user.getEmail())
                .roleId(user.getRoleId())
                .condition(user.getCondition())
                .enabled(user.isEnabled())
                .createdDate(user.getCreatedDate())
                .lastUpdatedDate(user.getLastUpdatedDate())
                .build();
    }

    @Override
    public Mono<ResponseEntity<ValidateResponse>> updateUser(UpdateUserRequestByEmail req) {
        boolean status = req.getStatus().equals("ACTIVE");
        String email  = req.getEmail();
        String condition = req.getCondition();
        String occupation = req.getOccupation();
        int age = Integer.parseInt(req.getAge());
        userRepository.updateUser(status, occupation, condition, age, email);
        return Mono.just(ResponseEntity.ok(new ValidateResponse("S1000", "Success")));
    }

    @Override
    public Mono<ResponseEntity<AuthResponse>> validateGoogleUser(GoogleAuthRequest ar) {
        User user = userRepository.findByEmail(ar.getEmail());
        if (user != null) {
            if (passwordEncoder.encode(ar.getId()).equals(user.getPassword())) {
                if (user.isEnabled()) {
                    return Mono.just(ResponseEntity.ok(new AuthResponse("S1000", "success",
                            SimpleUser.builder()
                                    .username(user.getUsername())
                                    .name(user.getName())
                                    .email(user.getEmail())
                                    .build(), jwtUtil.generateToken(user))));
                } else {
                    return Mono.just(ResponseEntity.ok(new AuthResponse("E1005", "User Disabled",
                            SimpleUser.builder()
                                    .username(user.getUsername())
                                    .name(user.getName())
                                    .email(user.getEmail())
                                    .build(), jwtUtil.generateToken(user))));
                }
            } else {
                return Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).build());
            }
        } else {
            user = new User();
            String password = passwordEncoder.encode(ar.getId());
            user.setPassword(password);
            user.setName(ar.getName());
            user.setEmail(ar.getEmail());
            user.setUsername(ar.getEmail());
            user.setAge(0);
            user.setCondition("");
            user.setOccupation("");
            user.setRoleId(2);
            user.setEnabled(true);
            userRepository.save(user);
            return Mono.just(ResponseEntity.ok(new AuthResponse("S1000", "success",
                    SimpleUser.builder()
                            .username(user.getUsername())
                            .name(user.getName())
                            .email(user.getEmail())
                            .build(), jwtUtil.generateToken(user))));
        }
    }

    @Override
    public Mono<ResponseEntity<ViewSessionsResponse>> getUserSessions(String type, String id) {
        List<UserTreatmentSession> sessions;
        if (id.equals("all")) {
            sessions = new ArrayList<>();
            userTreatmentSessionRepository.findAll().forEach(sessions::add);
        } else {
            if (Objects.equals(type, "sp")) {
                sessions = new ArrayList<>(userTreatmentSessionRepository.findAllSessionsByUserId(Long.parseLong(id)));
            } else {
                sessions = new ArrayList<>(userTreatmentSessionRepository.findAllSessionsByDeviceId(Long.parseLong(id)));
            }
        }
        return Mono.just(ResponseEntity.ok(new ViewSessionsResponse(sessions)));
    }

    @Override
    public Mono<ResponseEntity<UserSessionFeedBackResponse>> getUserSessionQuestionBySessionId(GetFeedBackUsingSessionIDRequest req) {
        Optional<UserTreatmentSession> session = userTreatmentSessionRepository.findById(Long.parseLong(req.getSessionId()));
        Map<String, String> questionAnswers = new HashMap<>();
        if (session.isPresent()) {
            List<UserTreatmentAnsweringSession> userTreatmentAnsweringSessions =
                    userTreatmentAnsweringSessionRepository.findUTASBySessionId(session.get().getId());
            for (UserTreatmentAnsweringSession userSession: userTreatmentAnsweringSessions) {
                Optional<Question> question = questionRepository.findById(userSession.getQuestion());
                if (!(userSession.getAnswer() == 0)) {
                    Optional<Answer> answer =  answerRepository.findById(userSession.getAnswer());
                    questionAnswers.putIfAbsent(question.get().getQuestion(), answer.get().getAnswer());
                } else {
                    questionAnswers.putIfAbsent(question.get().getQuestion(), userSession.getAnswerText());
                }
            }
        }
        return Mono.just(ResponseEntity.ok(new UserSessionFeedBackResponse(questionAnswers)));
    }


    private int getPin() {
        return ThreadLocalRandom.current().nextInt(0, 999999);
    }

}
