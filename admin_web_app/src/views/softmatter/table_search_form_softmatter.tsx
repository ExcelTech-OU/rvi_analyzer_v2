import React, { useState, ChangeEvent, useEffect } from "react";
import {
  TextField,
  MenuItem,
  Select,
  SelectChangeEvent,
  InputLabel,
  FormControl,
  Grid,
  Autocomplete,
} from "@mui/material";
import { Order, useGetPOQuery } from "../../services/po_service";
import { List } from "reselect/es/types";
import {
  ModeSeven,
  SessionResultModeSeven,
  SessionSevenReading,
  useGetGtTestsMutation,
} from "../../services/gt_service";

var count = 0;

interface MyComponentProps {
  initialValues?: Record<string, string>;
  onInputChange?: (field: string, value: string) => void;
  orders: List<Order>;
}

interface MacAddress {
  id: String;
  macAddress: String;
}

const MyComponent: React.FC<MyComponentProps> = ({
  initialValues = {},
  onInputChange,
  orders,
}) => {
  const [fieldValues, setFieldValues] =
    useState<Record<string, string>>(initialValues);
  const {
    data: poData,
    error: poError,
    isLoading: poLoading,
  } = useGetPOQuery("");
  const [poList, setPOList] = useState<any>([]);
  const [macList, setMacList] = useState<any>([]);
  const [getGtTests, { data, error, isLoading }] = useGetGtTestsMutation();
  const [optionsField1, setOptionsField1] = useState<any>();

  const handleInputChangeLocal =
    (fieldName: string) =>
    (event: ChangeEvent<HTMLInputElement | { value: string }>) => {
      const newValue = event.target.value;
      setFieldValues((prevValues) => ({
        ...prevValues,
        [fieldName]: newValue,
      }));

      if (onInputChange) {
        onInputChange(fieldName, newValue);
      }
    };

    const extractMacAddresses = () => {
      const macAddressesSet = new Set();
      const macAddresses: SessionResultModeSeven[] = [];
    
      data?.sessions.forEach((session: ModeSeven) => {
        if (session.result && session.result.reading && session.result.reading.macAddress) {
          macAddresses.push({
            testId: session.result.testId,
            reading: session.result.reading,
          });
        }
      });
    
      return macAddresses;
    };

    const extractProductionOrders = () => {
      const productionOrdersSet = new Set();
      const productionOrders: SessionResultModeSeven[] = [];
    
      data?.sessions.forEach((session: ModeSeven) => {
        if (session.result && session.result.reading && session.result.reading.productionOrder) {
          const productionOrder = session.result.reading.productionOrder;
          if (!productionOrdersSet.has(productionOrder)) {
            productionOrdersSet.add(productionOrder);
            productionOrders.push({
              testId: session.result.testId,
              reading: session.result.reading,
            });
          }
        }
      });
    
      return productionOrders;
    };
    

  useEffect(() => {
    if (poData && poData.orders) {
      setPOList(poData.orders);
    }
  }, [poData]);

  useEffect(() => {
    getGtTests({});
  }, []);

  useEffect(() => {
    setOptionsField1(extractMacAddresses());
  }, [data]);

  useEffect(() => {
    console.log(macList);
  }, [macList]);

  const optionsField2 = poList;
  const optionsPassFail = ["PASS", "FAIL"];

  const handleSelectChange = (fieldName: string) => (event: any, newValue: string | null) => {
    const newValueStr = newValue || "";
    setFieldValues((prevValues) => ({
      ...prevValues,
      [fieldName]: newValueStr,
    }));

    if (onInputChange) {
      onInputChange(fieldName, newValueStr);
    }
  };

  const selectFieldStyle: React.CSSProperties = {
    width: "200px",
    marginRight: "8px",
  };

  const getUniqueValues = (key: keyof SessionSevenReading): string[] => {
    return [...new Set(data?.sessions.map((session: ModeSeven) => session.result.reading[key]))];
  };
  

  return (
    <div
      style={{
        display: "flex",
        flexDirection: "row",
        gap: "8px",
        padding: "5px 0",
      }}
    >
      <div
        style={{
          display: "flex",
          flexDirection: "row",
          gap: "8px",
          padding: "0 0 5px 0",
        }}
      >
        <Grid>
          <FormControl fullWidth>
          <Autocomplete
            options={getUniqueValues('macAddress')}
            getOptionLabel={(option: string) => option || ""}
            value={fieldValues.field1 || ""}
            onChange={handleSelectChange("field1")}
            renderInput={(params) => (
              <TextField
                {...params}
                label="MAC Address"
                variant="outlined"
                style={selectFieldStyle}
              />
            )}
          />
          </FormControl>
        </Grid>
        {/* <FormControl fullWidth>
          <InputLabel id="demo-simple-select-label">MAC Address</InputLabel>
          <Select
            labelId="demo-simple-select-label"
            id="demo-simple-select"
            label="MAC Address"
            variant="outlined"
            value={fieldValues.field1 || ""}
            onChange={handleSelectChange("field1")}
            style={selectFieldStyle}
            MenuProps={{
              PaperProps: {
                style: {
                  maxHeight: 150,
                },
              },
            }}
          >
            <MenuItem value="">
              <em>None</em>
            </MenuItem>
            {extractMacAddresses().map((option: SessionResultModeSeven) => (
              <MenuItem key={option.testId} value={option.reading.macAddress}>
                {option.reading.macAddress}
              </MenuItem>
            ))}
          </Select>
        </FormControl> */}

        <Grid>
          <FormControl fullWidth>
          <Autocomplete
            options={getUniqueValues('productionOrder')}
            getOptionLabel={(option: string) => option || ""}
            value={fieldValues.field2 || ""}
            onChange={handleSelectChange("field2")}
            renderInput={(params) => (
              <TextField
                {...params}
                label="Production Order"
                variant="outlined"
                style={selectFieldStyle}
              />
            )}
          />
          </FormControl>
        </Grid>
  
        {/* <FormControl fullWidth>
          <InputLabel id="demo-simple-select-label">Production Order</InputLabel>
          <Select
            labelId="demo-simple-select-label"
            id="demo-simple-select"
            label="Production Order"
            variant="outlined"
            value={fieldValues.field2 || ""}
            // onChange={handleSelectChange("field2")}
            style={selectFieldStyle}
          >
            <MenuItem value="">
              <em>None</em>
            </MenuItem>
            {extractProductionOrders().map((option: SessionResultModeSeven) => (
              <MenuItem key={option.testId} value={option.reading.productionOrder}>
                {option.reading.productionOrder}
              </MenuItem>
            ))}
          </Select>
        </FormControl> */}

        <Grid>
          <FormControl fullWidth>
          <Autocomplete
            options={getUniqueValues('result')}
            getOptionLabel={(option: string) => option || ""}
            value={fieldValues.field3 || ""}
            onChange={handleSelectChange("field3")}
            renderInput={(params) => (
              <TextField
                {...params}
                label="Result"
                variant="outlined"
                style={selectFieldStyle}
              />
            )}
          />
          </FormControl>
        </Grid>
  
        {/* <FormControl fullWidth>
          <InputLabel id="demo-simple-select-label">Result</InputLabel>
          <Select
            labelId="demo-simple-select-label"
            id="demo-simple-select"
            label="Result"
            variant="outlined"
            value={fieldValues.field3 || ""}
            onChange={handleSelectChange("field3")}
            style={selectFieldStyle}
          >
            <MenuItem value="">
              <em>None</em>
            </MenuItem>
            {optionsPassFail.map((option) => (
              <MenuItem key={option} value={option}>
                {option}
              </MenuItem>
            ))}
          </Select>
        </FormControl> */}
      </div>
    </div>
  );
  
};

export default MyComponent;
