package com.rvi.analyzer.rvianalyzerserver.controller;

import com.rvi.analyzer.rvianalyzerserver.domain.*;
import com.rvi.analyzer.rvianalyzerserver.dto.StyleDto;
import com.rvi.analyzer.rvianalyzerserver.dto.UserDto;
import com.rvi.analyzer.rvianalyzerserver.service.StyleService;
import com.rvi.analyzer.rvianalyzerserver.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Mono;

@RestController
@RequiredArgsConstructor
public class StyleController {

    final private StyleService styleService;

    @PostMapping(path = "/register/style")
    public Mono<NewStyleResponse> addStyle(@RequestBody StyleDto styleDto, @RequestHeader("Authorization") String auth) {
        return styleService.addStyle(styleDto, auth);
    }

    @PostMapping(path = "/allocate/style/admin")
    public Mono<ResponseEntity<CommonResponse>> updateAdmin(@RequestBody UpdateStyleByAdmin updateStyleByAdmin, @RequestHeader("Authorization") String auth) {
        System.out.println(updateStyleByAdmin.getAdmin());
        return styleService.updateAdmin(updateStyleByAdmin, auth);
    }

    @GetMapping(path = "/rvi/analyzer/v1/styles")
    public Mono<ResponseEntity<StyleResponse>> getStyles(@RequestHeader("Authorization") String auth) {
        return styleService.getStyles(auth);
    }
}
