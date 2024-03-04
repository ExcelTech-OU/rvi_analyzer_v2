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
// import { FullGarment, useGetAllELQCMutation, useGetELQCQuery } from "../../../services/softmatter_service";
// import TableSearchFormSoftmatter from "../table_search_form_softmatter";
import SessionTimeoutPopup from "../../components/session_logout";
import { handleGenerateExcelEndLineQc } from "./end_line_qc-excel";
import { Download } from "@mui/icons-material";

import { useState, useEffect } from "react";
import MyComponent from "../table_search_form_softmatter";
import BasicDateRangePicker from "../datePicker";
import { ModeSeven, useGetGtTestsMutation } from "../../../services/gt_service";
import { AnyObject } from "yup/lib/types";
import { List } from "reselect/es/types";
import { useGetPOQuery } from "../../../services/po_service";

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
    field: "customerId",
    headerName: "Customer Id",
    width: 150,
  },
  {
    field: "macAddress",
    headerName: "Mac Address",
    width: 100,
  },
  {
    field: "productionOrder",
    headerName: "productionOrder",
    width: 100,
  },
  {
    field: "operatorId",
    headerName: "Operator Id",
    width: 100,
  },
  {
    field: "voltage",
    headerName: "Voltage",
    width: 100,
  },
  {
    field: "current",
    headerName: "Current",
    width: 80,
  },
  {
    field: "resistance",
    headerName: "Resistance",
    width: 100,
  },
  {
    field: "ledSequence",
    headerName: "LED Sequence",
    width: 100,
  },
  {
    field: "date",
    headerName: "Date",
    width: 150,
  },
  {
    field: "time",
    headerName: "Time",
    width: 150,
  },
];

