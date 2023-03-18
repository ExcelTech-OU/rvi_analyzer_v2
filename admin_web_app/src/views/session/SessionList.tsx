import { Box, Button, Container } from "@mui/material";
import { blue, green, grey } from "@mui/material/colors";
import { DataGrid, GridColDef, GridToolbar, GridValueGetterParams } from '@mui/x-data-grid';
import { useState } from "react";
import { useParams } from "react-router-dom";
import { GetSessionFilters, useGetSessionsQuery, UserTreatmentSession } from "../../services/sessions_service";
import { SessionDetailsActions } from './SessionDetails'



const columns: GridColDef[] = [
    { field: 'protocolId', headerName: 'Profile', width: 70 },
    {
        field: 'device',
        headerName: 'Device',
        width: 150,
        valueGetter: (params: GridValueGetterParams) =>
            `${params.row.device.name}`,
    },
    {
        field: 'user',
        headerName: 'User',
        width: 200,
        valueGetter: (params: GridValueGetterParams) =>
            `${params.row.user.name}`
    },
    { field: 'initialSelectedTime', headerName: 'Selected Time(Sec)', width: 150 },
    {
        field: 'actualTreatmentTime',
        headerName: 'Actual Time(Sec)',
        width: 150
    },
    {
        field: 'selectedTemperature',
        headerName: 'Started Temp',
        width: 110,
    },
    {
        field: 'finalTemperature',
        headerName: 'Final Temp',
        width: 110,
    },
    {
        field: 'selectedPainLevel',
        headerName: 'Pain Level',
        width: 100,
    },
    {
        field: 'createdDate',
        headerName: 'Created Date',
        width: 220,
        valueGetter: (params: GridValueGetterParams) =>
            `${new Date(params.row.createdDate).toLocaleString() || ''}`,
    },
    {
        field: 'status',
        headerName: 'Status',
        width: 150,
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
        width: 100,
        renderCell: (params) => (
            <SessionDetailsActions session={params.row as UserTreatmentSession} />
        ),
    },
];

export default function SessionList() {
    var { type, id } = useParams();

    var filter: GetSessionFilters = {
        id: id == null ? "all" : id,
        type: type == null ? "all" : type
    }

    var { data, error, isLoading } = useGetSessionsQuery({ filter })

    return (
        <>
            {isLoading ? "Loading" :
                <Box
                    component="main"
                    sx={{
                        flexGrow: 1,
                    }}
                >

                    <Container maxWidth={false}>
                        <>
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
                                    rows={data!.sessions}
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
                            {console.log(data?.sessions)}
                        </>
                    </Container>
                </Box>
            }

        </>
    )
}
