import { Box, Button, Card, CardActionArea, CardContent, Container, Divider, Grid, Pagination, Typography } from "@mui/material";
import { GridColDef } from '@mui/x-data-grid';
import GridOnIcon from '@mui/icons-material/GridOn';
import * as React from 'react';
import Paper from '@mui/material/Paper';
import Table from '@mui/material/Table';
import TableBody from '@mui/material/TableBody';
import TableCell, { tableCellClasses } from '@mui/material/TableCell';
import TableContainer from '@mui/material/TableContainer';
import TableHead from '@mui/material/TableHead';
import TableRow from '@mui/material/TableRow';
import { styled } from '@mui/material';
// import { FullGarment, useGetAllELQCMutation, useGetELQCQuery } from "../../../services/softmatter_service";
import {  useGetELQCQuery } from "../../../services/softmatter_service";
import { format, parseISO } from "date-fns";
import TableSearchFormSoftmatter from "../table_search_form_softmatter";
import SessionTimeoutPopup from "../../components/session_logout";
import { handleGenerateExcelEndLineQc } from "./end_line_qc-excel";
import { Download, Edit } from "@mui/icons-material";
import { UpdateEndLinePopup } from "./update-end-line-qc";

import { useState, useEffect } from 'react';


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

///////////////////////
interface FullGarment {
    _id: string
    dateCode: string
    idleCurrent: string
    settingsIdleCurrentMin: string
    settingsIdleCurrentMax: string
    idleCurrentStatus: string
    flCurrent: string
    settingsFLCurrentMin: string
    settingsFLCurrentMax: string
    flCurrentStatus: string
    voltage: string | null; 
    noiseIdle: string
    settingsNoiseMin: string
    settingsNoiseMax: string
    noiseStatusIdle: string
    noiseFL: string
    noiseStatusFL: string
    createdBy: string
    soNumber: string
    productionOrder: string
    qrCode: string
    createdDateTime: string
}

///////////////////////

const columns: GridColDef[] = [
    {
        field: 'Select', headerName: 'Select', width: 80,
    },
    {
        field: 'dateCode', headerName: 'Date Code', width: 150,
    },
    {
        field: 'idleCurrent',
        headerName: 'Idle Current',
        width: 100,
    },
    {
        field: 'settingsIdleCurrentMin',
        headerName: 'Settings Idle Current Min',
        width: 100,
    },
    {
        field: 'settingsIdleCurrentMax',
        headerName: 'Settings Idle Current Max',
        width: 100,
    },
    {
        field: 'idleCurrentStatus',
        headerName: 'Idle Current Status',
        width: 100,
    },
    {
        field: 'flCurrent',
        headerName: 'FL Current',
        width: 80,
    },
    {
        field: 'settingsFLCurrentMin',
        headerName: 'Settings FL Current Min',
        width: 100,
    },
    {
        field: 'settingsFLCurrentMax',
        headerName: 'Settings FL Current Max',
        width: 100,
    },
    {
        field: 'flCurrentStatus',
        headerName: 'FL Current Status',
        width: 100,
    },
    {
        field: 'voltage',
        headerName: 'Voltage',
        width: 100,
    },
    {
        field: 'soNumber',
        headerName: 'So Number',
        width: 100,
    },
    {
        field: 'productionOrder',
        headerName: 'Production Order',
        width: 100,
    },
    {
        field: 'qrCode',
        headerName: 'QR Code',
        width: 100,
    },
    // {
    //     field: 'noiseIdle',
    //     headerName: 'Noise Idle',
    //     width: 100,
    // },
    // {
    //     field: 'settingsNoiseMin',
    //     headerName: 'Settings Noise Min',
    //     width: 100,
    // },
    // {
    //     field: 'settingsNoiseMax',
    //     headerName: 'Settings Noise Max',
    //     width: 100,
    // },
    // {
    //     field: 'noiseStatusIdle',
    //     headerName: 'Noise Status Idle',
    //     width: 100,
    // },
    // {
    //     field: 'noiseFL',
    //     headerName: 'Noise FL',
    //     width: 100,
    // },
    // {
    //     field: 'noiseStatusFL',
    //     headerName: 'Noise Status Fl',
    //     width: 100,
    // },
    {
        field: 'createdDateTime',
        headerName: 'Created DateTime',
        width: 80,
    },
    {
        field: 'actions',
        headerName: 'Actions',
        width: 80,
    }
];

