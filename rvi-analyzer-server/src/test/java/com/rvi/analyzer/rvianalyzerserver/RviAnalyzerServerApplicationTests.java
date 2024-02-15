package com.rvi.analyzer.rvianalyzerserver;

import com.rvi.analyzer.rvianalyzerserver.entiy.User;
import com.rvi.analyzer.rvianalyzerserver.repository.UserRepository;
import com.rvi.analyzer.rvianalyzerserver.service.UserService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

@SpringBootTest
class RviAnalyzerServerApplicationTests {
    @Autowired
    private UserRepository userRepository;

    @Autowired
    private UserService userService;

    //User.builder()
//        .username("topAdmin@gmail.com")
//                .lastUpdatedDateTime(LocalDateTime.now())
//            .createdDateTime(LocalDateTime.now())
//            .createdBy("SUPER_ADMIN")
//                .password("password")
//                .userGroup("TOP_ADMIN")
//                .status("ACTIVE")
//                .supervisor("EMPTY")
//                .passwordType("DEFAULT")
//                .build()
    @Transactional
    @Test
    void display() {
        User user = User.builder()
                .username("topAdmin@gmail.com")
                .lastUpdatedDateTime(LocalDateTime.now())
                .createdDateTime(LocalDateTime.now())
                .createdBy("SUPER_ADMIN")
                .password("password")
                .userGroup("TOP_ADMIN")
                .status("ACTIVE")
                .supervisor("EMPTY")
                .passwordType("DEFAULT")
                .build();

        userRepository.save(user)
                .subscribe(); // Ensure the save operation completes within the transaction
    }

//    @Test
//    void contextLoads() {
//        materialService.getMaterialExistsByName("Material 01");
//    }

}
