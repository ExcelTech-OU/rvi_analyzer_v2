import { Box, Button, Container } from "@mui/material";
import { blue, green, grey } from "@mui/material/colors";
import { DataGrid, GridColDef, GridToolbar, GridValueGetterParams } from '@mui/x-data-grid';
import { useParams } from "react-router-dom";
import { GetSessionFilters, ModeOneDto, ModeOnesResponse, useGetModeOneSessionsQuery, UserTreatmentSession } from "../../services/sessions_service";
import { ModeOneSingleView } from './ModeOneSingleView'
import SessionTimeoutPopup from "../components/session_logout";



const columns: GridColDef[] = [
    {
        field: 'sessionId', headerName: 'Session Id', width: 150, valueGetter: (params: GridValueGetterParams) =>
            `${params.row.defaultConfigurations.sessionId}`,
    },
    {
        field: 'customerName',
        headerName: 'Customer name',
        width: 150,
        valueGetter: (params: GridValueGetterParams) =>
            `${params.row.defaultConfigurations.customerName}`,
    },
    {
        field: 'operatorId',
        headerName: 'Operator ID',
        width: 100,
        valueGetter: (params: GridValueGetterParams) =>
            `${params.row.defaultConfigurations.operatorId}`
    },


    {
        field: 'batchNo',
        headerName: 'Batch NO',
        width: 100,
        valueGetter: (params: GridValueGetterParams) =>
            `${params.row.defaultConfigurations.batchNo}`
    },
    {
        field: 'voltage',
        headerName: 'Voltage',
        width: 100,
        valueGetter: (params: GridValueGetterParams) =>
            `${params.row.sessionConfigurationModeOne.voltage}`
    },
    {
        field: 'maxCurrent',
        headerName: 'Max Current',
        width: 100,
        valueGetter: (params: GridValueGetterParams) =>
            `${params.row.sessionConfigurationModeOne.maxCurrent}`
    },
    {
        field: 'passMinCurrent',
        headerName: 'Pass Min Current',
        width: 200,
        valueGetter: (params: GridValueGetterParams) =>
            `${params.row.sessionConfigurationModeOne.passMinCurrent}`
    },
    {
        field: 'passMaxCurrent',
        headerName: 'Pass Max Current',
        width: 200,
        valueGetter: (params: GridValueGetterParams) =>
            `${params.row.sessionConfigurationModeOne.passMaxCurrent}`
    },
    {
        field: 'actions',
        headerName: 'Actions',
        type: 'actions',
        width: 100,
        renderCell: (params) => (
            <ModeOneSingleView session={params.row as ModeOneDto} />
        ),
    },
];

export default function ModeOneList() {

    var { data, error, isLoading } = useGetModeOneSessionsQuery({})

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
        return <Box
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
                                backgroundColor: '#1999ff',
                            },
                            "& .MuiDataGrid-virtualScroller": {
                                backgroundColor: grey[200],
                            },
                            "& .MuiDataGrid-footerContainer": {
                                backgroundColor: '#1999ff',
                            },
                            "& .MuiCheckbox-root": {
                                color: `${green[200]} !important`,
                            },
                        }}
                    >
                        <DataGrid
                            rows={data!.sessions.map((item, index) => ({ id: index + 1, ...item }))}
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
}
