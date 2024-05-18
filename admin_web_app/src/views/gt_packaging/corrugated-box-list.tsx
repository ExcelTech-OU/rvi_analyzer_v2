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
import { handleGenerateExcelCorrugatedBox } from "./corrugated-box-excel";
import { Download } from "@mui/icons-material";

import { useState, useEffect } from "react";
// import MyComponent from "../../table_search_form_softmatter";
// import BasicDateRangePicker from "../datePicker";
// import { ModeSeven, useGetGtTestsMutation } from "../../../services/gt_service";
import { AnyObject } from "yup/lib/types";
import { List } from "reselect/es/types";
// import { useGetPOQuery } from "../../../services/po_service";
import MyComponentCorrugatedBox from "./table_search_form_corrugatedBox";



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
      field: "corrugatedBoxID",
      headerName: "Corrugated Box ID",
      width: 150,
    },
    {
        field: "where",
        headerName: "where",
        width: 150,
    },
    {
      field: "shippingID",
      headerName: "Shipping ID",
      width: 150,
    },
    {
      field: "customerPO",
      headerName: "Customer PO",
      width: 100,
    },
    
   
  ];
export default function CorrugatedBoxList() {
    const [data, setData] = React.useState<any[]>([]);
    const [isLoading, setIsLoading] = React.useState(false);
    const [selectedRows, setSelectedRows] = React.useState<number[]>([]);
    const [poList, setPOList] = useState<any>([]);
    // const paginatedModes = modesList.slice(startIndex, endIndex);

    const [values, setValues] = useState({
        field1: "",
        field2: "",
        field3: "",
        field4: "",
      });
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

    //   function getSelectedList(): any {
    //     return (
    //       paginatedModes.filter((item, index) => selectedRows.includes(index)) || []
    //     );
    //   }
    //   const [getAll] = useGetGtTestsMutation();
    function getSelectedList(): any {
        console.log(selectedRows);
        
        return (
          data.filter((item, index) => selectedRows.includes(item.corBox_QR)) || []
        );
      }

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
                maxHeight: "80vh",
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
                        GT Packaging Corrugated Boxes
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
                            handleGenerateExcelCorrugatedBox(getSelectedList())
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
                          onClick={() =>
                            handleGenerateExcelCorrugatedBox(data)
                          }
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
                      marginBottom: "20px",
                      width: "100%",
                      overflowX: "auto",
                      flexDirection: "row",
                    }}
                  >
                   <MyComponentCorrugatedBox
                      initialValues={values}
                      onInputChange={handleInputChange}
                      orders={poList}
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
                          {data
                          .filter((item) => {
                            
                            return (
                              item.corBox_QR.includes(
                                values.field1
                              ) &&
                              item.destination.includes(
                                values.field2
                              ) &&
                              item.shipping_Id.includes(
                                values.field3
                              ) &&
                              item.customer_PO.includes(
                                values.field4
                              ) 
                             
                            );
                          }).map((box) => {
                              return (
                                <StyledTableRow
                                  hover
                                  role="checkbox"
                                  tabIndex={-1}
                                  key={box.corBox_QR}
                                  onClick={() => handleRowClick(box.corBox_QR)}
                                  selected={selectedRows.includes(box.corBox_QR)}
                                >
                                  <StyledTableCell align={"left"}>
                                    <input
                                      type="checkbox"
                                      checked={selectedRows.includes(box.corBox_QR)}
                                    />
                                  </StyledTableCell>
                                  <StyledTableCell align={"left"}>
                                  {box.corBox_QR}
                                  </StyledTableCell>
                                  <StyledTableCell align={"left"}>
                                  {box.destination}
                                  </StyledTableCell>
                                  <StyledTableCell align={"left"}>
                                  {box.shipping_Id}
                                  </StyledTableCell>
                                  <StyledTableCell align={"left"}>
                                  {box.customer_PO}
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
                  {/* <Box display="flex" justifyContent="flex-end">
                    <Pagination
                      count={Math.ceil(modesList.length / rowsPerPage)}
                      sx={{ mt: 2 }}
                      variant="outlined"
                      shape="rounded"
                      page={page}
                      onChange={handleChange}
                    />
                  </Box> */}
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
