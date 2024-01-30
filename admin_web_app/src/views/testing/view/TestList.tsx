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
import { AddTestModel } from "../add/add-test";
import { Style, useGetStyleQuery } from "../../../services/styles_service";
import {
  ParameterMode,
  Test,
  useGetTestQuery,
} from "../../../services/test_service";

const columns: GridColDef[] = [
  {
    field: "testGate",
    headerName: "Test Gate",
    width: 200,
  },
  {
    field: "parameterModes",
    headerName: "Parameter Modes",
    width: 200,
  },
  {
    field: "parameters",
    headerName: "Parameters",
    width: 200,
  },
  {
    field: "material",
    headerName: "Material",
    width: 200,
  },
  {
    field: "createdBy",
    headerName: "Created By",
    width: 180,
  },
  {
    field: "createdDateTime",
    headerName: "Created Date",
    width: 250,
  },
];

export default function TestList() {
  const { data, error, isLoading } = useGetTestQuery("");
  const [pageCount, setPageCount] = React.useState(1);
  const [page, setPage] = React.useState(1);
  const [users, setUsers] = useState<any>([]);
  var userRoles: string | string[] = [];
  var admin = "";
  // var testsList: List<Test> | undefined = [];
  // testsList = data?.tests;

  //get user roles from local storage
  if (localStorage.getItem("roles") === null) {
    admin = "ADMIN";
    console.log("roles empty");
  } else {
    userRoles = localStorage
      .getItem("roles")
      .split(",")
      .map((item) => item.trim());
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
                          Tests
                        </Typography>
                        <Box display="flex" justifyContent="flex-end">
                          <Button
                            variant="contained"
                            startIcon={<AddIcon />}
                            sx={{
                              backgroundColor: "#00e676",
                              "&:hover": { backgroundColor: "#00a152" },
                            }}
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
                                {data?.tests
                                  .map((item: Test, index: any) => {
                                    return (
                                      <StyledTableRow
                                        id={item.testGate}
                                        hover
                                        role="checkbox"
                                        tabIndex={-1}
                                      >
                                        <StyledTableCell align={"left"}>
                                          {item.testGate}
                                        </StyledTableCell>
                                        <StyledTableCell align={"left"}>
                                          {item.parameterModes.map(
                                            (object: ParameterMode) => {
                                              return (
                                                <Typography>
                                                  {object.name}
                                                </Typography>
                                              );
                                            }
                                          )}
                                        </StyledTableCell>
                                        <StyledTableCell align={"left"}>
                                          {item.parameterModes.map(
                                            (object: ParameterMode) => {
                                              return (
                                                <Typography>
                                                  {object.parameter}
                                                </Typography>
                                              );
                                            }
                                          )}
                                        </StyledTableCell>
                                        <StyledTableCell align={"left"}>
                                          {item.material}
                                        </StyledTableCell>
                                        <StyledTableCell align={"left"}>
                                          {item.createdBy}
                                        </StyledTableCell>
                                        <StyledTableCell align={"left"}>
                                          {item.createdDateTime}
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
            <AddTestModel open={open} changeOpenStatus={setOpen} />
          </Box>
        )}
      </>
    );
  }
}
