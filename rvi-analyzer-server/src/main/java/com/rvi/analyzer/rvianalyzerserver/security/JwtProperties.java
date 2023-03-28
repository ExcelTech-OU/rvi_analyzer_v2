package com.rvi.analyzer.rvianalyzerserver.security;

import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@ConfigurationProperties(prefix = "jwt")
@Configuration
@Getter
@Setter
public class JwtProperties {
    private String secretKey = "rviAnalyzerJwtsskey";
    private long validityInMs = 3600000; // 1h
}
