import React, { useState, ChangeEvent, useEffect } from "react";
import {
  TextField,
  MenuItem,
  Select,
  SelectChangeEvent,
  InputLabel,
  FormControl,
} from "@mui/material";
import { Order, useGetPOQuery } from "../../services/po_service";
import { List } from "reselect/es/types";
import {
  ModeSeven,
  SessionResultModeSeven,
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
    // const macAddresses: String[] = [];
    // const macAddresses: MacAddress[] = [];
    const macAddresses: SessionResultModeSeven[] = [];
    data?.sessions.forEach((session: ModeSeven) => {
      if (session.result && session.result.reading) {
        macAddresses.push({
          testId: session.result.testId,
          reading: session.result.reading,
        });
        // macAddresses.push(session.result.reading.macAddress);
        // macAddresses.push({
        //   id: session.result.testId,
        //   macAddress: session.result.reading.macAddress,
        // });
      }
    });
    return macAddresses;
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

  const handleSelectChange =
    (fieldName: string) => (event: SelectChangeEvent<string>) => {
      const newValue = event.target.value as string;
      setFieldValues((prevValues) => ({
        ...prevValues,
        [fieldName]: newValue,
      }));

      if (onInputChange) {
        onInputChange(fieldName, newValue);
      }
    };

  const selectFieldStyle: React.CSSProperties = {
    width: "200px",
    marginRight: "8px",
  };

  return (
    <div
      style={{
        display: "flex",
        flexDirection: "row",
        gap: "8px",
        // overflowX: "auto",
        // justifyContent: "space-between",
        padding: "5px 0 5px 0",
      }}
    >
      <FormControl fullWidth>
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
      </FormControl>

      <FormControl fullWidth>
        <InputLabel id="demo-simple-select-label">Production Order</InputLabel>
        <Select
          labelId="demo-simple-select-label"
          id="demo-simple-select"
          label="Production Order"
          variant="outlined"
          value={fieldValues.field2 || ""}
          onChange={handleSelectChange("field2")}
          style={selectFieldStyle}
        >
          <MenuItem value="">
            <em>None</em>
          </MenuItem>
          {optionsField2.map((option: Order) => (
            <MenuItem key={option.orderId} value={option.orderId}>
              {option.orderId}
            </MenuItem>
          ))}
        </Select>
      </FormControl>

      <FormControl fullWidth>
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
      </FormControl>
    </div>
  );
};

export default MyComponent;
