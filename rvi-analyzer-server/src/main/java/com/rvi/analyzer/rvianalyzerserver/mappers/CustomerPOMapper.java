package com.rvi.analyzer.rvianalyzerserver.mappers;

import com.rvi.analyzer.rvianalyzerserver.dto.CustomerPODto;
import com.rvi.analyzer.rvianalyzerserver.dto.StyleDto;
import com.rvi.analyzer.rvianalyzerserver.dto.UserDto;
import com.rvi.analyzer.rvianalyzerserver.entiy.Customer;
import com.rvi.analyzer.rvianalyzerserver.entiy.CustomerPO;
import com.rvi.analyzer.rvianalyzerserver.entiy.Style;
import com.rvi.analyzer.rvianalyzerserver.entiy.User;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface CustomerPOMapper {
    @Mapping(target = "createdDateTime", ignore = true)
    @Mapping(target = "createdBy", ignore = true)
    CustomerPO customerPODtoToCustomerPO(CustomerPODto customerPODto);

    CustomerPODto customerPOToCustomerPODto(CustomerPO customerPO);
}
