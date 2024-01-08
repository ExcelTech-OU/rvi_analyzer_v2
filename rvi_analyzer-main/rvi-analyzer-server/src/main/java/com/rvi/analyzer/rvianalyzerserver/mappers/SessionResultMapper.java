package com.rvi.analyzer.rvianalyzerserver.mappers;

import com.rvi.analyzer.rvianalyzerserver.dto.SessionResultDto;
import com.rvi.analyzer.rvianalyzerserver.entiy.Reading;
import com.rvi.analyzer.rvianalyzerserver.entiy.SessionResult;
import lombok.Builder;
import lombok.Data;
import org.mapstruct.Mapper;

import java.util.List;

@Mapper(componentModel = "spring")
public interface SessionResultMapper {
    SessionResult sessionResultDtoToSessionResult(SessionResultDto sessionResultDto);
    SessionResultDto sessionResultToSessionResultDto(SessionResult sessionResult);
}
