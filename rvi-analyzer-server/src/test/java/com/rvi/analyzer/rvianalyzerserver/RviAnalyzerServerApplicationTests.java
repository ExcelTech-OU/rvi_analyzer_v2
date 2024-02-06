package com.rvi.analyzer.rvianalyzerserver;

import com.rvi.analyzer.rvianalyzerserver.dto.PlantDto;
import com.rvi.analyzer.rvianalyzerserver.entiy.Customer;
import com.rvi.analyzer.rvianalyzerserver.repository.DeviceRepository;
import com.rvi.analyzer.rvianalyzerserver.service.CustomerService;
import com.rvi.analyzer.rvianalyzerserver.service.MaterialService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class RviAnalyzerServerApplicationTests {
    @Autowired
    private DeviceRepository deviceRepository;

//    @Test
//    void display() {
//        customerService.savePlant("Plant 10", "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ0b3BBZG1pbkBnbWFpbC5jb20iLCJyb2xlcyI6IltUT1BfQURNSU5dIiwiaWF0IjoxNzA0ODY2ODY5LCJleHAiOjE3MDQ4NzI4Njl9.j24dVfG-H4mlEUblRl7LLm6O8hkR7KqQLW1dqi4t6qk");
//    }

//    @Test
//    void contextLoads() {
//        materialService.getMaterialExistsByName("Material 01");
//    }

}
