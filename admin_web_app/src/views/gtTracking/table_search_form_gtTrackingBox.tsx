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

const MyComponentPackagingBox: React.FC<MyComponentProps> = ({
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
  const [dataCorWeb, setDataCorWeb] = React.useState<any[]>([]);
  const [isLoading, setIsLoading] = React.useState(false);

  useEffect(() => {
    fetchData();
    fetchDataMainTiles();
    
    // console.log(dataRetailWeb);
    
  }, []);

  const fetchData = async () => {
      try {
          setIsLoading(true);
        const response = await fetch('http://52.187.127.25:8090/api/getCorWeb');
        const jsonData = await response.json();
        if(response.ok){
          setIsLoading(false);
          setDataCorWeb(jsonData);
        }
      } catch (error) {
          setIsLoading(false);
        console.error('Error fetching data:', error);
      }
    };

    const [dataRetailWeb, setDataRetailWeb] = React.useState<any[]>([]);
    const [isLoadingMainTiles, setIsLoadingMainTiles] = React.useState(false);

    const fetchDataMainTiles = async () => {
      try {
          setIsLoadingMainTiles(true);
        const response = await fetch('http://52.187.127.25:8090/api/getRetailWeb');
        const jsonData = await response.json();
        if(response.ok){
          setIsLoadingMainTiles(false);
          setDataRetailWeb(jsonData);
        }
      } catch (error) {
          setIsLoadingMainTiles(false);
        console.error('Error fetching data:', error);
      }
      console.log(dataCorWeb);
    };

    /////////////////////////////////////////////////
    // Define the interfaces for CorrelationObject and RetailObject
    interface CorrelationObject {
      corBox_Id: string;
      retailQR: string; // Assuming retailQR exists in CorrelationObject
      [key: string]: any;
    }

    interface RetailObject {
      retailBox_QR: string;
      [key: string]: any;
    }

    // Function to update retail data with correlation data
    function updateRetailDataWithCorrelationData(dataCorWeb: CorrelationObject[], dataRetailWeb: RetailObject[]): any[] {
      const updatedData: any[] = [];
      
      let i = 0;
      dataCorWeb.forEach((CorObj: CorrelationObject) => {
          
        for (const key in CorObj) {

          if (key.startsWith("retailQR_")) {
            const retailQR = CorObj[key];
            // console.log(retailQR);
            
            dataRetailWeb.forEach((retailObj: RetailObject) => {
              if (retailQR && retailObj.retailBox_QR === retailQR) {
                  const updatedObj = { ...retailObj, 
                    corBox_Id: CorObj.corBox_Id, 
                    corBox_Qr: CorObj.corBox_QR, 
                    shipping_Id: CorObj.shipping_Id, 
                    customer_Po: CorObj.customer_PO,
                    destination: CorObj.destination,
                    id: i
                  };
                  updatedData.push(updatedObj);
                  i = i+1;
              }
            });
          }
        }

          
      });

      return updatedData;
    }

    // Example usage
    const updatedRetailData = updateRetailDataWithCorrelationData(dataCorWeb, dataRetailWeb);
    // console.log(updatedRetailData);

    

  /////////////////////////////////////////////////
  //////////////////////////////////////////
  const [data, setData] = React.useState<any[]>([]);

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
      gap: "5px",
      marginBottom:"5px",
    }}>
    <div
      style={{
        display: "flex",
        gap: "5px",
        marginBottom:"5px"
      }}
    >
      <FormControl fullWidth>
        <InputLabel id="demo-simple-select-label">Packaging Box QR</InputLabel>
        <Select
          labelId="demo-simple-select-label"
          id="demo-simple-select"
          label="Packaging Box QR"
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
          {[...new Set(updatedRetailData.map(item => item.retailBox_QR))].map((retailBox_QR) => (
                <MenuItem key={retailBox_QR} value={retailBox_QR}>
                    {retailBox_QR}
                </MenuItem>
            ))}

        </Select>
      </FormControl>

      <FormControl fullWidth>
        <InputLabel id="demo-simple-select-label">Battery 01 NFC ID</InputLabel>
        <Select
          labelId="demo-simple-select-label"
          id="demo-simple-select"
          label="Battery 01 NFC ID"
          variant="outlined"
          value={fieldValues.field2 || ""}
          onChange={handleSelectChange("field2")}
          style={selectFieldStyle}
        >
          <MenuItem value="">
            <em>None</em>
          </MenuItem>
          {[...new Set(updatedRetailData.map(item => item.battery01_Serial))].map((battery01_Serial) => (
                <MenuItem key={battery01_Serial} value={battery01_Serial}>
                    {battery01_Serial}
                </MenuItem>
            ))}
        </Select>
      </FormControl>

      <FormControl fullWidth>
        <InputLabel id="demo-simple-select-label">Battery 02 NFC ID</InputLabel>
        <Select
          labelId="demo-simple-select-label"
          id="demo-simple-select"
          label="Battery 02 NFC ID"
          variant="outlined"
          value={fieldValues.field3 || ""}
          onChange={handleSelectChange("field3")}
          style={selectFieldStyle}
        >
          <MenuItem value="">
            <em>None</em>
          </MenuItem>
          {[...new Set(updatedRetailData.map(item => item.battery02_Serial))].map((battery02_Serial) => (
                <MenuItem key={battery02_Serial} value={battery02_Serial}>
                    {battery02_Serial}
                </MenuItem>
            ))}
        </Select>
      </FormControl>

      <FormControl fullWidth>
        <InputLabel id="demo-simple-select-label">Device L MAC</InputLabel>
        <Select
          labelId="demo-simple-select-label"
          id="demo-simple-select"
          label="Device L MAC"
          variant="outlined"
          value={fieldValues.field4 || ""}
          onChange={handleSelectChange("field4")}
          style={selectFieldStyle}
        >
          <MenuItem value="">
            <em>None</em>
          </MenuItem>
          {[...new Set(updatedRetailData.map(item => item.deviceL_Mac))].map((deviceL_Mac) => (
                <MenuItem key={deviceL_Mac} value={deviceL_Mac}>
                    {deviceL_Mac}
                </MenuItem>
            ))}
        </Select>
      </FormControl>

      <FormControl fullWidth>
        <InputLabel id="demo-simple-select-label">Device R MAC</InputLabel>
        <Select
          labelId="demo-simple-select-label"
          id="demo-simple-select"
          label="Device R MAC"
          variant="outlined"
          value={fieldValues.field5 || ""}
          onChange={handleSelectChange("field5")}
          style={selectFieldStyle}
        >
          <MenuItem value="">
            <em>None</em>
          </MenuItem>
          {[...new Set(updatedRetailData.map(item => item.deviceR_Mac))].map((deviceR_Mac) => (
                <MenuItem key={deviceR_Mac} value={deviceR_Mac}>
                    {deviceR_Mac}
                </MenuItem>
            ))}
        </Select>
      </FormControl>
      
      </div>
      <div
        style={{
          display: "flex",
          gap: "8px",
        }}
      >

      <FormControl fullWidth>
        <InputLabel id="demo-simple-select-label">Packed By</InputLabel>
        <Select
          labelId="demo-simple-select-label"
          id="demo-simple-select"
          label="Packed By"
          variant="outlined"
          value={fieldValues.field6 || ""}
          onChange={handleSelectChange("field6")}
          style={selectFieldStyle}
        >
          <MenuItem value="">
            <em>None</em>
          </MenuItem>
          {[...new Set(updatedRetailData.map(item => item.packed_By))].map((packed_By) => (
                <MenuItem key={packed_By} value={packed_By}>
                    {packed_By}
                </MenuItem>
            ))}
        </Select>
      </FormControl>
    </div>
    </div>
  );
};

export default MyComponentPackagingBox;
