package com.rvi.analyzer.rvianalyzerserver;

import jakarta.annotation.PostConstruct;
import jakarta.annotation.PreDestroy;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.reactive.ReactiveUserDetailsServiceAutoConfiguration;
import org.springframework.data.mongodb.config.EnableMongoAuditing;

@SpringBootApplication
@EnableMongoAuditing
@Slf4j
public class RviAnalyzerServerApplication {

	@PostConstruct
	public void init(){
		log.info("Server started");
	}

	@PreDestroy
	public void destroy(){
		log.info("Server stopped");
	}

	public static void main(String[] args) {
		SpringApplication.run(RviAnalyzerServerApplication.class, args);
	}

}
