import { Add } from "@mui/icons-material";
import { Box, Button, Card, CardActionArea, CardContent, Container, Divider, Pagination, Paper, Table, TableBody, TableContainer, TableHead, Typography, gridClasses } from "@mui/material";
import { blue, green, grey } from "@mui/material/colors";
import { DataGrid, GridColDef, GridToolbar, GridValueGetterParams } from '@mui/x-data-grid';
import React, { useState } from "react";
import { Device, useGetDevicesQuery } from "../../../services/device_service";
import { AddDevice } from "../add/AddDevice";
import { DeviceActions } from './DeviceActions'
import SessionTimeoutPopup from "../../components/session_logout";
import { StyledTableCell, StyledTableRow } from "../../mode_one/mode-one-list";


const columns: GridColDef[] = [
    { field: 'name', headerName: 'Device Name', width: 200 },
    { field: 'macAddress', headerName: 'Mac Address', width: 200 },
    {
        field: 'createdBy',
        headerName: 'Created By',
        width: 200
    },
    // {
    //     field: 'batchNo',
    //     headerName: 'Batch No',
    //     width: 100,
    // },
    {
        field: 'createdDateTime',
        headerName: 'Created Date',
        width: 300,
        valueGetter: (params: GridValueGetterParams) =>
            `${new Date(params.row.createdDate).toLocaleString() || ''}`,
    },
    {
        field: 'status',
        headerName: 'Status',
        width: 250,
        renderCell: (params) => (
            params.row.status == 'ACTIVE' ?
                <Button variant="contained" color="primary">
                    {params.row.status}
                </Button> : params.row.status == 'DISABLED' ?
                    <Button variant="contained" color="error">
                        {params.row.status}
                    </Button> : <Button variant="contained" color="warning">
                        {params.row.status}
                    </Button>
        ),
    },
    // {
    //     field: 'actions',
    //     headerName: 'Actions',
    //     type: 'actions',
    //     width: 200,
    // },
];

export default function DeviceList() {
    const { data, error, isLoading } = useGetDevicesQuery("")
    const [pageCount, setPageCount] = React.useState(1);
    const [page, setPage] = React.useState(1);
    const handleChange = (event: React.ChangeEvent<unknown>, value: number) => {
        setPage(value);
    };

    const [open, setOpen] = useState(false);

    const handleClickOpen = () => {
        setOpen(true);
    };

    const handleClose = () => {
        setOpen(false);
    };

    if (isLoading) {
        return <div>Loading...</div>
    }

    if (error != null && 'status' in error) {
        if (error.status == 401 && error.data == null) {
            return <SessionTimeoutPopup />
        }
        else {
            return <></>
        }
    } else {
        return (
            <>
                {isLoading ? isLoading :
                    <Box
                        component="main"
                        sx={{
                            flexGrow: 1,
                        }}
                    >
                        {/* <Box sx={{ ml: 3 }} >
                            <Button variant="contained" startIcon={<Add />} onClick={handleClickOpen}>
                                Add Device
                            </Button>
                        </Box> */}

                        {/* <AddDevice openModel={open} close={() => handleClose()} /> */}

                        <Container maxWidth={false}>
                            <>
                                <Box
                                    m="0px 0 0 0"
                                    sx={{}}
                                >
                                    <Card sx={{ maxWidth: 1600, backgroundColor: "#FFFFFF", boxShadow: "1px 1px 10px 10px #e8e8e8" }}>
                                        <CardActionArea>

                                            <CardContent sx={{}}>
                                                <Typography gutterBottom variant="h5" component="div" color="grey">
                                                    Devices
                                                </Typography>
                                                {/* <Box display="flex" justifyContent="flex-end">
                                                    <Button variant="contained" startIcon={<AddIcon />} color="success" onClick={() => setOpen(true)}>
                                                        ADD
                                                    </Button>
                                                </Box> */}
                                                <Divider
                                                    sx={{
                                                        borderColor: 'grey',
                                                        my: 1.5,
                                                        borderStyle: 'dashed'
                                                    }}
                                                />
                                                {/* <TableSearchForm searchFun={setSearchParams}></TableSearchForm> */}
                                                <Divider
                                                    sx={{
                                                        borderColor: 'grey',
                                                        my: 1.5,
                                                        borderStyle: 'dashed'
                                                    }}
                                                />
                                                <Paper sx={{ width: '100%', overflow: 'hidden' }}>
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
                                                                {data!.devices
                                                                    .map((item, index) => {
                                                                        return (
                                                                            <StyledTableRow hover role="checkbox" tabIndex={-1} >
                                                                                <StyledTableCell align={'left'}>
                                                                                    {item.name}
                                                                                </StyledTableCell>
                                                                                <StyledTableCell align={'left'}>
                                                                                    {item.macAddress}
                                                                                </StyledTableCell>
                                                                                <StyledTableCell align={'left'}>
                                                                                    {item.createdBy}
                                                                                </StyledTableCell>
                                                                                <StyledTableCell align={'left'}>
                                                                                    {item.createdDateTime}
                                                                                </StyledTableCell>

                                                                                <StyledTableCell align={'left'}>
                                                                                    {item.status == 'ACTIVE' ?
                                                                                        <Button variant="contained" color="primary">
                                                                                            {item.status}
                                                                                        </Button> : item.status == 'DISABLED' ?
                                                                                            <Button variant="contained" color="error">
                                                                                                {item.status}
                                                                                            </Button> : <Button variant="contained" color="warning">
                                                                                                {item.status}
                                                                                            </Button>}
                                                                                </StyledTableCell>
                                                                                {/* <StyledTableCell align={'right'}>
                                                                                    <CustomizedMenusUsers user={item as Device} />
                                                                                </StyledTableCell> */}
                                                                            </StyledTableRow>
                                                                        );
                                                                    })}
                                                            </TableBody>
                                                        </Table>
                                                    </TableContainer>
                                                </Paper>
                                                <Box display="flex" justifyContent="flex-end">
                                                    <Pagination count={pageCount} sx={{ mt: 2 }} variant="outlined" shape="rounded" page={page} onChange={handleChange} />
                                                </Box>
                                            </CardContent>
                                        </CardActionArea>
                                    </Card>

                                </Box>
                            </>
                        </Container>
                    </Box>
                }

            </>
        );
    }
}
