//package com.rvi.analyzer.rvianalyzerserver.service;
//
//import com.rvi.analyzer.rvianalyzerserver.domain.*;
//import com.rvi.analyzer.rvianalyzerserver.dto.CustomerDto;
//import com.rvi.analyzer.rvianalyzerserver.dto.MaterialDto;
//import com.rvi.analyzer.rvianalyzerserver.dto.PlantDto;
//import com.rvi.analyzer.rvianalyzerserver.entiy.Customer;
//import com.rvi.analyzer.rvianalyzerserver.mappers.CustomerMapper;
//import com.rvi.analyzer.rvianalyzerserver.repository.CustomerRepository;
//import com.rvi.analyzer.rvianalyzerserver.repository.PlantRepository;
//import com.rvi.analyzer.rvianalyzerserver.repository.UserRepository;
//import com.rvi.analyzer.rvianalyzerserver.security.JwtUtils;
//import lombok.RequiredArgsConstructor;
//import lombok.extern.slf4j.Slf4j;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.http.HttpStatus;
//import org.springframework.http.ResponseEntity;
//import org.springframework.stereotype.Service;
//import reactor.core.publisher.Mono;
//
//import java.time.LocalDateTime;
//import java.util.Objects;
//
//@Service
//@RequiredArgsConstructor
//@Slf4j
//public class CustomerService {
//
//    final private CustomerRepository customerRepository;
//    final private UserRepository userRepository;
//    final private CustomerMapper customerMapper;
//    final private JwtUtils jwtUtils;
//    final private UserGroupRoleService userGroupRoleService;
//
//    public Mono<NewCustomerResponse> addCustomer(CustomerDto customerDto, String jwt) {
//        return Mono.just(customerDto)
//                .doOnNext(userDto1 -> log.info("Customer add request received [{}]", customerDto))
//                .flatMap(request -> customerRepository.findByName(request.getName()))
//                .flatMap(user -> Mono.just(NewCustomerResponse.builder()
//                        .status("E1002")
//                        .statusDescription("Customer Already exists")
//                        .build()))
//                .switchIfEmpty(
//                        createCustomer(customerDto, jwtUtils.getUsername(jwt), jwt)
//                )
//                .doOnError(e ->
//                        NewUserResponse.builder()
//                                .status("E1000")
//                                .statusDescription("Failed")
//                                .build());
//    }
//
//    private Mono<NewCustomerResponse> createCustomer(CustomerDto customerDto, String username, String jwt) {
//        return Mono.just(userRepository.findByUsername(username))
//                .flatMap(creatingUser -> userGroupRoleService.getUserRolesByUserGroup(creatingUser.getGroup())
//                        .flatMap(userRoles -> {
//                            log.info(customerDto.getName());
//                            if (userRoles.contains(UserRoles.CREATE_CUSTOMER)) {
//                                return save(customerDto, username, jwt);
//                            } else {
//                                return Mono.just(NewCustomerResponse.builder()
//                                        .status("E1200")
//                                        .statusDescription("You are not authorized to use this service").build());
//                            }
//                        }));
//    }
//
//    private Mono<NewCustomerResponse> save(CustomerDto customerDto, String username, String jwt) {
//        return Mono.just(customerDto)
//                .map(customerMapper::customerDtoToCustomer)
//                .doOnNext(customer -> {
//                    customer.setName(customerDto.getName());
//                    customer.setStatus("ACTIVE");
////                    customer.setPlant("UN-ASSIGNED");
//                    customer.setCreatedBy(username);
//                    customer.setCreatedDateTime(LocalDateTime.now());
//                    customer.setLastUpdatedDateTime(LocalDateTime.now());
//                })
//                .flatMap(customerRepository::insert)
//                .doOnSuccess(customer -> log.info("Successfully saved the customer [{}]", customer))
//                .map(customer -> NewCustomerResponse.builder()
//                        .status("S1000")
//                        .statusDescription("Success")
//                        .name(customerDto.getName())
//                        .build());
//    }
//
//    public Mono<ResponseEntity<CustomersResponse>> getCustomers(String auth) {
//        log.info("get customers request received with jwt [{}]", auth);
//        return Mono.just(userRepository.findByUsername(jwtUtils.getUsername(auth)))
//                .flatMap(requestedUser -> userGroupRoleService.getUserRolesByUserGroup(requestedUser.getGroup())
//                                .flatMap(userRoles -> {
//                                    if (userRoles.contains(UserRoles.GET_ALL_CUSTOMERS)) {
//                                        return customerRepository.findAll()
//                                                .map(customer -> {
//                                                    return CustomerDto.builder()
//                                                            ._id(customer.get_id())
////                                                    .plant(customer.getPlant())
//                                                            .name(customer.getName())
//                                                            .createdBy(customer.getCreatedBy())
//                                                            .createdDateTime(customer.getCreatedDateTime())
//                                                            .build();
//                                                })
//                                                .collectList()
//                                                .flatMap(customerDtos -> Mono.just(ResponseEntity.ok(CustomersResponse.builder()
//                                                        .status("S1000")
//                                                        .statusDescription("Success")
//                                                        .customers(customerDtos)
//                                                        .build()
//                                                )));
//                                    } else {
//                                        return Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(CustomersResponse.builder()
//                                                .status("E1200")
//                                                .statusDescription("You are not authorized to use this service").build()));
//                                    }
//                                })
//                )
//                .switchIfEmpty(Mono.just(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(CustomersResponse.builder()
//                        .status("E1000")
//                        .statusDescription("Failed").build())));
//    }
//
//    public Mono<CustomerDto> getCustomerByName(String name) {
//        return Mono.just(name)
//                .doOnNext(uName -> log.info("Finding customer for name [{}]", uName))
//                .flatMap(customerRepository::findByName)
//                .map(customerMapper::customerToCustomerDto);
//    }
//}
