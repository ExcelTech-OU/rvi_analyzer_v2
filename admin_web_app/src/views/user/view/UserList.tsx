import { Box, Button, Container, gridClasses } from "@mui/material";
import { blue, green, grey } from "@mui/material/colors";
import { DataGrid, GridColDef, GridToolbar, GridValueGetterParams } from '@mui/x-data-grid';
import { useGetUsersQuery, User } from "../../../services/user_service";
import { UserActions } from "./UserActions";

const columns: GridColDef[] = [
    { field: 'name', headerName: 'Name', width: 250 },
    { field: 'email', headerName: 'Email', width: 250 },
    {
        field: 'age',
        headerName: 'Age',
        width: 180,
        valueGetter: (params: GridValueGetterParams) =>
            `${params.row.age || 'N/A'}`,
    },
    {
        field: 'occupation',
        headerName: 'Occupation',
        width: 180,
        valueGetter: (params: GridValueGetterParams) =>
            `${params.row.occupation || 'N/A'}`,
    },
    {
        field: 'condition',
        headerName: 'Condition',
        width: 250,
        valueGetter: (params: GridValueGetterParams) =>
            `${params.row.condition || 'N/A'}`,
    },
    {
        field: 'enabled',
        headerName: 'Status',
        width: 200,
        renderCell: (params) => (
            params.row.enabled ?
                <Button variant="contained" color="primary">
                    ACTIVE
                </Button> :
                <Button variant="contained" color="error">
                    TEMPORARY_BLOCKED
                </Button>
        ),
    },
    {
        field: 'actions',
        headerName: 'Actions',
        type: 'actions',
        width: 200,
        renderCell: (params) => (
            params.row.roleId == 2 ?
                <UserActions user={params.row as User} /> : <></>
        ),
    },
];

export default function UserList() {
    const { data, error, isLoading } = useGetUsersQuery("")

    return (
        <>
            {isLoading ? isLoading :
                <Box
                    component="main"
                    sx={{
                        flexGrow: 1,
                    }}
                >

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
                                rows={data!.users}
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
