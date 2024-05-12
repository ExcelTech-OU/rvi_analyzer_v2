import {
    Box,
    Button,
    Card,
    CardActionArea,
    CardContent,
    Container,
    Divider,
    Grid,
    Pagination,
    Typography,
  } from "@mui/material";
  import { GridColDef } from "@mui/x-data-grid";
  import GridOnIcon from "@mui/icons-material/GridOn";
  import * as React from "react";
  import Paper from "@mui/material/Paper";
  import Table from "@mui/material/Table";
  import TableBody from "@mui/material/TableBody";
  import TableCell, { tableCellClasses } from "@mui/material/TableCell";
  import TableContainer from "@mui/material/TableContainer";
  import TableHead from "@mui/material/TableHead";
  import TableRow from "@mui/material/TableRow";
  import { styled } from "@mui/material";
//   import SessionTimeoutPopup from "../../components/session_logout";
import { handleGenerateExcelPackageBox } from "./gtTracking-box-excel";
import { Download } from "@mui/icons-material";

import { useState, useEffect } from "react";
// import MyComponent from "../../table_search_form_softmatter";
// import BasicDateRangePicker from "../datePicker";
// import { ModeSeven, useGetGtTestsMutation } from "../../../services/gt_service";
import { AnyObject } from "yup/lib/types";
import { List } from "reselect/es/types";
// import { useGetPOQuery } from "../../../services/po_service";

import MyComponentPackagingBox from "./table_search_form_gtTrackingBox";
import DatePickerComponentPackagingBox from "./date_picker_gtTrackingBox";



export const StyledTableCell = styled(TableCell)(({ theme }) => ({
    [`&.${tableCellClasses.head}`]: {
      backgroundColor: "#9e9e9e",
      color: theme.palette.common.white,
    },
    [`&.${tableCellClasses.body}`]: {
      fontSize: 14,
    },
  }));
  
  export const StyledTableRow = styled(TableRow)(({ theme }) => ({
    "&:nth-of-type(odd)": {
      backgroundColor: theme.palette.action.hover,
    },
    // hide last border
    "&:last-child td, &:last-child th": {
      border: 0,
    },
  }));
  const columns: GridColDef[] = [
    {
        field: "Select",
        headerName: "Select",
        width: 80,
    },
    {
      field: "corBox_QR",
      headerName: "Corrugated Box QR",
      width: 80,
    },
    {
      field: "retailBox_QR",
      headerName: "Packaging Box QR",
      width: 150,
    },
    {
      field: "battery01Serial",
      headerName: "Battery 01 NFC",
      width: 200,
    },
    {
      field: "battery02Serial",
      headerName: "Battery 02 NFC",
      width: 200,
    },
    {
      field: "deviceLMac",
      headerName: "Device L Mac",
      width: 200,
    },
    {
        field: "deviceRMac",
        headerName: "Device R Mac",
        width: 200,
    },
    {
        field: "destination",
        headerName: "where",
        width: 100,
    },
    {
        field: "shipping_Id",
        headerName: "shipping Id",
        width: 100,
    },
    {
        field: "customer_PO",
        headerName: "Customer PO",
        width: 100,
    },
    {
        field: "packedDate",
        headerName: "Packed Date",
        width: 100,
    },
    {
        field: "packedBy",
        headerName: "Packed By",
        width: 100,
    },
   
  ];
