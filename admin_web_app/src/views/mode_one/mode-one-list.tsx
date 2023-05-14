import { Box, Button, Card, CardActionArea, CardContent, CardMedia, Container, Divider, Typography } from "@mui/material";
import { blue, green, grey } from "@mui/material/colors";
import { GridColDef } from '@mui/x-data-grid';
import { ModeOneDto, ModeOnesResponse, useGetModeOneSessionsQuery, UserTreatmentSession } from "../../services/sessions_service";
import { ModeOneSingleView } from './mode-one-single-view'
import SessionTimeoutPopup from "../components/session_logout";
import TableSearchForm from "../components/table_search_form";
import CustomizedMenus from "./custom-menu-mode-one";
import StickyHeadTable from "../components/table-test";
import * as React from 'react';
import Paper from '@mui/material/Paper';
import Table from '@mui/material/Table';
import TableBody from '@mui/material/TableBody';
import TableCell, { tableCellClasses } from '@mui/material/TableCell';
import TableContainer from '@mui/material/TableContainer';
import TableHead from '@mui/material/TableHead';
import TablePagination from '@mui/material/TablePagination';
import TableRow from '@mui/material/TableRow';
import { styled } from '@mui/material';
import { format } from "date-fns";


export const StyledTableCell = styled(TableCell)(({ theme }) => ({
    [`&.${tableCellClasses.head}`]: {
        backgroundColor: '#9e9e9e',
        color: theme.palette.common.white,
    },
    [`&.${tableCellClasses.body}`]: {
        fontSize: 14,
    },
}));

export const StyledTableRow = styled(TableRow)(({ theme }) => ({
    '&:nth-of-type(odd)': {
        backgroundColor: theme.palette.action.hover,
    },
    // hide last border
    '&:last-child td, &:last-child th': {
        border: 0,
    },
}));

const columns: GridColDef[] = [
    {
        field: 'sessionId', headerName: 'Session Id', width: 150,
    },
    {
        field: 'customerName',
        headerName: 'Customer name',
        width: 100,
    },
    {
        field: 'operatorId',
        headerName: 'Operator ID',
        width: 80,
    },
    {
        field: 'batchNo',
        headerName: 'Batch NO',
        width: 100,
    },
    {
        field: 'voltage',
        headerName: 'Voltage',
        width: 80,
    },
    {
        field: 'maxCurrent',
        headerName: 'Max Current',
        width: 80,
    },
    {
        field: 'passMinCurrent',
        headerName: 'Pass Min Current',
        width: 80,
    },
    {
        field: 'passMaxCurrent',
        headerName: 'Pass Max Current',
        width: 80,
    },
    {
        field: 'actions',
        headerName: 'Actions',
        type: 'actions',
        width: 50,
    },
];

export default function ModeOneList() {

    const [date, setDate] = React.useState<Date | null>(null);
    const [filterType, setFilterType] = React.useState("CREATED_BY");
    const [filterValue, setFilterValue] = React.useState("");

    var { data, error, isLoading } = useGetModeOneSessionsQuery({ date: date, filterType: filterType, filterValue: filterValue })

    if (isLoading) {
        return <div>Loading...</div>
    }

    function setSearchParams(date: Date | null, filterType: string, filterValue: string) {
        setFilterType(filterType);
        setFilterValue(filterValue);
        setDate(date)
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
                        sx={{}}
                    >
                        <Card sx={{ maxWidth: 1600, height: '80vh', backgroundColor: "#FFFFFF", boxShadow: "1px 1px 10px 10px #e8e8e8" }}>
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
                                    <TableSearchForm searchFun={setSearchParams}></TableSearchForm>
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
                                                    {data!.sessions
                                                        .map((item, index) => {
                                                            return (
                                                                <StyledTableRow hover role="checkbox" tabIndex={-1} >
                                                                    <StyledTableCell align={'left'}>
                                                                        {item.defaultConfigurations.sessionId}
                                                                    </StyledTableCell>
                                                                    <StyledTableCell align={'left'}>
                                                                        {item.defaultConfigurations.customerName}
                                                                    </StyledTableCell>
                                                                    <StyledTableCell align={'left'}>
                                                                        {item.defaultConfigurations.operatorId}
                                                                    </StyledTableCell>
                                                                    <StyledTableCell align={'left'}>
                                                                        {item.defaultConfigurations.batchNo}
                                                                    </StyledTableCell>
                                                                    <StyledTableCell align={'left'}>
                                                                        {item.sessionConfigurationModeOne.voltage}
                                                                    </StyledTableCell>
                                                                    <StyledTableCell align={'left'}>
                                                                        {item.sessionConfigurationModeOne.maxCurrent}
                                                                    </StyledTableCell>
                                                                    <StyledTableCell align={'left'}>
                                                                        {item.sessionConfigurationModeOne.passMinCurrent}
                                                                    </StyledTableCell>
                                                                    <StyledTableCell align={'left'}>
                                                                        {item.sessionConfigurationModeOne.passMaxCurrent}
                                                                    </StyledTableCell>
                                                                    <StyledTableCell align={'right'}>
                                                                        <CustomizedMenus session={item as ModeOneDto} />
                                                                    </StyledTableCell>
                                                                </StyledTableRow>
                                                            );
                                                        })}
                                                </TableBody>
                                            </Table>
                                        </TableContainer>
                                        {/* <TablePagination
                                            rowsPerPageOptions={[10, 25, 100]}
                                            component="div"
                                            count={rows.length}
                                            rowsPerPage={rowsPerPage}
                                            page={page}
                                            onPageChange={handleChangePage}
                                            onRowsPerPageChange={handleChangeRowsPerPage}
                                        /> */}
                                    </Paper>
                                </CardContent>
                            </CardActionArea>
                        </Card>

                    </Box>
                </>
            </Container>
        </Box>
    }
}
