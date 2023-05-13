import { Alert, Box, Button, Container, Dialog, DialogContent, DialogTitle, Divider, IconButton, List, ListItem, ListItemText, Snackbar, Tooltip, useMediaQuery, useTheme } from "@mui/material";
import { Visibility } from '@mui/icons-material';
import { useState } from "react";
import CloseIcon from '@mui/icons-material/Close';
import { ModeOneDto, ModeOnesResponse, useGetSessionQuestionsQuery, UserTreatmentSession } from "../../services/sessions_service";
import { DataGrid, GridColDef, GridToolbar, GridValueGetterParams } from "@mui/x-data-grid";
import { blue, green, grey } from "@mui/material/colors";
import CustomizedMenus from "../components/custom-menu";


type SessionDetailsProps = {
  session: ModeOneDto;
}

const columns: GridColDef[] = [
  {
    field: 'testId',
    headerName: 'Test ID',
    width: 100,
    valueGetter: (params: GridValueGetterParams) =>
      `${params.row.testId}`,
  },
  {
    field: 'temperature',
    headerName: 'Temperature',
    width: 100,
    valueGetter: (params: GridValueGetterParams) =>
      `${params.row.readings[0].temperature}`
  },
  {
    field: 'current',
    headerName: 'Current',
    width: 100,
    valueGetter: (params: GridValueGetterParams) =>
      `${params.row.readings[0].current}`
  },
  {
    field: 'voltage',
    headerName: 'Voltage',
    width: 100,
    valueGetter: (params: GridValueGetterParams) =>
      `${params.row.readings[0].voltage}`
  },
  {
    field: 'result',
    headerName: 'Result',
    width: 100,
    renderCell: (params) => (
      params.row.readings[0].result == 'PASS' ?
        <Button variant="contained" color="success">
          {params.row.readings[0].result}
        </Button> :
        <Button variant="contained" color="error">
          {params.row.readings[0].result}
        </Button>
    ),
  },
  {
    field: 'readAt',
    headerName: 'Read Date Time',
    width: 200,
    valueGetter: (params: GridValueGetterParams) =>
      `${params.row.readings[0].readAt}`
  }
];

export function ModeOneSingleView({ session }: SessionDetailsProps) {

  const [open, setOpen] = useState(false);
  const [openSuccess, setOpenSuccess] = useState(false);

  const theme = useTheme();
  const fullScreen = useMediaQuery(theme.breakpoints.down('md'));

  const handleClickOpen = () => {
    setOpen(true);
  };

  const handleClose = () => {
    setOpen(false);
  };

  const handleCloseSuccess = () => {
    setOpenSuccess(false);
  };

  return (
    <Box>
      <Tooltip title="View Feedback">
        {/* <IconButton onClick={handleClickOpen}
        >
          <MoreVertIcon />
        </IconButton> */}
        <CustomizedMenus />
      </Tooltip>
      <Dialog
        fullScreen={fullScreen}
        fullWidth={true}
        maxWidth="md"
        open={open}
        onClose={handleClose}
        aria-labelledby="responsive-dialog-title"
      >
        <DialogTitle id="alert-dialog-title">
          {"Test results for session with ID: " + session.defaultConfigurations.sessionId}
        </DialogTitle>
        <DialogContent>

          <IconButton
            aria-label="close"
            onClick={handleClose}
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
              <>
                <Box
                  m="10px 0 0 0"
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
                    rows={session.results.map((item, index) => ({ id: index + 1, ...item }))}
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
              </>
            </Container>
          </Box>
          <Snackbar open={openSuccess} autoHideDuration={6000} onClose={handleCloseSuccess} anchorOrigin={{ vertical: 'top', horizontal: 'center' }}>
            <Alert onClose={handleCloseSuccess} severity="success" sx={{ width: '100%' }}>
              {/* {session.device_id} Update success */}
            </Alert>
          </Snackbar>
        </DialogContent>

      </Dialog>
    </Box>
  );
};