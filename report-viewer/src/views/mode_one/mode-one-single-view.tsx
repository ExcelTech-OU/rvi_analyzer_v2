import { Box, Button, Container, Grid, Paper, Table, TableBody, TableCell, TableContainer, TableHead, TableRow, Typography, styled, tableCellClasses } from "@mui/material";
import { ModeOneDto } from "../../services/sessions_service";
import { GridColDef } from "@mui/x-data-grid";
import { PDFDownloadLink } from "@react-pdf/renderer";
import ModeOnePdfDocument from "./mode-one-pdf";
import { useState } from "react";
import PictureAsPdfIcon from '@mui/icons-material/PictureAsPdf';
import GridOnIcon from '@mui/icons-material/GridOn';
import { handleGenerateExcelModeOne } from "./mode-one-excel";



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

type SessionDetailsProps = {
  session: ModeOneDto;
}

const columns: GridColDef[] = [
  {
    field: 'testId',
    headerName: 'Test ID',
    width: 100,
  },
  {
    field: 'temperature',
    headerName: 'Temperature',
    width: 100,
  },
  {
    field: 'current',
    headerName: 'Current',
    width: 100,
  },
  {
    field: 'voltage',
    headerName: 'Voltage',
    width: 100,
  },
  {
    field: 'result',
    headerName: 'Result',
    width: 100,
  },
  {
    field: 'readAt',
    headerName: 'Read Date Time',
    width: 200,
  }
];

export function ModeOneSingleView({ session }: SessionDetailsProps) {
  const [openCloseLinkView, setOpenCloseLinkView] = useState(false);

  return (

    <Box sx={{ my: 2 }}>
      <Container maxWidth={false}>
        <Grid container spacing={{ xs: 2, md: 3 }} columns={{ xs: 4, sm: 8, md: 12 }}>
          <Grid item xs={4} sm={4} md={6} >
            <Typography variant="h5" display="block" gutterBottom>
              Default Configurations
            </Typography>
            <Typography variant="subtitle1" gutterBottom >
              Session Id : <Typography variant="subtitle2" gutterBottom display="inline" color="black">{session.defaultConfigurations.sessionId}</Typography>
            </Typography>
            <Typography variant="subtitle1" gutterBottom >
              Batch No : <Typography variant="subtitle2" gutterBottom display="inline" color="black">{session.defaultConfigurations.batchNo}</Typography>
            </Typography>
            <Typography variant="subtitle1" gutterBottom >
              Customer Name : <Typography variant="subtitle2" gutterBottom display="inline" color="black">{session.defaultConfigurations.customerName}</Typography>
            </Typography>
            <Typography variant="subtitle1" gutterBottom >
              Operator Id : <Typography variant="subtitle2" gutterBottom display="inline" color="black">{session.defaultConfigurations.operatorId}</Typography>
            </Typography>
          </Grid>
          <Grid item xs={4} sm={4} md={6} >
            <Typography variant="h5" display="block" gutterBottom>
              Session Configurations
            </Typography>
            <Typography variant="subtitle1" gutterBottom >
              Max Current : <Typography variant="subtitle2" gutterBottom display="inline" color="black">{session.sessionConfigurationModeOne.maxCurrent}</Typography>
            </Typography>
            <Typography variant="subtitle1" gutterBottom >
              Voltage : <Typography variant="subtitle2" gutterBottom display="inline" color="black">{session.sessionConfigurationModeOne.voltage}</Typography>
            </Typography>
          </Grid>
        </Grid>
      </Container>
      <Container maxWidth={false}>
        <>
          <Box
            m="10px 0 0 0"
            height="50vh"
            sx={{ mt: 4 }}
          >
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
                    {session!.results
                      .map((item, index) => {
                        return (
                          <StyledTableRow hover role="checkbox" tabIndex={-1} key={index}>
                            <StyledTableCell align={'left'}>
                              {item.testId}
                            </StyledTableCell>
                            <StyledTableCell align={'left'}>
                              {item.readings[0].temperature}
                            </StyledTableCell>
                            <StyledTableCell align={'left'}>
                              {item.readings[0].current}
                            </StyledTableCell>
                            <StyledTableCell align={'left'}>
                              {item.readings[0].voltage}
                            </StyledTableCell>
                            <StyledTableCell align={'left'}>
                              {item.readings[0].result == 'PASS' ?
                                <Button variant="contained" color="success" sx={{ minWidth: 100 }}>
                                  {item.readings[0].result}
                                </Button> :
                                <Button variant="contained" color="error" sx={{ minWidth: 100 }}>
                                  {item.readings[0].result}
                                </Button>}
                            </StyledTableCell>
                            <StyledTableCell align={'left'}>
                              {new Date(item.readings[0].readAt).toLocaleDateString() + " " + new Date(item.readings[0].readAt).toLocaleTimeString()}
                            </StyledTableCell>
                          </StyledTableRow>
                        );
                      })}
                  </TableBody>
                </Table>
              </TableContainer>
            </Paper>
          </Box>
        </>
      </Container>
      <Box display="flex" justifyContent="flex-end" sx={{ mr: 3 }}>
        <Button variant="contained" startIcon={<GridOnIcon />} onClick={() => handleGenerateExcelModeOne(session)} sx={{ mr: 1 }}>
          Download EXCEL
        </Button>
        <Button variant="contained" startIcon={<PictureAsPdfIcon />}>
          <PDFDownloadLink document={<ModeOnePdfDocument session={session} />} fileName={"mode_one_" + session.defaultConfigurations.sessionId + ".pdf"}
            style={{ color: "white", textDecoration: "none" }}>
            {({ blob, url, loading, error }) =>
              loading ? 'Loading...' : 'Download PDF'
            }
          </PDFDownloadLink>
        </Button>
      </Box>
    </Box>

  );
};