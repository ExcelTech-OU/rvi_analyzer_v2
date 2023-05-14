import { Box, Card, CardActionArea, CardContent, Container, Divider, Pagination, Paper, Table, TableBody, TableContainer, TableHead, Typography } from "@mui/material";
import { GridColDef } from '@mui/x-data-grid';
import { ModeFiveDto, useGetModeFiveSessionsQuery } from "../../services/sessions_service";
import { ModeFiveSingleView } from './mode-five-single-view'
import React from "react";
import SessionTimeoutPopup from "../components/session_logout";
import TableSearchForm from "../components/table_search_form";
import { StyledTableCell, StyledTableRow } from "../mode_one/mode-one-list";
import CustomizedMenusModeFive from "./custom-menu-mode-five";



const columns: GridColDef[] = [
    {
        field: 'sessionId', headerName: 'Session Id', width: 150,
    },
    {
        field: 'customerName',
        headerName: 'Customer name',
        width: 120,
    },
    {
        field: 'operatorId',
        headerName: 'Operator ID',
        width: 100,
    },
    {
        field: 'batchNo',
        headerName: 'Batch NO',
        width: 100,
    },
    {
        field: 'fixedVoltage',
        headerName: 'Fixed Voltage',
        width: 150,
    },
    {
        field: 'maxCurrent',
        headerName: 'Max Current',
        width: 150,
    },
    {
        field: 'timeDuration',
        headerName: 'Time Duration',
        width: 120,
    },
    {
        field: 'actions',
        headerName: 'Actions',
        type: 'actions',
        width: 100,
    },
];

export default function ModeFiveList() {
    const [date, setDate] = React.useState<Date | null>(null);
    const [filterType, setFilterType] = React.useState("CREATED_BY");
    const [filterValue, setFilterValue] = React.useState("");
    const [pageCount, setPageCount] = React.useState(1);
    const [page, setPage] = React.useState(1);

    var { data, error, isLoading } = useGetModeFiveSessionsQuery({ date: date, filterType: filterType, filterValue: filterValue })

    const handleChange = (event: React.ChangeEvent<unknown>, value: number) => {
        setPage(value);
    };

    function setSearchParams(date: Date | null, filterType: string, filterValue: string) {
        setFilterType(filterType);
        setFilterValue(filterValue);
        setDate(date)
        setPage(1)
    }

    React.useEffect(() => {
        if (data?.sessions != null) {
            setPageCount((data.sessions.length + 20 - 1) / 20)
        }
    }, [data])

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
                                    m="0px 0 0 0"
                                    height="60vh"
                                    sx={{}}
                                >
                                    <Card sx={{ maxWidth: 1600, height: '80vh', backgroundColor: "#FFFFFF", boxShadow: "1px 1px 10px 10px #e8e8e8" }}>
                                        <CardActionArea>

                                            <CardContent sx={{ height: '80vh' }}>
                                                <Typography gutterBottom variant="h5" component="div" color="grey">
                                                    Mode Three
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
                                                                                    {item.sessionConfigurationModeFive.fixedVoltage}
                                                                                </StyledTableCell>
                                                                                <StyledTableCell align={'left'}>
                                                                                    {item.sessionConfigurationModeFive.maxCurrent}
                                                                                </StyledTableCell>
                                                                                <StyledTableCell align={'left'}>
                                                                                    {item.sessionConfigurationModeFive.timeDuration}
                                                                                </StyledTableCell>
                                                                                <StyledTableCell align={'right'}>
                                                                                    <CustomizedMenusModeFive session={item as ModeFiveDto} />
                                                                                </StyledTableCell>
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
