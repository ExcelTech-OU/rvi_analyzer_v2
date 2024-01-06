package com.rvi.analyzer.rvianalyzerserver.service;

import com.rvi.analyzer.rvianalyzerserver.domain.NewCustomerResponse;
import com.rvi.analyzer.rvianalyzerserver.domain.NewUserResponse;
import com.rvi.analyzer.rvianalyzerserver.domain.UserRoles;
import com.rvi.analyzer.rvianalyzerserver.dto.CustomerDto;
import com.rvi.analyzer.rvianalyzerserver.dto.UserDto;
import com.rvi.analyzer.rvianalyzerserver.mappers.CustomerMapper;
import com.rvi.analyzer.rvianalyzerserver.repository.CustomerRepository;
import com.rvi.analyzer.rvianalyzerserver.repository.UserRepository;
import com.rvi.analyzer.rvianalyzerserver.security.JwtUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Mono;

import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
@Slf4j
public class CustomerService {

    final CustomerRepository customerRepository;
    final private UserRepository userRepository;
    final private CustomerMapper customerMapper;
    final private JwtUtils jwtUtils;
    final private UserGroupRoleService userGroupRoleService;

    public Mono<NewCustomerResponse> addCustomer(CustomerDto customerDto, String jwt) {
        return Mono.just(customerDto)
                .doOnNext(userDto1 -> log.info("Customer add request received [{}]", customerDto))
                .flatMap(request -> customerRepository.findByName(request.getName()))
                .flatMap(user -> Mono.just(NewCustomerResponse.builder()
                        .status("E1002")
                        .statusDescription("Customer Already exists")
                        .build()))
                .switchIfEmpty(
                        createCustomer(customerDto, jwtUtils.getUsername(jwt))
                )
                .doOnError(e ->
                        NewUserResponse.builder()
                                .status("E1000")
                                .statusDescription("Failed")
                                .build());
    }

    private Mono<NewCustomerResponse> createCustomer(CustomerDto customerDto, String username) {
        return userRepository.findByUsername(username)
                .flatMap(creatingUser -> userGroupRoleService.getUserRolesByUserGroup(creatingUser.getGroup())
                        .flatMap(userRoles -> {
                            log.info(customerDto.getName());
                            if (userRoles.contains(UserRoles.CREATE_CUSTOMER)) {
                                return save(customerDto, username);
                            }else {
                                return Mono.just(NewCustomerResponse.builder()
                                        .status("E1200")
                                        .statusDescription("You are not authorized to use this service").build());
                            }
                        }));
    }
    private Mono<NewCustomerResponse> save(CustomerDto customerDto, String username) {
        return Mono.just(customerDto)
                .map(customerMapper::customerDtoToCustomer)
                .doOnNext(customer -> {
                    customer.setName(customerDto.getName());
                    customer.setStatus("ACTIVE");
                    customer.setCreatedBy(username);
                    customer.setCreatedDateTime(LocalDateTime.now());
                    customer.setLastUpdatedDateTime(LocalDateTime.now());
                })
                .flatMap(customerRepository::insert)
                .doOnSuccess(customer -> log.info("Successfully saved the customer [{}]", customer))
                .map(customer -> NewCustomerResponse.builder()
                        .status("S1000")
                        .statusDescription("Success")
                        .name(customerDto.getName())
                        .build());
    }
}
