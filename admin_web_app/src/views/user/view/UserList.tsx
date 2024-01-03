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
import CustomizedMenusUsers from "./custom-menu-user";
import React, { useState } from "react";
import SessionTimeoutPopup from "../../components/session_logout";
import AddIcon from "@mui/icons-material/Add";
import { AddUserModel } from "./add-user";

const columns: GridColDef[] = [
  { field: "email", headerName: "Email", width: 200 },
  {
    field: "group",
    headerName: "User Group",
    width: 150,
  },
  {
    field: "createdBy",
    headerName: "CreatedBy",
    width: 180,
  },
  {
    field: "createdDateTime",
    headerName: "Created Date",
    width: 250,
  },
  {
    field: "passwordType",
    headerName: "Password Status",
    width: 200,
  },
  {
    field: "enabled",
    headerName: "Status",
    width: 200,
  },
  {
    field: "actions",
    headerName: "Actions",
    type: "actions",
    width: 200,
  },
];

export default function UserList() {
  const { data, error, isLoading } = useGetUsersQuery("");
  const [pageCount, setPageCount] = React.useState(1);
  const [page, setPage] = React.useState(1);
  const handleChange = (event: React.ChangeEvent<unknown>, value: number) => {
    setPage(value);
  };

  const [open, setOpen] = useState(false);
  if (isLoading) {
    return <div>Loading...</div>;
  }

  if (error != null && "status" in error) {
    if (error.status == 401 && error.data == null) {
      return <SessionTimeoutPopup />;
    } else {
      return <></>;
    }
  } else {
    return (
      <>
        {isLoading ? (
          isLoading
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
                          Users
                        </Typography>
                        <Box display="flex" justifyContent="flex-end">
                          <Button
                            variant="contained"
                            startIcon={<AddIcon />}
                            color="success"
                            onClick={() => setOpen(true)}
                          >
                            ADD
                          </Button>
                        </Box>
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
                                {data!.users.map((item, index) => {
                                  return (
                                    <StyledTableRow
                                      //   id="index"
                                      hover
                                      role="checkbox"
                                      tabIndex={-1}
                                    >
                                      <StyledTableCell align={"left"}>
                                        {item.username}
                                      </StyledTableCell>
                                      <StyledTableCell align={"left"}>
                                        {item.group}
                                      </StyledTableCell>
                                      <StyledTableCell align={"left"}>
                                        {item.createdBy}
                                      </StyledTableCell>
                                      <StyledTableCell align={"left"}>
                                        {item.createdDateTime}
                                      </StyledTableCell>
                                      <StyledTableCell align={"left"}>
                                        {item.passwordType == "PASSWORD" ? (
                                          <Button
                                            variant="contained"
                                            color="success"
                                          >
                                            ACTIVE
                                          </Button>
                                        ) : item.passwordType == "DEFAULT" ? (
                                          <Button
                                            variant="contained"
                                            color="warning"
                                          >
                                            DEFAULT
                                          </Button>
                                        ) : (
                                          <Button
                                            variant="contained"
                                            color="error"
                                          >
                                            RESET
                                          </Button>
                                        )}
                                      </StyledTableCell>
                                      <StyledTableCell align={"left"}>
                                        {item.status == "ACTIVE" ? (
                                          <Button
                                            variant="contained"
                                            color="primary"
                                          >
                                            ACTIVE
                                          </Button>
                                        ) : (
                                          <Button
                                            variant="contained"
                                            color="error"
                                          >
                                            TEMPORARY_BLOCKED
                                          </Button>
                                        )}
                                      </StyledTableCell>
                                      <StyledTableCell align={"right"}>
                                        <CustomizedMenusUsers
                                          user={item as User}
                                        />
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
            <AddUserModel open={open} changeOpenStatus={setOpen} />
          </Box>
        )}
      </>
    );
  }
}
