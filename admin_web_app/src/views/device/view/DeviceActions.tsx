import { Alert, Box, Button, Dialog, DialogContent, IconButton, MenuItem, Select, Snackbar, TextField, Tooltip, Typography, useMediaQuery, useTheme } from "@mui/material";
import { Edit, Visibility } from '@mui/icons-material';
import React, { useState } from "react";
import { Device, useUpdateDeviceMutation } from "../../../services/device_service";
import { useFormik } from "formik";
import * as Yup from 'yup';
import CloseIcon from '@mui/icons-material/Close';
import { useNavigate } from "react-router-dom";


type DeviceProps = {
  device: Device;
}

export function DeviceActions({ device }: DeviceProps) {

  const [open, setOpen] = React.useState(false);
  const [openSuccess, setOpenSuccess] = useState(false);
  const [openFail, setOpenFail] = useState(false);

  const [updateDevice] = useUpdateDeviceMutation()

  const theme = useTheme();
  const navigate = useNavigate();
  const fullScreen = useMediaQuery(theme.breakpoints.down('md'));

  const [edit, setEdit] = useState(false);

  const handleClickOpen = () => {
    setOpen(true);
  };

  const handleClose = () => {
    setOpen(false);
  };

  const handleCloseSuccess = () => {
    setOpenSuccess(false);
  };

  const handleCloseFail = () => {
    setOpenFail(false);
  };

  const formik = useFormik({
    initialValues: {
      name: device.name,
      macAddress: device.macAddress,
      firmwareVersion: device.firmwareVersion,
      batchNo: device.batchNo,
      status: device.status

    },
    validationSchema: Yup.object({
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
      if (!edit) {
        setEdit(true)
        actions.setSubmitting(false)
      } else {
        updateDevice({
          name: values.name,
          batchNo: values.batchNo,
          firmwareVersion: values.firmwareVersion,
          status: values.status
        })
          .unwrap()
          .then((payload) => {
            if (payload.state == 'S1000') {
              setOpenSuccess(true)
              setEdit(false)
              actions.setSubmitting(false)
            }
          })
          .catch((error) => {
            actions.setSubmitting(false)
            setOpenFail(true)
          });
      }
    }
  });

  return (
    <Box>
      <Tooltip title="Edit Device">
        <IconButton onClick={handleClickOpen}
        >
          <Edit />
        </IconButton>
      </Tooltip>
      <Tooltip title="View Sessions">
        <IconButton onClick={() => navigate("/sessions/device/" + device.id)}
        >
          <Visibility />
        </IconButton>
      </Tooltip>
      <Dialog
        fullScreen={fullScreen}
        open={open}
        onClose={handleClose}
        aria-labelledby="responsive-dialog-title"
      >
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
              fullWidth
              label="Name"
              margin="normal"
              name="name"
              onBlur={formik.handleBlur}
              value={formik.values.name}
              variant="outlined"
              disabled
            />
            <TextField
              fullWidth
              label="Mac Address"
              margin="normal"
              name="email"
              onBlur={formik.handleBlur}
              onChange={formik.handleChange}
              value={formik.values.macAddress}
              variant="outlined"
              disabled
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
              disabled={!edit}
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
              disabled={!edit}
            />
            <Select
              fullWidth
              labelId="demo-simple-select-label"
              id="batchNo"
              value={formik.values.status}
              name="status"
              onChange={formik.handleChange}
              disabled={!edit}
            >
              <MenuItem value={"ACTIVE"}>ACTIVE</MenuItem>
              <MenuItem value={"TEMPORARY_BLOCKED"} color="orange">TEMPORARY_BLOCKED</MenuItem>
              <MenuItem value={"DISABLED"}>DISABLED</MenuItem>
            </Select>
            <Box sx={{ py: 2 }}>
              <Button
                color="primary"
                disabled={formik.isSubmitting}
                fullWidth
                size="large"
                type="submit"
                variant="contained"
              >
                {edit ? "Save" : "Edit"}
              </Button>
            </Box>
          </form>
          <Snackbar open={openSuccess} autoHideDuration={2000} onClose={handleCloseSuccess} anchorOrigin={{ vertical: 'top', horizontal: 'center' }}>
            <Alert onClose={handleCloseSuccess} severity="success" sx={{ width: '100%' }}>
              {device.name} Update success
            </Alert>
          </Snackbar>
          <Snackbar open={openFail} autoHideDuration={2000} onClose={handleCloseFail} anchorOrigin={{ vertical: 'top', horizontal: 'center' }}>
            <Alert onClose={handleCloseFail} severity="error" sx={{ width: '100%' }}>
              {device.name} Update Failed
            </Alert>
          </Snackbar>
        </DialogContent>

      </Dialog>
    </Box>
  );
};