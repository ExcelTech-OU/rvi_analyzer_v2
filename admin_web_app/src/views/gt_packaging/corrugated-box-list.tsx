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
import { fi } from "date-fns/locale";
import { Field } from "formik";
import DatePickerComponentCorrugatedBox from "./date_picker_component_corrugated_box";

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
    headerName: "Corrugated Box QR",
    width: 150,
  },
  {
    field: "packagingBoxQr1",
    headerName: "Packaging Box Qr-1",
    width: 150,
  },
  {
    field: "packagingBoxQr2",
    headerName: "Packaging Box Qr-2",
    width: 150,
  },
  {
    field: "packagingBoxQr3",
    headerName: "Packaging Box Qr-3",
    width: 150,
  },
  {
    field: "packagingBoxQr4",
    headerName: "Packaging Box Qr-4",
    width: 150,
  },
  {
    field: "packagingBoxQr5",
    headerName: "Packaging Box Qr-5",
    width: 150,
  },
  {
    field: "packagingBoxQr6",
    headerName: "Packaging Box Qr-6",
    width: 150,
  },
  {
    field: "packagingBoxQr7",
    headerName: "Packaging Box Qr-7",
    width: 150,
  },
  {
    field: "packagingBoxQr8",
    headerName: "Packaging Box Qr-8",
    width: 150,
  },
  {
    field: "packagingBoxQr9",
    headerName: "Packaging Box Qr-9",
    width: 150,
  },
  {
    field: "packagingBoxQr10",
    headerName: "Packaging Box Qr-10",
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
    field5: "",
  });
  useEffect(() => {
    fetchData();
  }, []);


  const fetchData = async () => {
    try {
      setIsLoading(true);
      const response = await fetch("http://52.187.127.25/api/getCorWeb");
      const jsonData = await response.json();
      if (response.ok) {
        setIsLoading(false);
        setData(jsonData);
      }
    } catch (error) {
      setIsLoading(false);
      console.error("Error fetching data:", error);
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
      data.filter((item, index) => selectedRows.includes(item.corBox_Id)) || []
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

  const [packedDate, setPackedDate] = useState(null);

  const handleDateChange = (date: React.SetStateAction<null>) => {
    setPackedDate(date);
    console.log(packedDate);
  };

  if (isLoading) {
    return <div>Loading...</div>;
  }
  return (
    <div>
     
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
                              handleGenerateExcelCorrugatedBox(
                                getSelectedList()
                              )
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
                    <div
                      style={{
                        // marginLeft: "10px",
                        marginRight: "10px",
                        width: "250px",
                      }}
                    >
                      <DatePickerComponentCorrugatedBox
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
                            {data
                              .filter((item) => {
                                const itemDate = new Date(item.packed_date);                               
                                return (
                                  item.corBox_QR.includes(values.field1) &&
                                  item.destination.includes(values.field2) &&
                                  item.shipping_Id.includes(values.field3) &&
                                  item.customer_PO.includes(values.field4) &&
                                  item.packed_by.includes(values.field5) &&
                                  (!packedDate ||
                                    new Date(packedDate).toLocaleDateString() ===
                                      new Date(itemDate).toLocaleDateString())
                                );
                              })
                              .map((box) => {
                                return (
                                  <StyledTableRow
                                    hover
                                    role="checkbox"
                                    tabIndex={-1}
                                    key={box.corBox_Id}
                                    onClick={() =>
                                      handleRowClick(box.corBox_Id)
                                    }
                                    selected={selectedRows.includes(
                                      box.corBox_Id
                                    )}
                                  >
                                    <StyledTableCell align={"left"}>
                                      <input
                                        type="checkbox"
                                        checked={selectedRows.includes(
                                          box.corBox_Id
                                        )}
                                      />
                                    </StyledTableCell>
                                    <StyledTableCell align={"left"}>
                                      {box.corBox_QR}
                                    </StyledTableCell>
                                    <StyledTableCell align={"left"}>
                                      {box.retailQR_1}
                                    </StyledTableCell>
                                    <StyledTableCell align={"left"}>
                                      {box.retailQR_2}
                                    </StyledTableCell>
                                    <StyledTableCell align={"left"}>
                                      {box.retailQR_3}
                                    </StyledTableCell>
                                    <StyledTableCell align={"left"}>
                                      {box.retailQR_4}
                                    </StyledTableCell>
                                    <StyledTableCell align={"left"}>
                                      {box.retailQR_5}
                                    </StyledTableCell>
                                    <StyledTableCell align={"left"}>
                                      {box.retailQR_6}
                                    </StyledTableCell>
                                    <StyledTableCell align={"left"}>
                                      {box.retailQR_7}
                                    </StyledTableCell>
                                    <StyledTableCell align={"left"}>
                                      {box.retailQR_8}
                                    </StyledTableCell>
                                    <StyledTableCell align={"left"}>
                                      {box.retailQR_9}
                                    </StyledTableCell>
                                    <StyledTableCell align={"left"}>
                                      {box.retailQR_10}
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
                                    <StyledTableCell align={"left"}>
                                      {new Date(
                                        box.packed_date
                                      ).toLocaleDateString()}
                                    </StyledTableCell>
                                    <StyledTableCell align={"left"}>
                                      {box.packed_by}
                                    </StyledTableCell>
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
  );
}
