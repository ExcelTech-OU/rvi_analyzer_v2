package com.rvi.analyzer.rvianalyzerserver.mappers;

import com.rvi.analyzer.rvianalyzerserver.dto.ReadingDto;
import com.rvi.analyzer.rvianalyzerserver.entiy.Reading;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface ReadingMapper {
    @Mapping(target = "readAt", dateFormat = "yyyy-MM-dd HH:mm:ss")
    Reading readingDtoToReading(ReadingDto readingDto);
    ReadingDto readingToReadingDto(Reading reading);

}
