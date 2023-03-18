package com.elextrone.achilles;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.context.event.EventListener;

import javax.annotation.PreDestroy;

@SpringBootApplication
public class AchillesApplication {
	private static final Logger logger = LoggerFactory.getLogger(AchillesApplication.class);

	@EventListener
	void onApplicationEvent(ContextRefreshedEvent event){
		System.out.println("Server started");
		logger.debug("Server started");
	}

	@PreDestroy
	void onDestroy(){
		System.out.println("Server stopped");
		logger.debug("Server stopped");
	}

	public static void main(String[] args) {
		SpringApplication.run(AchillesApplication.class, args);
	}

}
