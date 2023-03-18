import { Add } from "@mui/icons-material";
import { Box, Button, Container, gridClasses } from "@mui/material";
import { blue, green, grey } from "@mui/material/colors";
import { DataGrid, GridColDef, GridToolbar, GridValueGetterParams } from '@mui/x-data-grid';
import { useState } from "react";
import { Device, useGetDevicesQuery } from "../../../services/device_service";
import { AddDevice } from "../add/AddDevice";
import { DeviceActions } from './DeviceActions'


const columns: GridColDef[] = [
    { field: 'name', headerName: 'Device Name', width: 200 },
    { field: 'macAddress', headerName: 'Mac Address', width: 200 },
    {
        field: 'firmwareVersion',
        headerName: 'Firmware Version',
        width: 200
    },
    {
        field: 'batchNo',
        headerName: 'Batch No',
        width: 100,
    },
    {
        field: 'createdDate',
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
    {
        field: 'actions',
        headerName: 'Actions',
        type: 'actions',
        width: 200,
        renderCell: (params) => (
            <DeviceActions device={params.row as Device} />
        ),
    },
];

export default function Devices() {
    const { data, error, isLoading } = useGetDevicesQuery("")

    const [open, setOpen] = useState(false);

    const handleClickOpen = () => {
        setOpen(true);
    };

    const handleClose = () => {
        setOpen(false);
    };

    return (
        <>
            {isLoading ? isLoading :
                <Box
                    component="main"
                    sx={{
                        flexGrow: 1,
                    }}
                >
                    <Box sx={{ ml: 3 }} >
                        <Button variant="contained" startIcon={<Add />} onClick={handleClickOpen}>
                            Add Device
                        </Button>
                    </Box>

                    <AddDevice openModel={open} close={() => handleClose()} />

                    <Container maxWidth={false}>
                        <Box
                            m="20px 0 0 0"
                            height="75vh"
                            sx={{
                                "& .MuiDataGrid-root": {
                                },
                                "& .MuiDataGrid-cell": {
                                },
                                "& .name-column--cell": {
                                    color: blue[300],
                                },
                                "& .MuiDataGrid-columnHeaders": {
                                    backgroundColor: '#22C55E',
                                },
                                "& .MuiDataGrid-virtualScroller": {
                                    backgroundColor: grey[200],
                                },
                                "& .MuiDataGrid-footerContainer": {
                                    backgroundColor: '#22C55E',
                                },
                                "& .MuiCheckbox-root": {
                                    color: `${green[200]} !important`,
                                },
                            }}
                        >
                            <DataGrid
                                rows={data!.devices}
                                columns={columns}
                                pageSize={100}
                                rowsPerPageOptions={[100]}
                                disableSelectionOnClick
                                experimentalFeatures={{ newEditingApi: true }}
                                components={{
                                    Toolbar: GridToolbar,
                                }}
                            />
                        </Box>
                    </Container>
                </Box>
            }

        </>
    )
}
