import { Box, Button, Container, Dialog, DialogActions, DialogContent, DialogTitle, Grid, IconButton, Typography, useMediaQuery, useTheme } from "@mui/material";
import { useEffect, useState } from "react";
import CloseIcon from '@mui/icons-material/Close';
import { ModeThreeDto } from "../../services/sessions_service";
import { CartesianGrid, Legend, Line, LineChart, ResponsiveContainer, XAxis, YAxis, Tooltip } from "recharts";
import { PDFDownloadLink } from "@react-pdf/renderer";
import ModeThreeShareAlertDialog from "./session-three-share-dialog";
import ModeThreePdfDocument from "./mode-three-pdf";
import ShareIcon from '@mui/icons-material/Share';
import DownloadIcon from '@mui/icons-material/Download';
import { handleGenerateExcelModeThree } from "./mode-three-excel";
import PictureAsPdfIcon from '@mui/icons-material/PictureAsPdf';
import GridOnIcon from '@mui/icons-material/GridOn';


type SessionDetailsProps = {
  session: ModeThreeDto;
  open: boolean;
  changeOpenStatus: (status: boolean) => void;
}

export function ModeThreeSingleView({ session, open, changeOpenStatus }: SessionDetailsProps) {

  const [openCloseLinkView, setOpenCloseLinkView] = useState(false);
  const [openSuccess, setOpenSuccess] = useState(false);
  const [voltageVsCurrent, setA] = useState([{}]);
  const [voltageVsTemp, setB] = useState([{}]);
  const [voltageVsResistance, setC] = useState([{}]);


  const theme = useTheme();
  const fullScreen = useMediaQuery(theme.breakpoints.down('md'));


  useEffect(() => {
    setA([{}])
    setB([{}])
    setC([{}])
    session.results.readings.forEach(element => {
      setA(prevState => [...prevState, {
        name: element.voltage,
        Current: Number.parseFloat(element.current),
      }])
      setB(prevState => [...prevState, {
        name: element.voltage,
        Temperature: Number.parseFloat(element.temperature),
      }])
      setC(prevState => [...prevState, {
        name: element.voltage,
        Resistance: Number.parseFloat(element.voltage) / Number.parseFloat(element.current),
      }])
    });
    console.log(voltageVsCurrent)
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
                  Starting Voltage : <Typography variant="subtitle2" gutterBottom display="inline" color="black">{session.sessionConfigurationModeThree.startingVoltage}</Typography>
                </Typography>
                <Typography variant="subtitle1" gutterBottom >
                  Desired Voltage : <Typography variant="subtitle2" gutterBottom display="inline" color="black">{session.sessionConfigurationModeThree.desiredVoltage}</Typography>
                </Typography>
                <Typography variant="subtitle1" gutterBottom >
                  Max Current  : <Typography variant="subtitle2" gutterBottom display="inline" color="black">{session.sessionConfigurationModeThree.maxCurrent}</Typography>
                </Typography>
                <Typography variant="subtitle1" gutterBottom >
                  Voltage Resolution : <Typography variant="subtitle2" gutterBottom display="inline" color="black">{session.sessionConfigurationModeThree.voltageResolution}</Typography>
                </Typography>
                <Typography variant="subtitle1" gutterBottom >
                  Charge In Time : <Typography variant="subtitle2" gutterBottom display="inline" color="black">{session.sessionConfigurationModeThree.chargeInTime}</Typography>
                </Typography>
              </Grid>
            </Grid>
          </Container>

          <LineChart
            width={900}
            height={400}
            data={voltageVsCurrent}
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
            <Line type="monotone" dataKey="Current" strokeWidth={3} stroke="#8884d8" activeDot={{ r: 8 }} />
          </LineChart>
        </Box>
        <Box sx={{ my: 2 }}>
          <LineChart
            width={900}
            height={400}
            data={voltageVsResistance}
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
            height={400}
            data={voltageVsTemp}
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
        <Button variant="contained" startIcon={<GridOnIcon />} onClick={() => handleGenerateExcelModeThree(session)}>
          Download EXCEL
        </Button>
        <Button variant="contained" startIcon={<PictureAsPdfIcon />}>
          <PDFDownloadLink document={<ModeThreePdfDocument session={session} />} fileName={"mode_three_" + session.defaultConfigurations.sessionId + ".pdf"}
            style={{ color: "white", textDecoration: "none" }}>
            {({ blob, url, loading, error }) =>
              loading ? 'Loading...' : 'Download PDF'
            }
          </PDFDownloadLink>
        </Button>
      </DialogActions>
      <ModeThreeShareAlertDialog open={openCloseLinkView} changeOpenStatus={setOpenCloseLinkView} session={session} />

    </Dialog>
  );
};