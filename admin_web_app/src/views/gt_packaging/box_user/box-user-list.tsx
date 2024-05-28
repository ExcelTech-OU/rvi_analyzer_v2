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
  Alert,
  Snackbar,
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
import AddIcon from "@mui/icons-material/Add";
//   import SessionTimeoutPopup from "../../components/session_logout";
import { Download } from "@mui/icons-material";

import { useGetGtTracking_userQuery,useDeleteGtTracking_userMutation, gtTrackingUser } from "../../../services/gtTracking_user_service";

import DeleteIcon from "@mui/icons-material/Delete";

import { useState, useEffect } from "react";
// import MyComponent from "../../table_search_form_softmatter";
// import BasicDateRangePicker from "../datePicker";
// import { ModeSeven, useGetGtTestsMutation } from "../../../services/gt_service";
import { AnyObject } from "yup/lib/types";
import { List } from "reselect/es/types";
// import { useGetPOQuery } from "../../../services/po_service";
import { AddBoxUserModel } from "./add-box-user-list";
import CustomizedMenusUsers from "./custom-new-box-user";

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
  // {
  //   field: "Select",
  //   headerName: "Select",
  //   width: 80,
  // },

  {
    field: "user_email",
    headerName: "User email",
    width: 150,
  },
  {
    field: "user_name",
    headerName: "Created By",
    width: 150,
  },
  {
    field: "password",
    headerName: "Password",
    width: 150,
  },
  { 
    field: "action", 
    headerName: "Action", 
    width: 150 
  },
  {
    field: "actions",
    headerName: "Actions",
    type: "actions",
    width: 150,
  },
];
export default function BoxUserList() {
  // const [data, setData] = React.useState<any[]>([]);
  // const [isLoading, setIsLoading] = React.useState(false);
  const [selectedRows, setSelectedRows] = React.useState<number[]>([]);
  const [poList, setPOList] = useState<any>([]);
  const [open, setOpen] = useState(false);
  // const paginatedModes = modesList.slice(startIndex, endIndex);

  const { data, error, isLoading } = useGetGtTracking_userQuery("");
  const [deleteUser] = useDeleteGtTracking_userMutation();
  const [users, setUsers] = useState<gtTrackingUser[]>([]);

  const [openSuccess, setOpenSuccess] = React.useState(false);
  const [openFail, setOpenFail] = React.useState(false);
  const [message, setMessage] = useState("");

  const handleCloseSuccess = () => {
    setOpenSuccess(false);
  };

  const handleCloseFail = () => {
    setOpenFail(false);
  };

  const [values, setValues] = useState({
    field1: "",
    field2: "",
    field3: "",
    field4: "",
  });
  useEffect(() => {
    if (data && Array.isArray(data)) {
      setUsers(data);
    }
    
  }, [data]);

  // const fetchData = async () => {
  //   try {
  //     setIsLoading(true);
  //     const response = await fetch("http://52.187.127.25/api/getUsers");
  //     const jsonData = await response.json();
  //     if (response.ok) {
  //       setIsLoading(false);
  //       setData(jsonData);
  //     }
  //   } catch (error) {
  //     setIsLoading(false);
  //     console.error("Error fetching data:", error);
  //   }
  // };

  // async function deleteUser(userEmail: string): Promise<void> {
  //   // console.log(userEmail);
    
  //   const url = `http://52.187.127.25/api/deleteUser/${userEmail}`;

  //   try {
  //       const response = await fetch(url, {
  //           method: 'DELETE',
  //       });

  //       if (!response.ok) {
  //           throw new Error(`Failed to delete user: ${response.statusText}`);
  //       }

  //       console.log(`User ${userEmail} deleted successfully.`);
  //       setOpenSuccess(true);
  //   } catch (error) {
       
  //   }
  // }

  //   function getSelectedList(): any {
  //     return (
  //       paginatedModes.filter((item, index) => selectedRows.includes(index)) || []
  //     );
  //   }
  //   const [getAll] = useGetGtTestsMutation();

  // function getSelectedList(): any {
  //   console.log(selectedRows);

  //   return (
  //     users.filter((item, index) => selectedRows.includes(item.corBox_QR)) || []
  //   );
  // }

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
          {users.map((box) => (
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
                          GT packaging App Users
                        </Typography>
                      </Grid>
                      <Grid item xs={4} sm={2} md={6}>
                        <Box display="flex" justifyContent="flex-end">
                          <Button
                            variant="contained"
                            startIcon={<AddIcon />}
                            sx={{
                                mr: 2,
                              padding: 2,
                              backgroundColor: "#00e676",
                              "&:hover": { backgroundColor: "#00a152" },
                            }}
                            onClick={() => setOpen(true)}
                          >
                            ADD
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
                            {users
                              // .filter((item) => {
                              //   return (
                              //     item.corBox_QR.includes(values.field1) &&
                              //     item.destination.includes(values.field2) &&
                              //     item.shipping_Id.includes(values.field3) &&
                              //     item.customer_PO.includes(values.field4)
                              //   );
                              // })
                              .map((user) => {
                                return (
                                  <StyledTableRow
                                    hover
                                    role="checkbox"
                                    tabIndex={-1}
                                    key={user.user_email}
                                    // onClick={() =>
                                    //   handleRowClick(user.user_email)
                                    // }
                                    // selected={selectedRows.includes(
                                    //   user.user_email
                                    // )}
                                  >
                                    {/* <StyledTableCell align={"left"}>
                                      <input
                                        type="checkbox"
                                        checked={selectedRows.includes(
                                          user.user_name
                                        )}
                                      />
                                    </StyledTableCell> */}
                                    <StyledTableCell align={"left"}>
                                      {user.user_email}
                                    </StyledTableCell>
                                    <StyledTableCell align={"left"}>
                                      {user.user_name}
                                    </StyledTableCell>
                                    <StyledTableCell align={"left"}>
                                      {user.password}
                                    </StyledTableCell>
                                    <StyledTableCell align={"left"}>
                                      <Box
                                        display="flex"
                                        justifyContent="flex-center"
                                      >
                                        <Button
                                          variant="contained"
                                          startIcon={<DeleteIcon />}
                                          sx={{
                                            backgroundColor: "#f50057",
                                            mx: 1,
                                            "&:hover": {
                                              backgroundColor: "#ab003c",
                                            },
                                          }}
                                          onClick={() => {
                                            deleteUser({user_email: user.user_email,})
                                            .unwrap()
                                                  .then((payload) => {                                                    
                                                    if (
                                                      payload.message == "User Delete successfully!"
                                                    ) {
                                                      setOpenSuccess(true)
                                                      setMessage(payload.message)
                                                    }
                                                  })
                                                  .catch((error) => {
                                                    setOpenFail(true)
                                                    setMessage(error)
                                                  });
                                          }}
                                        >
                                          Delete
                                        </Button>
                                      </Box>
                                    </StyledTableCell>
                                    <Snackbar
                                      open={openSuccess}
                                      autoHideDuration={6000}
                                      onClose={handleCloseSuccess}
                                      anchorOrigin={{ vertical: "top", horizontal: "center" }}
                                    >
                                      <Alert
                                        onClose={handleCloseSuccess}
                                        severity="success"
                                        sx={{ width: "100%" }}
                                      >
                                        {message}
                                      </Alert>
                                    </Snackbar>
                                    <Snackbar
                                      open={openFail}
                                      autoHideDuration={6000}
                                      onClose={handleCloseFail}
                                      anchorOrigin={{ vertical: "top", horizontal: "center" }}
                                    >
                                      <Alert
                                        onClose={handleCloseFail}
                                        severity="error"
                                        sx={{ width: "100%" }}
                                      >
                                        {message}
                                      </Alert>
                                    </Snackbar>
                                    <StyledTableCell align={"right"}>
                                          <CustomizedMenusUsers
                                            user={user as gtTrackingUser}
                                          />
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
        <AddBoxUserModel open={open} changeOpenStatus={setOpen} />
      </Box>
    </div>
  );
}
