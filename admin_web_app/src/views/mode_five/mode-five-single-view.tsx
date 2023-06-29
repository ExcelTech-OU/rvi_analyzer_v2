import { Box, Button, Container, Dialog, DialogContent, IconButton, useMediaQuery, useTheme, Grid, Typography, DialogActions } from "@mui/material";
import { useEffect, useState } from "react";
import CloseIcon from '@mui/icons-material/Close';
import { ModeFiveDto } from "../../services/sessions_service";
import { CartesianGrid, Legend, Line, LineChart, XAxis, YAxis, Tooltip } from "recharts";
import { PDFDownloadLink } from "@react-pdf/renderer";
import ModeFiveShareAlertDialog from "./session-five-share-dialog";
import ModeFivePdfDocument from "./mode-five-pdf";
import ShareIcon from '@mui/icons-material/Share';
import DownloadIcon from '@mui/icons-material/Download';
import PictureAsPdfIcon from '@mui/icons-material/PictureAsPdf';
import GridOnIcon from '@mui/icons-material/GridOn';
import { handleGenerateExcelModeFive } from "./mode-five-excel";


type SessionDetailsProps = {
  session: ModeFiveDto;
  open: boolean;
  changeOpenStatus: (status: boolean) => void;
}

export function ModeFiveSingleView({ session, open, changeOpenStatus }: SessionDetailsProps) {

  const [openCloseLinkView, setOpenCloseLinkView] = useState(false);
  const [openSuccess, setOpenSuccess] = useState(false);
  const [timeVsVoltage, setA] = useState([{}]);
  const [timeVsTemp, setB] = useState([{}]);
  const [timeVsResistance, setC] = useState([{}]);
  const [timeVsCurrent, setD] = useState([{}]);

  const theme = useTheme();
  const fullScreen = useMediaQuery(theme.breakpoints.down('md'));

  const handleCloseSuccess = () => {
    setOpenSuccess(false);
  };

  useEffect(() => {
    setA([{}])
    setB([{}])
    setC([{}])
    setD([{}])
    for (let index = 0; index < session.results.readings.length; index++) {
      var element = session.results.readings[index];
      setA(prevState => [...prevState, {
        name: index,
        Voltage: Number.parseFloat(element.voltage),
      }])
      setB(prevState => [...prevState, {
        name: index,
        Temperature: Number.parseFloat(element.temperature),
      }])
      setC(prevState => [...prevState, {
        name: index,
        Resistance: Number.parseFloat(element.voltage) / Number.parseFloat(element.current),
      }])
      setD(prevState => [...prevState, {
        name: index,
        Current: Number.parseFloat(element.current),
      }])
    }
  }, [session]);

  return (
    <Dialog
      fullScreen={fullScreen}
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
                  Serial No : <Typography variant="subtitle2" gutterBottom display="inline" color="black">{session.defaultConfigurations.serialNo}</Typography>
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
                  Fixed Voltage : <Typography variant="subtitle2" gutterBottom display="inline" color="black">{session.sessionConfigurationModeFive.fixedVoltage}</Typography>
                </Typography>
                <Typography variant="subtitle1" gutterBottom >
                  Max Current : <Typography variant="subtitle2" gutterBottom display="inline" color="black">{session.sessionConfigurationModeFive.maxCurrent}</Typography>
                </Typography>
                <Typography variant="subtitle1" gutterBottom >
                  Time Duration  : <Typography variant="subtitle2" gutterBottom display="inline" color="black">{session.sessionConfigurationModeFive.timeDuration}</Typography>
                </Typography>

              </Grid>
            </Grid>
          </Container>

          <LineChart
            width={900}
            height={300}
            data={timeVsVoltage}
            margin={{
              top: 10,
              right: 30,
              left: 20,
              bottom: 5,
            }}
          >
            <CartesianGrid horizontal={false} vertical={false} />
            <XAxis dataKey="name" type="number" />
            <YAxis />
            <Tooltip />
            <Legend />
            <Line type="monotone" dataKey="Voltage" strokeWidth={3} stroke="#8884d8" activeDot={{ r: 8 }} />
          </LineChart>
        </Box>
        <Box sx={{ my: 2 }}>
          <LineChart
            width={900}
            height={300}
            data={timeVsResistance}
            margin={{
              top: 5,
              right: 30,
              left: 20,
              bottom: 5,
            }}
          >
            <CartesianGrid horizontal={false} vertical={false} />
            <XAxis dataKey="name" type="number" />
            <YAxis />
            <Tooltip />
            <Legend />
            <Line type="monotone" dataKey="Resistance" strokeWidth={3} stroke="#b6d884" activeDot={{ r: 8 }} />
          </LineChart>
        </Box>
        <Box sx={{ my: 2 }}>
          <LineChart
            width={900}
            height={300}
            data={timeVsCurrent}
            margin={{
              top: 5,
              right: 30,
              left: 20,
              bottom: 5,
            }}
          >
            <CartesianGrid horizontal={false} vertical={false} />
            <XAxis dataKey="name" type="number" />
            <YAxis />
            <Tooltip />
            <Legend />
            <Line type="monotone" dataKey="Current" strokeWidth={3} stroke="#bf6767" activeDot={{ r: 8 }} />
          </LineChart>
        </Box>
        <Box sx={{ my: 2 }}>
          <LineChart
            width={900}
            height={300}
            data={timeVsTemp}
            margin={{
              top: 5,
              right: 30,
              left: 20,
              bottom: 5,
            }}
          >
            <CartesianGrid horizontal={false} vertical={false} />
            <XAxis dataKey="name" type="number" />
            <YAxis />
            <Tooltip />
            <Legend />
            <Line type="monotone" dataKey="Temperature" strokeWidth={3} stroke="#bf6767" activeDot={{ r: 8 }} />
          </LineChart>
        </Box>

      </DialogContent>
      <DialogActions>
        <Button variant="contained" startIcon={<ShareIcon />} onClick={() => setOpenCloseLinkView(true)}>
          Share
        </Button>
        <Button variant="contained" startIcon={<GridOnIcon />} onClick={() => handleGenerateExcelModeFive(session)}>
          Download EXCEL
        </Button>
        <Button variant="contained" startIcon={<PictureAsPdfIcon />}>
          <PDFDownloadLink document={<ModeFivePdfDocument session={session} />} fileName={"mode_five_" + session.defaultConfigurations.sessionId + ".pdf"}
            style={{ color: "white", textDecoration: "none" }}>
            {({ blob, url, loading, error }) =>
              loading ? 'Loading...' : 'Download PDF'
            }
          </PDFDownloadLink>
        </Button>
      </DialogActions>
      <ModeFiveShareAlertDialog open={openCloseLinkView} changeOpenStatus={setOpenCloseLinkView} session={session} />
    </Dialog>
  );
};