package com.rvi.analyzer.rvianalyzerserver;

import io.r2dbc.spi.ConnectionFactory;
import jakarta.annotation.PostConstruct;
import jakarta.annotation.PreDestroy;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.core.io.ClassPathResource;
import org.springframework.data.r2dbc.repository.config.EnableR2dbcRepositories;
import org.springframework.r2dbc.connection.init.ConnectionFactoryInitializer;
import org.springframework.r2dbc.connection.init.ResourceDatabasePopulator;

@SpringBootApplication
//@EnableMongoAuditing
@EnableR2dbcRepositories
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

    @Bean
    ConnectionFactoryInitializer initializer(ConnectionFactory connectionFactory) {

        ConnectionFactoryInitializer initializer = new ConnectionFactoryInitializer();
        initializer.setConnectionFactory(connectionFactory);
        initializer.setDatabasePopulator(new ResourceDatabasePopulator(new ClassPathResource("schema.sql")));

        return initializer;
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
