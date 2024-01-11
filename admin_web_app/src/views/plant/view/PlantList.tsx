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
import React, { useState } from "react";
import SessionTimeoutPopup from "../../components/session_logout";
import AddIcon from "@mui/icons-material/Add";
import { AddUserModel } from "../../user/view/add-user";
import { Plant, useGetPlantQuery } from "../../../services/plant_service";
import { AddPlantModel } from "../add/add-plant";

const columns: GridColDef[] = [
  { field: "plantName", headerName: "Plant name", width: 250 },
  { field: "customers", headerName: "Customers", width: 250 },
  {
    field: "createdBy",
    headerName: "Created by",
    width: 250,
  },
  {
    field: "createdDate",
    headerName: "Created date & time",
    width: 250,
  },
];

export default function PlantList() {
  const { data, error, isLoading } = useGetPlantQuery("");
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
                          Plants
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
                              startIcon={<AddIcon />}
                              sx={{
                                backgroundColor: "#ff6d00",
                                "&:hover": { backgroundColor: "#ef6c00" },
                              }}
                              onClick={() => setOpen(true)}
                            >
                              ALLOCATE CUSTOMERS
                            </Button>
                          </Box>
                          <Box display="flex" justifyContent="flex-end">
                            <Button
                              variant="contained"
                              startIcon={<AddIcon />}
                              sx={{
                                backgroundColor: "#00e676",
                                mx: 1,
                                "&:hover": { backgroundColor: "#00c853" },
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
                                {data?.plants.map(
                                  (plant: Plant, index: any) => {
                                    return (
                                      <StyledTableRow
                                        id={plant.name}
                                        hover
                                        role="checkbox"
                                        tabIndex={-1}
                                      >
                                        <StyledTableCell align={"left"}>
                                          {plant.name}
                                        </StyledTableCell>
                                        <StyledTableCell align={"left"}>
                                          {plant.createdBy}
                                        </StyledTableCell>
                                        <StyledTableCell align={"left"}>
                                          {plant.createdBy}
                                        </StyledTableCell>
                                        <StyledTableCell align={"left"}>
                                          {plant.createdDateTime}
                                        </StyledTableCell>
                                      </StyledTableRow>
                                    );
                                  }
                                )}
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
            <AddPlantModel open={open} changeOpenStatus={setOpen} />
          </Box>
        )}
      </>
    );
  }
}
