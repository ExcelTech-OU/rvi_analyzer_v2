import {
  Box,
  Button,
  Card,
  CardActionArea,
  CardContent,
  Container,
  Divider,
  Pagination,
  Paper,
  Table,
  TableBody,
  TableContainer,
  TableHead,
  Typography,
} from "@mui/material";
import { GridColDef } from "@mui/x-data-grid";
import { useGetUsersQuery, User } from "../../../services/user_service";
import { StyledTableCell, StyledTableRow } from "../../mode_one/mode-one-list";
import CustomizedMenusUsers from "../../user/view/custom-menu-user";
import { List } from "reselect/es/types";
import React, { useEffect, useState } from "react";
import SessionTimeoutPopup from "../../components/session_logout";
import AddIcon from "@mui/icons-material/Add";
import DeleteIcon from "@mui/icons-material/Delete";
import AddLinkIcon from "@mui/icons-material/AddLink";
import PersonAddIcon from "@mui/icons-material/PersonAdd";
import { AddStyleModel } from "../add/add-style";
import {
  Style,
  useDeleteStyleMutation,
  useGetStyleQuery,
} from "../../../services/styles_service";
import {
  Customer,
  useGetCustomerQuery,
} from "../../../services/customer_service";
import { AllocateAdminsModel } from "../add/allocate-admins";

const columns: GridColDef[] = [
  { field: "name", headerName: "Name", width: 200 },
  {
    field: "customer",
    headerName: "Customer",
    width: 200,
  },
  {
    field: "plant",
    headerName: "Plant",
    width: 200,
  },
  {
    field: "assignedTo",
    headerName: "Assigned To",
    width: 200,
  },
  {
    field: "createdBy",
    headerName: "Created By",
    width: 180,
  },
  {
    field: "action",
    headerName: "Action",
    width: 250,
  },
];

export default function StyleList() {
  const {
    data: styleData,
    error: styleError,
    isLoading: styleLoading,
  } = useGetStyleQuery("");
  const [pageCount, setPageCount] = React.useState(1);
  const [page, setPage] = React.useState(1);
  var userRoles: string | string[] = [];
  var admin = "";
  const [open, setOpen] = useState(false);
  var roles = localStorage.getItem("roles");
  const [deleteStyle] = useDeleteStyleMutation();

  //get user roles from local storage
  if (roles === null) {
    admin = "ADMIN";
    console.log("roles empty");
  } else {
    userRoles = roles.split(",").map((item) => item.trim());
    if (
      userRoles.includes("CREATE_TOP_ADMIN") &&
      userRoles.includes("CREATE_ADMIN")
    ) {
      admin = "TOP_ADMIN";
    } else if (userRoles.includes("CREATE_USER")) {
      admin = "ADMIN";
    }
  }

  const handleChange = (event: React.ChangeEvent<unknown>, value: number) => {
    setPage(value);
  };

  const [openAdminAllocation, setOpenAdminAllocation] = useState(false);
  if (styleLoading) {
    return <div>Loading...</div>;
  }

  if (styleError != null && "status" in styleError) {
    if (styleError.status == 401 && styleError.data == null) {
      return <SessionTimeoutPopup />;
    } else {
      return <></>;
    }
  } else {
    return (
      <>
        {styleLoading ? (
          styleLoading
        ) : (
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
                      backgroundColor: "#FFFFFF",
                      boxShadow: "1px 1px 10px 10px #e8e8e8",
                    }}
                  >
                    <CardActionArea>
                      <CardContent sx={{}}>
                        <Typography
                          gutterBottom
                          variant="h5"
                          component="div"
                          color="grey"
                        >
                          Styles
                        </Typography>
                        <Container
                          sx={{
                            display: "flex",
                            flexDirection: "row-reverse",
                            padding: 0,
                          }}
                        >
                          <Box display="flex" justifyContent="flex-end">
                            <Button
                              variant="contained"
                              startIcon={<PersonAddIcon />}
                              sx={{
                                backgroundColor: "#ff6d00",
                                "&:hover": { backgroundColor: "#ef6c00" },
                              }}
                              onClick={() => setOpenAdminAllocation(true)}
                            >
                              ALLOCATE ADMINS
                            </Button>
                          </Box>
                          <Box display="flex" justifyContent="flex-end">
                            <Button
                              variant="contained"
                              startIcon={<AddIcon />}
                              sx={{
                                backgroundColor: "#00e676",
                                "&:hover": { backgroundColor: "#00a152" },
                                mx: 1,
                              }}
                              onClick={() => setOpen(true)}
                            >
                              ADD
                            </Button>
                          </Box>
                        </Container>

                        <Divider
                          sx={{
                            borderColor: "grey",
                            my: 1.5,
                            borderStyle: "dashed",
                          }}
                        />
                        {/* <TableSearchForm searchFun={setSearchParams}></TableSearchForm> */}
                        <Divider
                          sx={{
                            borderColor: "grey",
                            my: 1.5,
                            borderStyle: "dashed",
                          }}
                        />
                        <Paper
                          sx={{
                            width: "100%",
                            overflow: "hidden",
                          }}
                        >
                          <TableContainer sx={{ maxHeight: 440 }}>
                            <Table
                              stickyHeader
                              aria-label="sticky table"
                              sx={{ overflowX: "auto" }}
                            >
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
                                {styleData?.styles
                                  .map((item: Style, index: any) => {
                                    return (
                                      <StyledTableRow
                                        id={index}
                                        hover
                                        role="checkbox"
                                        tabIndex={-1}
                                        // sx={{ width: 100 }}
                                      >
                                        <StyledTableCell align={"left"}>
                                          {item.name}
                                        </StyledTableCell>
                                        <StyledTableCell align={"left"}>
                                          {item.customer}
                                        </StyledTableCell>
                                        <StyledTableCell align={"left"}>
                                          {item.plant}
                                        </StyledTableCell>
                                        <StyledTableCell align={"left"}>
                                          {item.admin.map((object: String) => {
                                            return (
                                              <Typography>{object}</Typography>
                                            );
                                          })}
                                        </StyledTableCell>
                                        <StyledTableCell align={"left"}>
                                          {item.createdBy}
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
                                                deleteStyle({
                                                  name: item.name,
                                                })
                                                  .unwrap()
                                                  .then((payload) => {
                                                    if (
                                                      payload.status == "S1000"
                                                    ) {
                                                      // setOpenSuccess(true)
                                                      console.log(
                                                        "style deleted"
                                                      );
                                                    }
                                                  })
                                                  .catch((error) => {
                                                    // setOpenFail(true)
                                                    console.log("failed");
                                                  });
                                              }}
                                            >
                                              Delete
                                            </Button>
                                          </Box>
                                        </StyledTableCell>
                                      </StyledTableRow>
                                    );
                                  })
                                  .reverse()}
                              </TableBody>
                            </Table>
                          </TableContainer>
                        </Paper>
                        <Box display="flex" justifyContent="flex-end">
                          <Pagination
                            count={pageCount}
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
            <AddStyleModel open={open} changeOpenStatus={setOpen} />
            <AllocateAdminsModel
              open={openAdminAllocation}
              changeOpenStatus={setOpenAdminAllocation}
            />
          </Box>
        )}
      </>
    );
  }
}
