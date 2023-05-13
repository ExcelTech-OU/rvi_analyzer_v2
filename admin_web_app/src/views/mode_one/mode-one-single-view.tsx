import { Box, Button, Container, Dialog, DialogActions, DialogContent, DialogTitle, Divider, Grid, IconButton, Paper, Table, TableBody, TableContainer, TableHead, Typography } from "@mui/material";
import CloseIcon from '@mui/icons-material/Close';
import { ModeOneDto } from "../../services/sessions_service";
import { GridColDef } from "@mui/x-data-grid";
import { StyledTableCell, StyledTableRow } from "./mode-one-list";
import ShareIcon from '@mui/icons-material/Share';
import DownloadIcon from '@mui/icons-material/Download';


type SessionDetailsProps = {
  session: ModeOneDto;
  open: boolean;
  changeOpenStatus: (status: boolean) => void;
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

export function ModeOneSingleView({ session, open, changeOpenStatus }: SessionDetailsProps) {

  return (
    <Dialog
      fullScreen={false}
      fullWidth={true}
      maxWidth="md"
      open={open}
      onClose={() => changeOpenStatus(false)}
      aria-labelledby="responsive-dialog-title"
    >

      <DialogContent>

        <IconButton
          aria-label="close"
          onClick={() => changeOpenStatus(false)}
          sx={{
            position: 'absolute',
            right: 15,
            top: 8,
            color: (theme) => theme.palette.grey[500],
          }}
        >
          <CloseIcon />
        </IconButton>
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
                                <StyledTableCell key={item.testId} align={'left'}>
                                  {item.testId}
                                </StyledTableCell>
                                <StyledTableCell key={item.testId} align={'left'}>
                                  {item.readings[0].temperature}
                                </StyledTableCell>
                                <StyledTableCell key={item.testId} align={'left'}>
                                  {item.readings[0].current}
                                </StyledTableCell>
                                <StyledTableCell key={item.testId} align={'left'}>
                                  {item.readings[0].voltage}
                                </StyledTableCell>
                                <StyledTableCell key={item.testId} align={'left'}>
                                  {item.readings[0].result == 'PASS' ?
                                    <Button variant="contained" color="success" sx={{ minWidth: 100 }}>
                                      {item.readings[0].result}
                                    </Button> :
                                    <Button variant="contained" color="error" sx={{ minWidth: 100 }}>
                                      {item.readings[0].result}
                                    </Button>}
                                </StyledTableCell>
                                <StyledTableCell key={item.testId} align={'left'}>
                                  {item.readings[0].readAt}
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
        </Box>
      </DialogContent>
      <DialogActions>
        <Button variant="outlined" startIcon={<ShareIcon />}>
          Share
        </Button>
        <Button variant="outlined" startIcon={<DownloadIcon />}>
          Download
        </Button>
      </DialogActions>

    </Dialog>
  );
};