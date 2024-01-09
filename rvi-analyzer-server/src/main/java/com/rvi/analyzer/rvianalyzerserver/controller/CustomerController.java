package com.rvi.analyzer.rvianalyzerserver.controller;

import com.rvi.analyzer.rvianalyzerserver.domain.CommonResponse;
import com.rvi.analyzer.rvianalyzerserver.domain.CustomerUpdateRequest;
import com.rvi.analyzer.rvianalyzerserver.domain.CustomersResponse;
import com.rvi.analyzer.rvianalyzerserver.domain.NewCustomerResponse;
import com.rvi.analyzer.rvianalyzerserver.dto.CustomerDto;
import com.rvi.analyzer.rvianalyzerserver.service.CustomerService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Mono;

@RestController
@RequiredArgsConstructor
public class CustomerController {

    final private CustomerService customerService;

    @PostMapping(path = "/register/customer")
    public Mono<NewCustomerResponse> addCustomer(@RequestBody CustomerDto customerDto, @RequestHeader("Authorization") String auth) {
        return customerService.addCustomer(customerDto, auth);
    }

    //    @PostMapping(path = "/login/user")
//    public Mono<ResponseEntity<LoginResponse>> loginUser(@RequestBody LoginRequest loginRequest) {
//        return userService.login(loginRequest);
//    }
//
//    @GetMapping(path = "/rvi/analyzer/v1/user/resetPassword/{userName}")
//    public Mono<ResponseEntity<CommonResponse>> resetPassword(@PathVariable String userName, @RequestHeader("Authorization") String auth) {
//        return userService.resetPassword(userName, auth);
//    }
//
//    @GetMapping(path = "/rvi/analyzer/v1/user/roles")
//    public Mono<ResponseEntity<UserRolesResponse>> getUserRoles(@RequestHeader("Authorization") String auth) {
//        return userService.getUserRoles(auth);
//    }
//
//    @GetMapping(path = "/rvi/analyzer/v1/user/jwt/validate")
//    public Mono<ResponseEntity<CommonResponse>> checkJwt(@RequestHeader("Authorization") String auth) {
//        return userService.checkJwt(auth);
//    }
//
//    @PostMapping(path = "/rvi/analyzer/v1/user/resetPassword")
//    public Mono<ResponseEntity<CommonResponse>> resetPasswordUser(@RequestBody PasswordResetRequest request, @RequestHeader("Authorization") String auth) {
//        return userService.resetPassword(auth, request);
//    }
//
//    @PostMapping(path = "/rvi/analyzer/v1/user/getUserNames")
//    public Mono<ResponseEntity<GetUserNamesResponse>> getUserNames(@RequestBody GetUserNamesRequest request, @RequestHeader("Authorization") String auth) {
//        return userService.getUserNames(request);
//    }
//
//    @GetMapping(path = "/rvi/analyzer/v1/user/{userName}")
//    public Mono<UserDto> getUserInfo(@PathVariable String userName) {
//        return userService.getUserByUsername(userName);
//    }
//
    @GetMapping(path = "/rvi/analyzer/v1/customers")
    public Mono<ResponseEntity<CustomersResponse>> getCustomers(@RequestHeader("Authorization") String auth) {
        return customerService.getCustomers(auth);
    }

    @PostMapping(path = "/rvi/analyzer/v1/customer/update")
    public Mono<ResponseEntity<CommonResponse>> updateCustomer(@RequestBody CustomerUpdateRequest request, @RequestHeader("Authorization") String auth) {
        return customerService.updateCustomer(request, auth);
    }
}