export default function EndLineQcList() {
  const [date, setDate] = React.useState<Date | null>(null);
  const [filterType, setFilterType] = React.useState("DATE_CODE");
  const [filterValue, setFilterValue] = React.useState("");
  const [open, setOpen] = React.useState(false);
  const {
    data: poData,
    error: poError,
    isLoading: poLoading,
  } = useGetPOQuery("");
  const [getGtTests, { data, error, isLoading }] = useGetGtTestsMutation();
  const [selectedRows, setSelectedRows] = React.useState<number[]>([]);
  const [feed, setFeed] = useState(false);
  const [poList, setPOList] = useState<any>([]);
  var filteredData: ModeSeven[] = [];
  const [values, setValues] = useState({
    field1: "",
    field2: "",
    field3: "",
  });
  const [rowsPerPage, setRowsPerPage] = useState(5);
  const [page, setPage] = useState(1);
  const [modesList, setModesList] = useState<List<ModeSeven>>([]);

  const startIndex = (page - 1) * rowsPerPage;
  const endIndex = startIndex + rowsPerPage;
  const paginatedModes = modesList.slice(startIndex, endIndex);
  // var paginatedModes: ModeSeven[] = [];
  // paginatedModes = modesList.slice(startIndex, endIndex);

  useEffect(() => {}, [data]);

  const handleInputChange = (field: string, value: string) => {
    setValues((prevValues) => ({
      ...prevValues,
      [field]: value,
    }));
  };

  // useEffect(() => {
  //   if (data?.sessions) {
  //     paginatedModes = data?.sessions
  //       .filter((item: ModeSeven) => {
  //         const itemDate = new Date(item.createdDateTime);
  //         return (
  //           item.result.reading.macAddress.includes(values.field1) &&
  //           item.result.reading.productionOrder.includes(values.field2) &&
  //           item.result.reading.result.includes(values.field3) &&
  //           (!startingDate || new Date(itemDate) >= new Date(startingDate)) &&
  //           (!finishingDate || new Date(itemDate) <= new Date(finishingDate))
  //         );
  //       })
  //       .map((item) => ({
  //         field1: item.result.reading.macAddress,
  //         field2: item.result.reading.productionOrder,
  //         field3: item.result.reading.result,
  //         createdDateTime: item.createdDateTime,
  //       }));

  //     console.log(paginatedModes);
  //   }
  // }, [values]);

  useEffect(() => {
    getGtTests({});
    setFeed(true);
  }, []);

  useEffect(() => {
    if (poData && poData.orders) {
      setPOList(poData.orders);
    }
    if (data?.sessions) {
      setModesList(data?.sessions);
    }
  }, [data]);

  function getSelectedList(): any {
    return (
      paginatedModes.filter((item, index) => selectedRows.includes(index)) || []
    );
  }
  const [getAll] = useGetGtTestsMutation();

  const handleRowClick = (id: number) => {
    if (selectedRows.includes(id)) {
      setSelectedRows(selectedRows.filter((rowId) => rowId !== id));
    } else {
      setSelectedRows([...selectedRows, id]);
    }
  };

  const [startingDate, setStartingDate] = useState(null);
  const [finishingDate, setFinishingDate] = useState(null);

  const handleStartingDateChange = (date: React.SetStateAction<null>) => {
    setStartingDate(date);
    console.log(startingDate);
  };

  const handleFinishingDateChange = (date: React.SetStateAction<null>) => {
    setFinishingDate(date);
    console.log(finishingDate);
  };

  const handleChange = (event: React.ChangeEvent<unknown>, value: number) => {
    setPage(value);
  };

  if (isLoading) {
    return <div>Loading...</div>;
  }
  return (
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
                        Gamertech testing
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
                            handleGenerateExcelEndLineQc(getSelectedList())
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
                            getAll({
                              data: {
                                date: date,
                                filterType: filterType,
                                filterValue: filterValue,
                              },
                              page: "all",
                            })
                              .unwrap()
                              .then((payload) => {
                                filteredData = payload.sessions.filter(
                                  (item) => {
                                    const itemDate = new Date(
                                      item.createdDateTime
                                    );

                                    const originalFilterCondition =
                                      item.result.reading.macAddress.includes(
                                        values.field1
                                      ) &&
                                      item.result.reading.productionOrder.includes(
                                        values.field2
                                      ) &&
                                      item.result.reading.result.includes(
                                        values.field3
                                      ) &&
                                      (!startingDate ||
                                        new Date(itemDate) >=
                                          new Date(startingDate)) &&
                                      (!finishingDate ||
                                        new Date(itemDate) <=
                                          new Date(finishingDate));

                                    return originalFilterCondition;
                                  }
                                );

                                handleGenerateExcelEndLineQc(filteredData);
                              });
                          }}
                        >
                          Download
                        </Button>
                      </Box>
                    </Grid>
                    <Grid
                      item
                      xs={4}
                      sm={8}
                      md={12}
                      sx={{ mt: 1, maxHeight: "100%" }}
                    >
                      <Box display="flex" justifyContent="flex-end">
                        <Typography
                          gutterBottom
                          variant="h6"
                          component="div"
                          color="grey"
                          sx={{ mr: 4 }}
                        >
                          {"TOTAL : " + data?.total}
                        </Typography>
                        <Typography
                          gutterBottom
                          variant="h6"
                          component="div"
                          color="grey"
                          sx={{ mr: 4 }}
                        >
                          PASSED :{" "}
                          {data?.sessions
                            ? data?.sessions.filter((item: ModeSeven) => {
                                return item.result.reading.result !== "FAIL";
                              }).length
                            : 0}
                        </Typography>
                        <Typography
                          gutterBottom
                          variant="h6"
                          component="div"
                          color="grey"
                        >
                          FAILED :{" "}
                          {data?.sessions
                            ? data?.sessions.filter((item: ModeSeven) => {
                                return item.result.reading.result === "FAIL";
                              }).length
                            : 0}
                        </Typography>
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
                    <MyComponent
                      initialValues={values}
                      onInputChange={handleInputChange}
                      orders={poList}
                    />

                    <div
                      style={{
                        marginLeft: "10px",
                        marginRight: "10px",
                        width: "250px",
                      }}
                    >
                      <BasicDateRangePicker
                        label="Starting Date"
                        onChange={handleStartingDateChange}
                      />
                    </div>

                    <div style={{ marginRight: "10px", width: "250px" }}>
                      <BasicDateRangePicker
                        label="Finishing Date"
                        onChange={handleFinishingDateChange}
                      />
                    </div>
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
                          {paginatedModes
                            .filter((item: ModeSeven) => {
                              const itemDate = new Date(item.createdDateTime);
                              return (
                                item.result.reading.macAddress.includes(
                                  values.field1
                                ) &&
                                item.result.reading.productionOrder.includes(
                                  values.field2
                                ) &&
                                item.result.reading.result.includes(
                                  values.field3
                                ) &&
                                (!startingDate ||
                                  new Date(itemDate) >=
                                    new Date(startingDate)) &&
                                (!finishingDate ||
                                  new Date(itemDate) <= new Date(finishingDate))
                              );
                            })
                            .map((item: ModeSeven, index: any) => {
                              return (
                                <StyledTableRow
                                  hover
                                  role="checkbox"
                                  tabIndex={-1}
                                  key={index}
                                  onClick={() => handleRowClick(index)}
                                  selected={selectedRows.includes(index)}
                                >
                                  <StyledTableCell align={"left"}>
                                    <input
                                      type="checkbox"
                                      checked={selectedRows.includes(index)}
                                    />
                                  </StyledTableCell>
                                  <StyledTableCell align={"left"}>
                                    {item.defaultConfigurations.customerName}
                                  </StyledTableCell>
                                  <StyledTableCell align={"left"}>
                                    {item.result.reading.macAddress}
                                  </StyledTableCell>
                                  <StyledTableCell align={"left"}>
                                    {item.result.reading.productionOrder}
                                  </StyledTableCell>
                                  <StyledTableCell align={"left"}>
                                    {item.defaultConfigurations.operatorId}
                                  </StyledTableCell>
                                  <StyledTableCell align={"left"}>
                                    {item.result.reading.voltage}
                                  </StyledTableCell>
                                  <StyledTableCell align={"left"}>
                                    {item.result.reading.current}
                                  </StyledTableCell>
                                  <StyledTableCell align={"left"}>
                                    {item.result.reading.resistance}
                                  </StyledTableCell>
                                  <StyledTableCell align={"left"}>
                                    {item.result.reading.result}
                                  </StyledTableCell>
                                  <StyledTableCell align={"left"}>
                                    {item.createdDateTime.split("T")[0]}
                                  </StyledTableCell>
                                  <StyledTableCell align={"left"}>
                                    {item.createdDateTime.split("T")[1]}
                                  </StyledTableCell>
                                </StyledTableRow>
                              );
                            })}
                        </TableBody>
                      </Table>
                    </TableContainer>
                  </Paper>
                  <Box display="flex" justifyContent="flex-end">
                    <Pagination
                      count={Math.ceil(modesList.length / rowsPerPage)}
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
  );
}
