package com.rvi.analyzer.rvianalyzerserver.mappers;

import com.rvi.analyzer.rvianalyzerserver.dto.*;
import com.rvi.analyzer.rvianalyzerserver.entiy.*;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface ProductionOrderMapper {
    @Mapping(target = "createdDateTime", ignore = true)
    @Mapping(target = "createdBy", ignore = true)
    ProductionOrder productionOrderDtoToProductionOrder(ProductionOrderDto productionOrderDto);

    ProductionOrderDto productionOrderToProductionOrderDto(SONumber soNumber);
}
