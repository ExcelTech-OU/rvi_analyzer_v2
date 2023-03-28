package com.rvi.analyzer.rvianalyzerserver.mappers;

import com.rvi.analyzer.rvianalyzerserver.dto.ReadingDto;
import com.rvi.analyzer.rvianalyzerserver.entiy.Reading;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface ReadingMapper {
    Reading readingDtoToReading(ReadingDto readingDto);
    ReadingDto readingToReadingDto(Reading reading);

}
