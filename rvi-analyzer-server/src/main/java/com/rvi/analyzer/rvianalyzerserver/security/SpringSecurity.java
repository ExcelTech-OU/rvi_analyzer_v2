package com.rvi.analyzer.rvianalyzerserver.security;

import com.rvi.analyzer.rvianalyzerserver.repository.UserRepository;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.ReactiveAuthenticationManager;
import org.springframework.security.authentication.UserDetailsRepositoryReactiveAuthenticationManager;
import org.springframework.security.config.annotation.web.reactive.EnableWebFluxSecurity;
import org.springframework.security.config.web.server.SecurityWebFiltersOrder;
import org.springframework.security.config.web.server.ServerHttpSecurity;
import org.springframework.security.core.userdetails.ReactiveUserDetailsService;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.server.SecurityWebFilterChain;
import org.springframework.web.cors.CorsConfiguration;

import java.util.Base64;
import java.util.List;

@EnableWebFluxSecurity
@Configuration
public class SpringSecurity {
    @Bean
    public SecurityWebFilterChain securityWebFilterChain(ServerHttpSecurity http, JwtUtils jwtUtils) {

        CorsConfiguration corsConfiguration = new CorsConfiguration();
        corsConfiguration.setAllowedHeaders(List.of("Authorization", "Cache-Control", "Content-Type"));
        corsConfiguration.setAllowedOriginPatterns(List.of("*"));
        corsConfiguration.setAllowedMethods(List.of("GET", "POST", "PUT", "DELETE", "PUT","OPTIONS","PATCH", "DELETE"));
        corsConfiguration.setAllowCredentials(true);
        corsConfiguration.setExposedHeaders(List.of("Authorization"));

        return http
                .authorizeExchange()
                .pathMatchers(HttpMethod.POST, "/login/**").permitAll()
                .pathMatchers(HttpMethod.POST, "/register/**").permitAll()
                .anyExchange().authenticated()
                .and()
                .addFilterAt(new JwtAuthenticationFilter(jwtUtils), SecurityWebFiltersOrder.AUTHENTICATION)
                .csrf().disable()
                .httpBasic().disable()
                .formLogin().disable()
                .cors().configurationSource(request -> corsConfiguration).and()
                .build();
    }

    @Bean
    public ReactiveAuthenticationManager reactiveAuthenticationManager(ReactiveUserDetailsService userDetailsService, PasswordEncoder encoder) {
        UserDetailsRepositoryReactiveAuthenticationManager authenticationManager = new UserDetailsRepositoryReactiveAuthenticationManager(userDetailsService);

        authenticationManager.setPasswordEncoder(encoder);
        return authenticationManager;
    }

    @Bean
    public ReactiveUserDetailsService userDetailsService(UserRepository users) {
        return (username) -> users.findByUserName(username)
                .map(u -> User.withUsername(u.getUserName())
                        .password(u.getPassword())
                        .authorities(List.of(u.getType()).toArray(new String[0]))
                        .accountExpired(false)
                        .credentialsExpired(false)
                        .disabled(!u.getStatus().equals("ACTIVE"))
                        .accountLocked(false)
                        .build()
                );
    }
}
