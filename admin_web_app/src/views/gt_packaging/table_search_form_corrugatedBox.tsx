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

const MyComponentCorrugatedBox: React.FC<MyComponentProps> = ({
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
//   const [getGtTests, { data, error, isLoading }] = useGetGtTestsMutation();
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

//   const extractMacAddresses = () => {
//     // const macAddresses: String[] = [];
//     // const macAddresses: MacAddress[] = [];
//     const macAddresses: SessionResultModeSeven[] = [];
//     data?.sessions.forEach((session: ModeSeven) => {
//       if (session.result && session.result.reading) {
//         macAddresses.push({
//           testId: session.result.testId,
//           reading: session.result.reading,
//         });
//         // macAddresses.push(session.result.reading.macAddress);
//         // macAddresses.push({
//         //   id: session.result.testId,
//         //   macAddress: session.result.reading.macAddress,
//         // });
//       }
//     });
//     return macAddresses;
//   };

  useEffect(() => {
    if (poData && poData.orders) {
      setPOList(poData.orders);
    }
  }, [poData]);

//   useEffect(() => {
//     getGtTests({});
//   }, []);

//   useEffect(() => {
//     setOptionsField1(extractMacAddresses());
//   }, [data]);

  useEffect(() => {
    console.log(macList);
  }, [macList]);

  const optionsField2 = poList;
  const optionsPassFail = ["PASS", "FAIL"];

  //////////////////////////////////////////
  
  const [data, setData] = React.useState<any[]>([]);
  const [isLoading, setIsLoading] = React.useState(false);

  useEffect(() => {
    fetchData();
  }, []);

  const fetchData = async () => {
      try {
          setIsLoading(true);
        const response = await fetch('http://52.187.127.25:8090/api/mainTiles');
        const jsonData = await response.json();
        if(response.ok){
          setIsLoading(false);
          setData(jsonData);
        }
      } catch (error) {
          setIsLoading(false);
        console.error('Error fetching data:', error);
      }
    };

  //////////////////////////////////////////

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
        <InputLabel id="demo-simple-select-label">Corrugated BOX ID</InputLabel>
        <Select
          labelId="demo-simple-select-label"
          id="demo-simple-select"
          label="Corrugated BOX ID"
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
          {[...new Set(data.map(item => item.corBox_QR))].map((corBox_QR) => (
                <MenuItem key={corBox_QR} value={corBox_QR}>
                    {corBox_QR}
                </MenuItem>
            ))}

        </Select>
      </FormControl>

      <FormControl fullWidth>
        <InputLabel id="demo-simple-select-label">Where</InputLabel>
        <Select
          labelId="demo-simple-select-label"
          id="demo-simple-select"
          label="Where"
          variant="outlined"
          value={fieldValues.field2 || ""}
          onChange={handleSelectChange("field2")}
          style={selectFieldStyle}
        >
          <MenuItem value="">
            <em>None</em>
          </MenuItem>
          {[...new Set(data.map(item => item.destination))].map((destination) => (
                <MenuItem key={destination} value={destination}>
                    {destination}
                </MenuItem>
            ))}
        </Select>
      </FormControl>

      <FormControl fullWidth>
        <InputLabel id="demo-simple-select-label">Shipping ID</InputLabel>
        <Select
          labelId="demo-simple-select-label"
          id="demo-simple-select"
          label="Shipping ID"
          variant="outlined"
          value={fieldValues.field3 || ""}
          onChange={handleSelectChange("field3")}
          style={selectFieldStyle}
        >
          <MenuItem value="">
            <em>None</em>
          </MenuItem>
          {[...new Set(data.map(item => item.shipping_Id))].map((shipping_Id) => (
                <MenuItem key={shipping_Id} value={shipping_Id}>
                    {shipping_Id}
                </MenuItem>
            ))}
        </Select>
      </FormControl>

      <FormControl fullWidth>
        <InputLabel id="demo-simple-select-label">Customer PO</InputLabel>
        <Select
          labelId="demo-simple-select-label"
          id="demo-simple-select"
          label="Customer PO"
          variant="outlined"
          value={fieldValues.field4 || ""}
          onChange={handleSelectChange("field4")}
          style={selectFieldStyle}
        >
          <MenuItem value="">
            <em>None</em>
          </MenuItem>
          {[...new Set(data.map(item => item.customer_PO))].map((customer_PO) => (
                <MenuItem key={customer_PO} value={customer_PO}>
                    {customer_PO}
                </MenuItem>
            ))}
        </Select>
      </FormControl>

      
    </div>
  );
};

export default MyComponentCorrugatedBox;