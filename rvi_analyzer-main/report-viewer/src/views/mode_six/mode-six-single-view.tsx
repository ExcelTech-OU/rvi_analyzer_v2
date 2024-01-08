import { Box, Button, Container, useMediaQuery, useTheme, Grid, Typography } from "@mui/material";
import { useEffect, useState } from "react";
import { ModeSixDto } from "../../services/sessions_service";
import { CartesianGrid, Legend, Line, LineChart, XAxis, YAxis, Tooltip } from "recharts";
import { PDFDownloadLink } from "@react-pdf/renderer";
import ModeSixPdfDocument from "./mode-six-pdf";
import { handleGenerateExcelModeSix } from "./mode-six-excel";
import PictureAsPdfIcon from '@mui/icons-material/PictureAsPdf';
import GridOnIcon from '@mui/icons-material/GridOn';


type SessionDetailsProps = {
  session: ModeSixDto;
}

export function ModeSixSingleView({ session }: SessionDetailsProps) {

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
                Fixed Current : <Typography variant="subtitle2" gutterBottom display="inline" color="black">{session.sessionConfigurationModeSix.fixedCurrent}</Typography>
              </Typography>
              <Typography variant="subtitle1" gutterBottom >
                Max Voltage : <Typography variant="subtitle2" gutterBottom display="inline" color="black">{session.sessionConfigurationModeSix.maxVoltage}</Typography>
              </Typography>
              <Typography variant="subtitle1" gutterBottom >
                Time Duration  : <Typography variant="subtitle2" gutterBottom display="inline" color="black">{session.sessionConfigurationModeSix.timeDuration}</Typography>
              </Typography>

            </Grid>
          </Grid>
        </Container>

        <LineChart
          width={900}
          height={300}
          data={timeVsVoltage}
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
        <Box display="flex" justifyContent="flex-end" sx={{ mr: 3 }}>
          <Button variant="contained" startIcon={<GridOnIcon />} onClick={() => handleGenerateExcelModeSix(session)} sx={{ mr: 1 }}>
            Download EXCEL
          </Button>
          <Button variant="contained" startIcon={<PictureAsPdfIcon />}>
            <PDFDownloadLink document={<ModeSixPdfDocument session={session} />} fileName={"mode_six_" + session.defaultConfigurations.sessionId + ".pdf"}
              style={{ color: "white", textDecoration: "none" }}>
              {({ blob, url, loading, error }) =>
                loading ? 'Loading...' : 'Download PDF'
              }
            </PDFDownloadLink>
          </Button>
        </Box>
      </Box>
    </Box>
  );
};