import { Box, Button, Container, Dialog, DialogContent, DialogTitle, IconButton, useMediaQuery, useTheme, Grid, Typography, DialogActions } from "@mui/material";
import { useEffect, useState } from "react";
import CloseIcon from '@mui/icons-material/Close';
import { ModeFourDto } from "../../services/sessions_service";
import { CartesianGrid, Legend, Line, LineChart, XAxis, YAxis, Tooltip } from "recharts";
import { PDFDownloadLink } from "@react-pdf/renderer";
import ModeFourPdfDocument from "./mode-four-pdf";
import ShareIcon from '@mui/icons-material/Share';
import DownloadIcon from '@mui/icons-material/Download';
import { handleGenerateExcelModeFour } from "./mode-four-excel";
import PictureAsPdfIcon from '@mui/icons-material/PictureAsPdf';
import GridOnIcon from '@mui/icons-material/GridOn';


type SessionDetailsProps = {
  session: ModeFourDto;
}

export function ModeFourSingleView({ session }: SessionDetailsProps) {

  const [openCloseLinkView, setOpenCloseLinkView] = useState(false);
  const [openSuccess, setOpenSuccess] = useState(false);
  const [currentVsVoltage, setA] = useState([{}]);
  const [currentVsTemp, setB] = useState([{}]);
  const [currentVsResistance, setC] = useState([{}]);

  const theme = useTheme();
  const fullScreen = useMediaQuery(theme.breakpoints.down('md'));

  const handleCloseSuccess = () => {
    setOpenSuccess(false);
  };

  useEffect(() => {
    setA([{}])
    setB([{}])
    setC([{}])
    session.results.readings.forEach(element => {
      setA(prevState => [...prevState, {
        name: element.current,
        Voltage: Number.parseFloat(element.voltage),
      }])
      setB(prevState => [...prevState, {
        name: element.current,
        Temperature: Number.parseFloat(element.temperature),
      }])
      setC(prevState => [...prevState, {
        name: element.current,
        Resistance: Number.parseFloat(element.voltage) / Number.parseFloat(element.current),
      }])
    });
  }, [session]);

  return (
    <Box sx={{ my: 2 }}>

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
                Starting Current : <Typography variant="subtitle2" gutterBottom display="inline" color="black">{session.sessionConfigurationModeFour.startingCurrent}</Typography>
              </Typography>
              <Typography variant="subtitle1" gutterBottom >
                Desired Current : <Typography variant="subtitle2" gutterBottom display="inline" color="black">{session.sessionConfigurationModeFour.desiredCurrent}</Typography>
              </Typography>
              <Typography variant="subtitle1" gutterBottom >
                Max Voltage  : <Typography variant="subtitle2" gutterBottom display="inline" color="black">{session.sessionConfigurationModeFour.maxVoltage}</Typography>
              </Typography>
              <Typography variant="subtitle1" gutterBottom >
                Current Resolution : <Typography variant="subtitle2" gutterBottom display="inline" color="black">{session.sessionConfigurationModeFour.currentResolution}</Typography>
              </Typography>
              <Typography variant="subtitle1" gutterBottom >
                Charge In Time : <Typography variant="subtitle2" gutterBottom display="inline" color="black">{session.sessionConfigurationModeFour.chargeInTime}</Typography>
              </Typography>
            </Grid>
          </Grid>
        </Container>

        <LineChart
          width={900}
          height={400}
          data={currentVsVoltage}
          margin={{
            top: 25,
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
          height={400}
          data={currentVsResistance}
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
          data={currentVsTemp}
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
        <Box display="flex" justifyContent="flex-end" sx={{ mr: 3 }}>

          <Button variant="contained" startIcon={<GridOnIcon />} onClick={() => handleGenerateExcelModeFour(session)} sx={{ mr: 1 }}>
            Download EXCEL
          </Button>
          <Button variant="contained" startIcon={<PictureAsPdfIcon />}>
            <PDFDownloadLink document={<ModeFourPdfDocument session={session} />} fileName={"mode_four_" + session.defaultConfigurations.sessionId + ".pdf"}
              style={{ color: "white", textDecoration: "none" }}>
              {({ blob, url, loading, error }) =>
                loading ? 'Loading...' : 'Download'
              }
            </PDFDownloadLink>
          </Button>
        </Box>
      </Box>

    </Box>
  );
};