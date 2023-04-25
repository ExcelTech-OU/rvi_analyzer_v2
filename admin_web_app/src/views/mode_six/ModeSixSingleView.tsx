import { Alert, Box, Button, Container, Dialog, DialogContent, DialogTitle, Divider, IconButton, Tooltip as Tooltip1, List, ListItem, ListItemText, Snackbar, useMediaQuery, useTheme } from "@mui/material";
import { Visibility } from '@mui/icons-material';
import { useEffect, useState } from "react";
import CloseIcon from '@mui/icons-material/Close';
import { ModeFiveDto, ModeFourDto, ModeSixDto, ModeThreeDto } from "../../services/sessions_service";
import { CartesianGrid, Legend, Line, LineChart, ResponsiveContainer, XAxis, YAxis, Tooltip } from "recharts";


type SessionDetailsProps = {
  session: ModeSixDto;
}

export function ModeSixSingleView({ session }: SessionDetailsProps) {

  const [open, setOpen] = useState(false);
  const [openSuccess, setOpenSuccess] = useState(false);
  const [timeVsVoltage, setA] = useState([{}]);
  const [timeVsTemp, setB] = useState([{}]);
  const [timeVsResistance, setC] = useState([{}]);
  const [timeVsCurrent, setD] = useState([{}]);

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
    <Box>
      <Tooltip1 title="View Graphs">
        <IconButton onClick={handleClickOpen}
        >
          <Visibility />
        </IconButton>
      </Tooltip1>
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
            <LineChart
              width={900}
              height={300}
              data={timeVsVoltage}
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