package com.rvi.analyzer.rvianalyzerserver;

import com.rvi.analyzer.rvianalyzerserver.repository.DeviceRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class RviAnalyzerServerApplicationTests {
	@Autowired
	private DeviceRepository deviceRepository;

	@Test
	void contextLoads() {
		System.out.println(deviceRepository.findAll());
	}

}
