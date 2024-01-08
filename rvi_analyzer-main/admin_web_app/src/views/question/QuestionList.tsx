import { Box, Button, Container, gridClasses } from "@mui/material";
import { blue, green, grey } from "@mui/material/colors";
import { DataGrid, GridColDef, GridToolbar, GridValueGetterParams } from '@mui/x-data-grid';
import { Question, useGetQuestionsQuery } from "../../services/question_service";
import { QuestionActions } from "./QuestionActions";

const columns: GridColDef[] = [
    {
        field: 'id', headerName: 'Id', width: 100,

    },
    {
        field: 'question', headerName: 'Question', width: 600
    },
    {
        field: 'formFieldType', headerName: 'Form Felid Type', width: 250
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
                    DISABLED
                </Button>
        ),
    },
    {
        field: 'actions',
        headerName: 'Actions',
        type: 'actions',
        width: 200,
        renderCell: (params) => (
            params.row.formFieldType == "rate" ?
                <QuestionActions question={params.row as Question} /> : <></>
        ),
    },
];

export default function QuestionList() {
    const { data, error, isLoading } = useGetQuestionsQuery("")

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
                                rows={data!.questions.map(
                                    res =>
                                        res.question
                                )}
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
