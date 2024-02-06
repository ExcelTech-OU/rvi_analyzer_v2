package com.rvi.analyzer.rvianalyzerserver;

import jakarta.annotation.PostConstruct;
import jakarta.annotation.PreDestroy;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.reactive.ReactiveUserDetailsServiceAutoConfiguration;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.mongodb.config.EnableMongoAuditing;

@SpringBootApplication
@EnableMongoAuditing
@ComponentScan(basePackages = "com.rvi.analyzer.rvianalyzerserver")
@Slf4j
public class RviAnalyzerServerApplication {

    public static void main(String[] args) {
        try {
            SpringApplication.run(RviAnalyzerServerApplication.class, args);
        } catch (Exception e) {
            System.out.println("SpringApplication : " + e.toString());
        }

    }

    @PostConstruct
    public void init() {
        log.info("Server started");
    }

    @PreDestroy
    public void destroy() {
        log.info("Server stopped");
    }

}