export default function EndLineQcList() {

    const [date, setDate] = React.useState<Date | null>(null);
    const [filterType, setFilterType] = React.useState("DATE_CODE");
    const [filterValue, setFilterValue] = React.useState("");
    const [pageCount, setPageCount] = React.useState(1);
    const [page, setPage] = React.useState(1);
    const [open, setOpen] = React.useState(false);

    ///////////////////////
    const [s_o, setS_O] = React.useState("");
    ///////////////////////

    const [selectedRows, setSelectedRows] = React.useState<number[]>([]);

    const [confirmation, setOpenConfirmation] = React.useState(false);
    const [selectedId, setSelect] = React.useState<FullGarment | null>(null);

    const handleRowClick = (id: number) => {
        // Toggle selection state
        if (selectedRows.includes(id)) {
            setSelectedRows(selectedRows.filter((rowId) => rowId !== id));
        } else {
            setSelectedRows([...selectedRows, id]);
        }
    };

    ///////////////////////////////
    const [data, setData] = useState({
        endLIneQcs: [
            {
              "createdBy": "sadmin@gmail.com",
              "createdDateTime": "2024-02-09T12:02:01.209",
              "dateCode": "B3B B2A B27A",
              "flCurrent": "546",
              "flCurrentStatus": "PASSED",
              "idleCurrent": "276",
              "idleCurrentStatus": "PASSED",
              "noiseFL": "136",
              "noiseIdle": "132",
              "noiseStatusFL": "FAILED",
              "noiseStatusIdle": "FAILED",
              "productionOrder": "8003245808",
              "qrCode": "(01)00810036057912(10)2328(21)00477M",
              "settingsFLCurrentMax": "650",
              "settingsFLCurrentMin": "450",
              "settingsIdleCurrentMax": "650",
              "settingsIdleCurrentMin": "230",
              "settingsNoiseMax": "0.0",
              "settingsNoiseMin": "0.0",
              "soNumber": "1000887481_130",
              "voltage": null,
              "_id": "65c5c6e101e02a4c2b0675e8"
            },
            {
              "createdBy": "sadmin@gmail.com",
              "createdDateTime": "2024-02-09T12:01:46.589",
              "dateCode": "B3B B2A B27A",
              "flCurrent": "547",
              "flCurrentStatus": "PASSED",
              "idleCurrent": "282",
              "idleCurrentStatus": "PASSED",
              "noiseFL": "134",
              "noiseIdle": "133",
              "noiseStatusFL": "FAILED",
              "noiseStatusIdle": "FAILED",
              "productionOrder": "8003245808",
              "qrCode": "(01)00810036057912(10)2349(21)00522M",
              "settingsFLCurrentMax": "650",
              "settingsFLCurrentMin": "450",
              "settingsIdleCurrentMax": "650",
              "settingsIdleCurrentMin": "230",
              "settingsNoiseMax": "0.0",
              "settingsNoiseMin": "0.0",
              "soNumber": "1000887481_130",
              "voltage": null,
              "_id": "65c5c6d201e02a4c2b0675e7"
            },
            {
              "createdBy": "sadmin@gmail.com",
              "createdDateTime": "2024-02-09T12:01:25.469",
              "dateCode": "B3B B2A B27A",
              "flCurrent": "555",
              "flCurrentStatus": "PASSED",
              "idleCurrent": "269",
              "idleCurrentStatus": "PASSED",
              "noiseFL": "137",
              "noiseIdle": "133",
              "noiseStatusFL": "FAILED",
              "noiseStatusIdle": "FAILED",
              "productionOrder": "8003245808",
              "qrCode": "(01)00810036057912(10)2349(21)00614M",
              "settingsFLCurrentMax": "650",
              "settingsFLCurrentMin": "450",
              "settingsIdleCurrentMax": "650",
              "settingsIdleCurrentMin": "230",
              "settingsNoiseMax": "0.0",
              "settingsNoiseMin": "0.0",
              "soNumber": "1000887481_130",
              "voltage": null,
              "_id": "65c5c6bd01e02a4c2b0675e6"
            }
          ],
        total: 10, // Replace with the actual total count for your dummy data
        totalSuccess: 8, // Replace with the actual total success count for your dummy data
    });
    const [error, setError] = useState(null);
    const [isLoading, setIsLoading] = useState(false);
    ///////////////////////////////

    // var { data, error, isLoading } = useGetELQCQuery({ data: { date: date, filterType: filterType, filterValue: filterValue }, page: page.toString() })

    // const [getAll] = useGetAllELQCMutation()

    const handleChange = (event: React.ChangeEvent<unknown>, value: number) => {
        setPage(value);
    };

    function setSearchParams(date: Date | null, filterType: string,  S_O:string) {
        ////////
        setS_O(S_O);
        ////////
        setFilterType(filterType);
        // setFilterValue(filterValue);
        setDate(date)
        setPage(1)    

        console.log(S_O);
        
    }

    function openEditForm(params: FullGarment) {
        setSelect(params);
        setOpenConfirmation(true);
    }

    React.useEffect(() => {
        if (data?.endLIneQcs != null) {
            setPageCount(Math.trunc((data.total + 15 - 1) / 15))
        }
        setSelectedRows([]);
    }, [data])

    function getSelectedList() {
        return data!.endLIneQcs.filter((item, index) =>
            selectedRows.includes(index)
        );
    }



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
                        sx={{}}
                    >
                        <Card sx={{ maxWidth: 1600, backgroundColor: "#FFFFFF", boxShadow: "1px 1px 10px 10px #e8e8e8" }}>
                            <CardActionArea>

                                <CardContent sx={{}}>
                                    <Grid container spacing={{ xs: 1, md: 1 }} columns={{ xs: 4, sm: 8, md: 12 }}>
                                        <Grid item xs={4} sm={6} md={6} >
                                            <Typography gutterBottom variant="h5" component="div" color="grey">
                                                End Line QC
                                            </Typography>

                                        </Grid>
                                        <Grid item xs={4} sm={2} md={6} >
                                            <Box display="flex" justifyContent="flex-end">
                                                <Button variant="contained" startIcon={<Download />} color="success" onClick={() =>
                                                    handleGenerateExcelEndLineQc(getSelectedList())
                                                } disabled={selectedRows.length == 0}>
                                                    Download selected
                                                </Button>
                                                <Button sx={{ ml: 2 }} variant="contained" startIcon={<GridOnIcon />} color="success" onClick={() => {
                                                    // getAll({ data: { date: date, filterType: filterType, filterValue: filterValue }, page: "all" }).unwrap()
                                                    //     .then((payload) => {
                                                    //         handleGenerateExcelEndLineQc(payload.endLIneQcs)
                                                    //     });
                                                }
                                                }>
                                                    Download
                                                </Button>
                                            </Box>
                                        </Grid>
                                        <Grid item xs={4} sm={8} md={12} sx={{ mt: 1 }}>
                                            <Box display="flex" justifyContent="flex-end">
                                                <Typography gutterBottom variant="h6" component="div" color="grey" sx={{ mr: 2 }}>
                                                    {"TOTAL : " + data?.total}
                                                </Typography>
                                                <Typography gutterBottom variant="h6" component="div" color="grey" sx={{ mr: 2 }}>
                                                    {"PASSED : " + data?.totalSuccess}
                                                </Typography>
                                                <Typography gutterBottom variant="h6" component="div" color="grey">
                                                    {"FAILED : " + (data?.total! - data?.totalSuccess!)}
                                                </Typography>
                                            </Box>
                                        </Grid>
                                    </Grid>
                                    <Divider
                                        sx={{
                                            borderColor: 'grey',
                                            mb: 1.5,
                                            borderStyle: 'dashed'
                                        }}
                                    />
                                    <TableSearchFormSoftmatter searchFun={setSearchParams}></TableSearchFormSoftmatter>
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
                                                    {data!.endLIneQcs
                                                        .map((item, index) => {
                                                            return (
                                                                <StyledTableRow hover role="checkbox" tabIndex={-1} key={index}
                                                                    onClick={() => handleRowClick(index)}
                                                                    selected={selectedRows.includes(index)}>
                                                                    <StyledTableCell align={'left'}>
                                                                        <input type="checkbox" checked={selectedRows.includes(index)} />
                                                                    </StyledTableCell>
                                                                    <StyledTableCell align={'left'}>
                                                                        {item.dateCode}
                                                                    </StyledTableCell>
                                                                    <StyledTableCell align={'left'}>
                                                                        {item.idleCurrent}
                                                                    </StyledTableCell>
                                                                    <StyledTableCell align={'left'}>
                                                                        {item.settingsIdleCurrentMin}
                                                                    </StyledTableCell>
                                                                    <StyledTableCell align={'left'}>
                                                                        {item.settingsIdleCurrentMax}
                                                                    </StyledTableCell>
                                                                    <StyledTableCell align={'left'}>
                                                                        {item.idleCurrentStatus}
                                                                    </StyledTableCell>
                                                                    <StyledTableCell align={'left'}>
                                                                        {item.flCurrent}
                                                                    </StyledTableCell>
                                                                    <StyledTableCell align={'left'}>
                                                                        {item.settingsFLCurrentMin}
                                                                    </StyledTableCell>
                                                                    <StyledTableCell align={'left'}>
                                                                        {item.settingsFLCurrentMax}
                                                                    </StyledTableCell>
                                                                    <StyledTableCell align={'left'}>
                                                                        {item.flCurrentStatus}
                                                                    </StyledTableCell>
                                                                    <StyledTableCell align={'left'}>
                                                                        {item.voltage}
                                                                    </StyledTableCell>
                                                                    <StyledTableCell align={'left'}>
                                                                        {item.soNumber}
                                                                    </StyledTableCell>
                                                                    <StyledTableCell align={'left'}>
                                                                        {item.productionOrder}
                                                                    </StyledTableCell>
                                                                    <StyledTableCell align={'left'}>
                                                                        {item.qrCode}
                                                                    </StyledTableCell>


                                                                    {/* <StyledTableCell align={'left'}>
                                                                        {item.noiseIdle}
                                                                    </StyledTableCell>
                                                                    <StyledTableCell align={'left'}>
                                                                        {item.settingsNoiseMin}
                                                                    </StyledTableCell>
                                                                    <StyledTableCell align={'left'}>
                                                                        {item.settingsNoiseMax}
                                                                    </StyledTableCell>
                                                                    <StyledTableCell align={'left'}>
                                                                        {item.noiseStatusIdle}
                                                                    </StyledTableCell>
                                                                    <StyledTableCell align={'left'}>
                                                                        {item.noiseFL}
                                                                    </StyledTableCell>
                                                                    <StyledTableCell align={'left'}>
                                                                        {item.noiseStatusFL}
                                                                    </StyledTableCell> */}


                                                                    <StyledTableCell align={'left'}>
                                                                        {format(parseISO(item.createdDateTime), 'yyyy-MM-dd hh:mm:ss a')}
                                                                    </StyledTableCell>
                                                                    <StyledTableCell align={'left'}>
                                                                        <Button variant="contained" sx={{ m: 0 }} color="success" style={{
                                                                            borderRadius: '30%',
                                                                            padding: '4px', // Adjust the padding as needed for size
                                                                            minWidth: 'auto', // Set a minimum width to make it small
                                                                        }}
                                                                            onClick={() => openEditForm(item)}>
                                                                            <Edit style={{ fontSize: '18px' }} />
                                                                        </Button>
                                                                    </StyledTableCell>
                                                                </StyledTableRow>
                                                            );
                                                        })}
                                                </TableBody>
                                            </Table>
                                        </TableContainer>
                                    </Paper>
                                    {pageCount != 0 ?
                                        <Box display="flex" justifyContent="flex-end">
                                            <Pagination count={pageCount} sx={{ mt: 2 }} variant="outlined" shape="rounded" page={page} onChange={handleChange} />
                                        </Box>
                                        : <></>
                                    }
                                </CardContent>
                            </CardActionArea>
                        </Card>
                        <UpdateEndLinePopup fullGarment={selectedId} open={confirmation} changeOpenStatus={setOpenConfirmation} />

                    </Box>
                </>
            </Container>
        </Box>
    }
}
