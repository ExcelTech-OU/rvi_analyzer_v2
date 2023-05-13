import { Box, Button, Card, CardActionArea, CardContent, CardMedia, Container, Divider, Typography } from "@mui/material";
import { blue, green, grey } from "@mui/material/colors";
import { DataGrid, GridColDef, GridPagination, GridToolbar, GridToolbarDensitySelector, GridToolbarExport, GridValueGetterParams } from '@mui/x-data-grid';
import { ModeOneDto, ModeOnesResponse, useGetModeOneSessionsQuery, UserTreatmentSession } from "../../services/sessions_service";
import { ModeOneSingleView } from './ModeOneSingleView'
import SessionTimeoutPopup from "../components/session_logout";
import TableSearchForm from "../components/table_search_form";
import CustomizedMenus from "../components/custom-menu";



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
            <CustomizedMenus />
            // <ModeOneSingleView session={params.row as ModeOneDto} />
        ),
    },
];

export default function ModeOneList() {

    var { data, error, isLoading } = useGetModeOneSessionsQuery({ date: "", filterType: "CREATED_BY", filterValue: "ruk" })

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
                        m="0px 0 0 0"
                        height="60vh"
                        sx={{
                            "& .MuiDataGrid-root": {
                            },
                            "& .MuiDataGrid-cell": {
                            },
                            "& .name-column--cell": {
                                color: '#7bcfed',
                            },
                            "& .MuiDataGrid-columnHeaders": {
                                backgroundColor: '#7bcfed',
                            },
                            "& .MuiDataGrid-virtualScroller": {
                                backgroundColor: 'rgba(255,255,255, 0.08)',
                            },
                            "& .MuiDataGrid-footerContainer": {
                                backgroundColor: '#7bcfed',
                            },
                            "& .MuiCheckbox-root": {
                                color: `${green[200]} !important`,
                            },
                        }}
                    >
                        <Card sx={{ maxWidth: 1600, height: '80vh' }}>
                            <CardActionArea>

                                <CardContent sx={{ height: '80vh' }}>
                                    <Typography gutterBottom variant="h5" component="div" color="grey">
                                        Mode One
                                    </Typography>
                                    <Divider
                                        sx={{
                                            borderColor: 'grey',
                                            my: 1.5,
                                            borderStyle: 'dashed'
                                        }}
                                    />
                                    <TableSearchForm></TableSearchForm>
                                    <Divider
                                        sx={{
                                            borderColor: 'grey',
                                            my: 1.5,
                                            borderStyle: 'dashed'
                                        }}
                                    />
                                    <DataGrid
                                        sx={{ mt: 2, height: "50vh" }}
                                        rows={data!.sessions.map((item, index) => ({ id: index + 1, ...item }))}
                                        columns={columns}
                                        pageSize={100}
                                        rowsPerPageOptions={[100]}
                                        disableSelectionOnClick
                                        experimentalFeatures={{ newEditingApi: true }}
                                    // components={{
                                    //     Toolbar: GridToolbarDensitySelector,

                                    // }}
                                    />
                                </CardContent>
                            </CardActionArea>
                        </Card>

                    </Box>
                </>
            </Container>
        </Box>
    }
}
