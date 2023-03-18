import { Alert, Box, Button, Dialog, DialogContent, IconButton, Snackbar, TextField, Typography, useMediaQuery, useTheme } from "@mui/material";
import { useEffect, useState } from "react";
import { useFormik } from "formik";
import * as Yup from 'yup';
import { useAddDeviceMutation } from "../../../services/device_service";
import CloseIcon from '@mui/icons-material/Close';

type AddDeviceProps = {
  openModel: boolean
  close: () => void
}

export function AddDevice({ openModel, close }: AddDeviceProps) {

  const [openSuccess, setOpenSuccess] = useState(false);
  const [openFail, setOpenFail] = useState(false);
  const [addDevice] = useAddDeviceMutation()
  const theme = useTheme();
  const fullScreen = useMediaQuery(theme.breakpoints.down('md'));

  const [isSubmitting, setIsSubmitting] = useState(false);

  const handleClickOpenSuccess = () => {
    setOpenSuccess(true);
  };

  const handleCloseFail = () => {
    setOpenFail(false);
  };

  const handleClickOpenFail = () => {
    setOpenFail(true);
  };

  const handleCloseSuccess = () => {
    setOpenSuccess(false);
  };

  const formik = useFormik({
    initialValues: {
      macAddress: '',
      name: '',
      firmwareVersion: '',
      batchNo: ''

    },
    validationSchema: Yup.object({
      name: Yup
        .string()
        .max(50)
        .required('Name is required'),
      macAddress: Yup
        .string()
        .max(100)
        .required('Mac Address is required'),
      firmwareVersion: Yup
        .string()
        .max(50)
        .required('Firmware version is required'),
      batchNo: Yup
        .string()
        .max(100)
        .required('Batch No is required')
    }),
    onSubmit: (values, actions) => {
      addDevice({
        name: values.name,
        macAddress: values.macAddress,
        batchNo: values.batchNo,
        firmwareVersion: values.firmwareVersion
      })
        .unwrap()
        .then((payload) => {
          if (payload.state == 'S1000') {
            setOpenSuccess(true)
            close()
          }
        })
        .catch((error) => {
          actions.setSubmitting(false)
          setOpenFail(true)
        });
    }
  });

  useEffect(() => {
    setOpenSuccess(false)
    setOpenFail(false)
  }, []);

  return (
    <Box>
      <Dialog
        fullScreen={fullScreen}
        open={openModel}
        onClose={close}
        aria-labelledby="responsive-dialog-title"
      >
        <DialogContent>
          <IconButton
            aria-label="close"
            onClick={close}
            sx={{
              position: 'absolute',
              right: 15,
              top: 8,
              color: (theme) => theme.palette.grey[500],
            }}
          >
            <CloseIcon />
          </IconButton>
          <form onSubmit={formik.handleSubmit}>
            <Box sx={{ my: 3 }}>

              <Typography
                color="textSecondary"
                gutterBottom
                variant="body2"
              >
              </Typography>
            </Box>

            <TextField
              error={Boolean(formik.touched.name && formik.errors.name)}
              fullWidth
              helperText={formik.touched.name && formik.errors.name}
              label="Name"
              margin="normal"
              name="name"
              onBlur={formik.handleBlur}
              onChange={formik.handleChange}
              value={formik.values.name}
              variant="outlined"
            />
            <TextField
              error={Boolean(formik.touched.macAddress && formik.errors.macAddress)}
              fullWidth
              helperText={formik.touched.macAddress && formik.errors.macAddress}
              label="Mac Address"
              margin="normal"
              name="macAddress"
              onBlur={formik.handleBlur}
              onChange={formik.handleChange}
              value={formik.values.macAddress}
              variant="outlined"
            />
            <TextField
              error={Boolean(formik.touched.firmwareVersion && formik.errors.firmwareVersion)}
              fullWidth
              helperText={formik.touched.firmwareVersion && formik.errors.firmwareVersion}
              label="Firmware Version"
              margin="normal"
              name="firmwareVersion"
              onBlur={formik.handleBlur}
              onChange={formik.handleChange}
              type="text"
              value={formik.values.firmwareVersion}
              variant="outlined"
            />
            <TextField
              error={Boolean(formik.touched.batchNo && formik.errors.batchNo)}
              fullWidth
              helperText={formik.touched.batchNo && formik.errors.batchNo}
              label="Batch No"
              margin="normal"
              name="batchNo"
              onBlur={formik.handleBlur}
              onChange={formik.handleChange}
              type="text"
              value={formik.values.batchNo}
              variant="outlined"
            />
            <Box sx={{ py: 2 }}>
              <Button
                color="primary"
                disabled={isSubmitting}
                fullWidth
                size="large"
                type="submit"
                variant="contained"
              >
                Add Device
              </Button>
            </Box>
          </form>
          <Snackbar open={openSuccess} autoHideDuration={2000} onClose={handleCloseSuccess} anchorOrigin={{ vertical: 'top', horizontal: 'center' }}>
            <Alert onClose={handleCloseSuccess} severity="success" sx={{ width: '100%' }}>
              {formik.values.name} Save success
            </Alert>
          </Snackbar>
          <Snackbar open={openFail} autoHideDuration={2000} onClose={handleCloseFail} anchorOrigin={{ vertical: 'top', horizontal: 'center' }}>
            <Alert onClose={handleCloseFail} severity="error" sx={{ width: '100%' }}>
              {formik.values.name} Save Failed
            </Alert>
          </Snackbar>
        </DialogContent>

      </Dialog>
    </Box>
  );
};