export default function GtTrackingBoxList() {
    const [dataCorWeb, setDataCorWeb] = React.useState<any[]>([]);
    const [isLoading, setIsLoading] = React.useState(false);
    const [selectedRows, setSelectedRows] = React.useState<number[]>([]);
    const [poList, setPOList] = useState<any>([]);
    // const paginatedModes = modesList.slice(startIndex, endIndex);

    const [values, setValues] = useState({
      field1: "",
      field2: "",
      field3: "",
      field4: "",
      field5: "",
      field6: "",
      field7: "",
    });

    const [rowsPerPage, setRowsPerPage] = useState(5);
    const [page, setPage] = useState(1);

    

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
      

      
      
      const updatedRetailData = updateRetailDataWithCorrelationData(dataCorWeb, dataRetailWeb);
      console.log(updatedRetailData);
      // setFilteredData(updatedRetailData);

      

      const [filteredData, setFilteredData] = useState<any[]>(updatedRetailData);

      const [packedDate, setPackedDate] = useState(null);
      const [packedEndDate, setPackedEndDate] = useState(null);

      useEffect(() => {
        const filteredData = updatedRetailData.filter(item =>
          item.retailBox_QR.includes(values.field1) &&
          item.battery01_Serial.includes(values.field2) &&
          item.battery02_Serial.includes(values.field3) &&
          item.deviceL_Mac.includes(values.field4) &&
          item.deviceR_Mac.includes(values.field5) &&
          item.packed_By.includes(values.field6) &&
          (!packedDate || new Date(item.itemDate).setHours(0,0,0,0) == new Date(packedDate).setHours(0,0,0,0))
        );

        setFilteredData(filteredData);
        console.log(filteredData);
        

        
      }, [values,packedDate]);
    
      const startIndex = (page - 1) * rowsPerPage;
      const endIndex = startIndex + rowsPerPage;
      const paginatedModes = filteredData.slice(startIndex, endIndex);
      

      /////////////////////////////////////////////////

      const [data, setData] = React.useState<any[]>([]);

      const handleChange = (event: React.ChangeEvent<unknown>, value: number) => {
        setPage(value);
      };
      
      // setData(updatedRetailData);
      console.log(data);

      function getSelectedList(): any {
        return (
          updatedRetailData.filter((item, index) => selectedRows.includes(item.id)) || []
        );
      }
      // const [getAll] = useGetGtTestsMutation();

      const handleRowClick = (id: number) => {
        if (selectedRows.includes(id)) {
          setSelectedRows(selectedRows.filter((rowId) => rowId !== id));
        } else {
          setSelectedRows([...selectedRows, id]);
        }
      };

      const handleInputChange = (field: string, value: string) => {
        setValues((prevValues) => ({
          ...prevValues,
          [field]: value,
        }));

        console.log("hj");
        
        
      };

      

      const handleDateChange = (date: React.SetStateAction<null>) => {
        setPackedDate(date);
        // console.log(packedDate);

        setPackedEndDate(date);
        // console.log(packedEndDate);
      };


      if (isLoading) {
        return <div>Loading...</div>;
      }
  return (
    <div>
      
      {/* <h1>Packaging Boxes</h1>
      <table>
        <thead>
          <tr>
            <th>Element Number</th>
            <th>Battery01 Serial</th>
            <th>Battery02 Serial</th>
            <th>DeviceL Mac</th>
            <th>DeviceR Mac</th>
            <th>packed Date</th>
            <th>Packed By</th>

          </tr>
        </thead>
        <tbody>
          {data.map((box) => (
            <tr key={box.element_number}>
              <td>{box.element_number}</td>
              <td>{box.battery01_Serial}</td>
              <td>{box.battery02_Serial}</td>
              <td>{box.deviceL_Mac}</td>
              <td>{box.deviceR_Mac}</td>
              <td>{box.packed_Date}</td>
              <td>{box.packed_By}</td>
            </tr>
          ))}
        </tbody> 
        </table>*/}
        <Box
      component="main"
      sx={{
        flexGrow: 1,
      }}
    >
      <Container maxWidth={false}>
        <>
          <Box m="0px 0 0 0" sx={{}}>
            <Card
              sx={{
                maxWidth: 1600,
                maxHeight: "100vh",
                backgroundColor: "#FFFFFF",
                boxShadow: "1px 1px 10px 10px #e8e8e8",
              }}
            >
              <CardActionArea>
                <CardContent sx={{}}>
                  <Grid
                    container
                    spacing={{ xs: 1, md: 1 }}
                    columns={{ xs: 4, sm: 8, md: 12 }}
                  >
                    <Grid item xs={4} sm={6} md={6}>
                      <Typography
                        gutterBottom
                        variant="h5"
                        component="div"
                        color="grey"
                      >
                        GT Tracking
                      </Typography>
                    </Grid>
                    <Grid item xs={4} sm={2} md={6}>
                      <Box display="flex" justifyContent="flex-end">
                        <Button
                          sx={{ padding: 2 }}
                          variant="contained"
                          startIcon={<Download />}
                          color="success"
                          onClick={() =>
                            handleGenerateExcelPackageBox(getSelectedList())
                          }
                          disabled={selectedRows.length == 0}
                        >
                          Download Selected
                        </Button>
                        <Button
                          sx={{ ml: 2, padding: 2 }}
                          variant="contained"
                          startIcon={<GridOnIcon />}
                          color="success"
                          onClick={() => {
                            const filteredData = updatedRetailData.filter(item =>
                              item.retailBox_QR.includes(values.field1) &&
                              item.battery01_Serial.includes(values.field2) &&
                              item.battery02_Serial.includes(values.field3) &&
                              item.deviceL_Mac.includes(values.field4) &&
                              item.deviceR_Mac.includes(values.field5) &&
                              item.packed_By.includes(values.field6) &&
                              (!packedDate || new Date(new Date(item.packed_Date)).setHours(0,0,0,0) == new Date(packedDate).setHours(0,0,0,0))
                            );
                            if (values) {
                                handleGenerateExcelPackageBox(filteredData);
                            } else {
                                handleGenerateExcelPackageBox(updatedRetailData);
                            }
                        }}
                        //   onClick={() => {
                        //     getAll({
                        //       data: {
                        //         date: date,
                        //         filterType: filterType,
                        //         filterValue: filterValue,
                        //       },
                        //       page: "all",
                        //     })
                        //       .unwrap()
                        //       .then((payload) => {
                        //         filteredData = payload.sessions.filter(
                        //           (item) => {
                        //             const itemDate = new Date(
                        //               item.createdDateTime
                        //             );

                        //             const originalFilterCondition =
                        //               item.result.reading.macAddress.includes(
                        //                 values.field1
                        //               ) &&
                        //               item.result.reading.productionOrder.includes(
                        //                 values.field2
                        //               ) &&
                        //               item.result.reading.result.includes(
                        //                 values.field3
                        //               ) &&
                        //               (!startingDate ||
                        //                 new Date(itemDate) >=
                        //                   new Date(startingDate)) &&
                        //               (!finishingDate ||
                        //                 new Date(itemDate) <=
                        //                   new Date(finishingDate));

                        //             return originalFilterCondition;
                        //           }
                        //         );

                        //         handleGenerateExcelEndLineQc(filteredData);
                        //       });
                        //   }}
                        >
                          Download
                        </Button>
                      </Box>
                    </Grid>
                    
                  </Grid>
                  <Divider
                    sx={{
                      borderColor: "grey",
                      mb: 1.5,
                      borderStyle: "dashed",
                    }}
                  />
                  <div
                    style={{
                      display: "flex",
                      alignItems: "center",
                      marginBottom: "5px",
                      width: "100%",
                      maxWidth: 1600,
                      // overflowX: "auto",
                      flexDirection: "row",
                      flexWrap: "wrap",
                    }}
                  >
                   <MyComponentPackagingBox
                      initialValues={values}
                      onInputChange={handleInputChange}
                      orders={poList}
                    />

                    
                  </div>

                  <div
                      style={{
                        marginLeft: "1px",
                        marginRight: "10px",
                        width: "250px",
                      }}
                    >
                      <DatePickerComponentPackagingBox
                        label="Packed Date"
                        onChange={handleDateChange}
                      />
                    </div>

                  <Divider
                    sx={{
                      borderColor: "grey",
                      my: 1.5,
                      borderStyle: "dashed",
                    }}
                  />
                  <Paper sx={{ width: "100%", overflow: "hidden" }}>
                    <TableContainer sx={{ maxHeight: 440 }}>
                      <Table stickyHeader aria-label="sticky table">
                        <TableHead sx={{ backgroundColor: "#9e9e9e" }}>
                          <StyledTableRow>
                            {columns.map((column) => (
                              <StyledTableCell
                                key={column.headerName}
                                align={column.align}
                                style={{ maxWidth: column.width }}
                              >
                                {column.headerName}
                              </StyledTableCell>
                            ))}
                          </StyledTableRow>
                        </TableHead>
                        <TableBody>
                          {updatedRetailData
                          .filter((item) => {
                            const itemDate = new Date(item.packed_Date);
                            // console.log(itemDate);
                            
                          
                            return (
                              item.retailBox_QR.includes(
                                values.field1
                              ) &&
                              item.battery01_Serial.includes(
                                values.field2
                              ) &&
                              item.battery02_Serial.includes(
                                values.field3
                              ) &&
                              item.deviceL_Mac.includes(
                                values.field4
                              ) &&
                              item.deviceR_Mac.includes(
                                values.field5
                              ) &&
                              item.packed_By.includes(
                                values.field6
                              )  &&
                              (!packedDate || new Date(itemDate).setHours(0,0,0,0) == new Date(packedDate).setHours(0,0,0,0))
                                // &&
                                  // (!packedEndDate || new Date(itemDate).setHours(0,0,0,0) <= new Date(packedEndDate).setHours(0,0,0,0))
                                 
                            );
                          }).map((box) => {
                              return (
                                <StyledTableRow
                                  hover
                                  role="checkbox"
                                  tabIndex={-1}
                                  key={box.id}
                                  onClick={() => handleRowClick(box.id)}
                                  selected={selectedRows.includes(box.id)}
                                >
                                  <StyledTableCell align={"left"}>
                                    <input
                                      type="checkbox"
                                      checked={selectedRows.includes(box.id)}
                                    />
                                  </StyledTableCell>
                                  <StyledTableCell align={"left"}>
                                  {box.corBox_Qr}
                                  </StyledTableCell>
                                  <StyledTableCell align={"left"}>
                                  {box.retailBox_QR}
                                  </StyledTableCell>
                                  <StyledTableCell align={"left"}>
                                  {box.battery01_Serial}
                                  </StyledTableCell>
                                  <StyledTableCell align={"left"}>
                                  {box.battery02_Serial}
                                  </StyledTableCell>
                                  <StyledTableCell align={"left"}>
                                  {box.deviceL_Mac}
                                  </StyledTableCell>
                                  <StyledTableCell align={"left"}>
                                  {box.deviceR_Mac}
                                  </StyledTableCell>
                                  <StyledTableCell align={"left"}>
                                  {box.destination}
                                  </StyledTableCell>
                                  <StyledTableCell align={"left"}>
                                  {box.shipping_Id}
                                  </StyledTableCell>
                                  <StyledTableCell align={"left"}>
                                  {box.customer_Po}
                                  </StyledTableCell>
                                  <StyledTableCell align={"left"}>
                                  {new Date(box.packed_Date).toLocaleDateString()}
                                  </StyledTableCell>
                                  <StyledTableCell align={"left"}>
                                  {box.packed_By}
                                  </StyledTableCell>
                                  {/* <StyledTableCell align={"left"}>
                                    {item.result.reading.result}
                                  </StyledTableCell>
                                  <StyledTableCell align={"left"}>
                                    {item.createdDateTime.split("T")[0]}
                                  </StyledTableCell>
                                  <StyledTableCell align={"left"}>
                                    {item.createdDateTime.split("T")[1]}
                                  </StyledTableCell> */}
                                </StyledTableRow>
                              );
                            })}
                        </TableBody>
                      </Table>
                    </TableContainer>
                  </Paper>
                  <Box display="flex" justifyContent="flex-end">
                    <Pagination
                      count={Math.ceil(filteredData.length / rowsPerPage)}
                      sx={{ mt: 2 }}
                      variant="outlined"
                      shape="rounded"
                      page={page}
                      onChange={handleChange}
                    />
                  </Box>
                </CardContent>
              </CardActionArea>
            </Card>
          </Box>
        </>
      </Container>
    </Box>
      
    </div>
  )
}
