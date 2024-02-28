import { Alert, Box, Button, Dialog, DialogContent, FormControl, Grid, IconButton, InputLabel, MenuItem, Select, Snackbar, TextField, Typography, useMediaQuery, useTheme } from "@mui/material";
import React, { useEffect, useState } from "react";
import { useFormik } from "formik";
import AsyncSelect from 'react-select/async';

import CloseIcon from '@mui/icons-material/Close';
import { FullGarment, useUpdateEndLineQCMutation } from "../../../services/softmatter_service";
import { SoNumber, useGetAllPoNumbersMutation, useGetAllSoNumbersMutation } from "../../../services/common_service";


type UpdateEndLineQCProps = {
  open: boolean;
  changeOpenStatus: (status: boolean) => void;
  fullGarment: FullGarment | null
}

interface Option {
  value: string;
  label: string;
}

export function UpdateEndLinePopup({ open, changeOpenStatus, fullGarment }: UpdateEndLineQCProps) {

  const [openSuccess, setOpenSuccess] = React.useState(false);
  const [openFail, setOpenFail] = useState(false);
  const [idleCurrentStatus, setIdleCurrentStatus] = React.useState('');
  const [flCurrentStatus, setFullLoadCurrentStatus] = React.useState('');
  const [editClicked, setEditClicked] = React.useState(false);

  const theme = useTheme();
  const fullScreen = useMediaQuery(theme.breakpoints.down('md'));

  const [getAllSONO] = useGetAllSoNumbersMutation()
  const [getAllPONO] = useGetAllPoNumbersMutation()
  const [update] = useUpdateEndLineQCMutation()


  const handleCloseSuccess = () => {
    setOpenSuccess(false);
  };

  const handleCloseFail = () => {
    setOpenFail(false);
  };


  const formik = useFormik({
    initialValues: {
      idleCurrent: fullGarment != null ? fullGarment.idleCurrent ?? "" : "",
      settingsIdleCurrentMin: fullGarment != null ? fullGarment.settingsIdleCurrentMin ?? "" : "",
      settingsIdleCurrentMax: fullGarment != null ? fullGarment.settingsIdleCurrentMax ?? "" : "",
      idleCurrentStatus: "",
      flCurrent: fullGarment != null ? fullGarment.flCurrent ?? "" : "",
      settingsFlCurrentMin: fullGarment != null ? fullGarment.settingsFLCurrentMin ?? "" : "",
      settingsFlCurrentMax: fullGarment != null ? fullGarment.settingsFLCurrentMax ?? "" : "",
      flCurrentStatus: "",
      dateCode: fullGarment != null ? fullGarment.dateCode ?? "" : "",
      soNumber: "",
      productionOrder: "",
      qrCode: fullGarment != null ? fullGarment.qrCode ?? "" : "",
    },

    onSubmit: (values, actions) => {
      console.log("AAAAAAAAA")
      update({
        data: {
          "id": fullGarment?._id,
          "qrCode": fullGarment!.qrCode,
          "idleCurrentStatus": values.idleCurrentStatus.length == 0 ? fullGarment!.idleCurrentStatus : values.idleCurrentStatus,
          "flCurrentStatus": values.flCurrentStatus.length == 0 ? fullGarment!.flCurrentStatus : values.flCurrentStatus,
          "soNumber": values.soNumber.length == 0 ? fullGarment!.soNumber : values.soNumber,
          "productionOrder": values.productionOrder.length == 0 ? fullGarment!.productionOrder : values.productionOrder,
        },
      })
        .unwrap()
        .then((payload) => {
          if (payload.status == 'S1000') {
            actions.setSubmitting(false)
            setOpenSuccess(true)
          } else {
            actions.setSubmitting(false)
            setOpenFail(true)
          }
        })
        .catch((error) => {
          actions.setSubmitting(false)
          setOpenFail(true)
        });

    }
  });

  const loadOptionsSO = async (inputValue: String) => {
    const options: Option[] = [];
    const result = await getAllSONO({ data: { date: null, filterType: "NAME", filterValue: inputValue }, page: "all" });

    console.log(result);

    if ('data' in result) {
      const options = result.data?.soNumbers.map((item: SoNumber) => ({
        value: item.name.toString(),
        label: item.name,
      }));
      console.log(options);
      return options ?? [];
    }
    return options;
  };

  const loadOptionsPO = async (inputValue: String) => {
    const options: Option[] = [];
    const result = await getAllPONO({ data: { date: null, filterType: "NAME", filterValue: inputValue }, page: "all" });

    console.log(result);

    if ('data' in result) {
      const options = result.data?.poNumbers.map((item: SoNumber) => ({
        value: item.name.toString(),
        label: item.name,
      }));
      console.log(options);
      return options ?? [];
    }
    return options;
  };

  useEffect(() => {
    setIdleCurrentStatus(fullGarment != null ? fullGarment.idleCurrentStatus : "")
    setFullLoadCurrentStatus(fullGarment != null ? fullGarment.flCurrentStatus : "")
    setEditClicked(false)
  }, [fullGarment]);

  return (

    <Dialog
      fullScreen={fullScreen}
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
            label="QR Code"
            margin="normal"
            name="qr code"
            onBlur={formik.handleBlur}
            onChange={formik.handleChange}
            value={fullGarment != null ? fullGarment.qrCode ?? "" : ""}
            variant="outlined"
            disabled
            error={Boolean(formik.touched.qrCode && formik.errors.qrCode)}
            helperText={formik.touched.qrCode && formik.errors.qrCode}
          />

          <Typography variant="subtitle2" sx={{ mb: 1 }} >Old: {fullGarment != null ? fullGarment.soNumber ?? "" : ""}</Typography>
          <AsyncSelect
            loadOptions={loadOptionsSO}
            defaultOptions
            isClearable
            cacheOptions
            placeholder="So Number"
            isDisabled={!editClicked}
            onChange={(selectedOption) => {
              formik.setFieldValue('soNumber', selectedOption?.value);
            }}
            // styles={{
            //   // Adjust the height here
            //   control: (provided) => ({
            //     ...provided,
            //     height: '50px',
            //     marginBottom: '8px' // Change the height value as needed
            //   }),
            //   menu: base => ({
            //     ...base,
            //     zIndex: 100
            //   })
            // }}
          />
          <Typography variant="subtitle2" sx={{ mb: 1 }} >Old: {fullGarment != null ? fullGarment.productionOrder ?? "" : ""}</Typography>
          <AsyncSelect
            loadOptions={loadOptionsPO}
            defaultOptions
            isClearable
            cacheOptions
            placeholder="Production Order"
            isDisabled={!editClicked}

            onChange={(selectedOption) => {
              formik.setFieldValue('productionOrder', selectedOption?.value);
            }}
            // styles={{
            //   control: (provided) => ({
            //     ...provided,
            //     height: '50px',
            //     marginBottom: '8px' // Change the height value as needed
            //   }),
            //   menu: base => ({
            //     ...base,
            //     zIndex: 100
            //   })
            // }}
          />
          <div style={{ display: 'flex' }}>
            <Grid item xs={6} sm={6} md={6} >
              <FormControl style={{ minWidth: "100%" }} sx={{ mt: 1 }}>
                <InputLabel id="demo-simple-select-label">Idle Current Status</InputLabel>
                <Select
                  labelId="demo-simple-select-label"
                  id="demo-simple-select"
                  value={idleCurrentStatus}
                  label="Idle Current Status"
                  onChange={(value) => {
                    setIdleCurrentStatus(value.target.value);
                    formik.setFieldValue('idleCurrentStatus', value.target.value);
                  }}
                  disabled={!editClicked}
                  MenuProps={{
                    PaperProps: {
                      sx: {
                        "& .MuiMenuItem-root.Mui-selected": {
                          backgroundColor: "#e0e0e0"
                        },
                        "& .MuiMenuItem-root:hover": {
                          backgroundColor: "#e0e0e0"
                        },
                        "& .MuiMenuItem-root.Mui-selected:hover": {
                          backgroundColor: "#e0e0e0"
                        }
                      }
                    }
                  }}

                >
                  <MenuItem value={"PASSED"}>PASSED</MenuItem>
                  <MenuItem value={"FAILED"}>FAILED</MenuItem>
                </Select>
              </FormControl>
            </Grid>
            <Grid item xs={6} sm={6} md={6} >
              <FormControl style={{ minWidth: "100%" }} sx={{ mt: 1, ml: 1, pr: 1 }}>
                <InputLabel id="demo-simple-select-label">Full Load Current Status</InputLabel>
                <Select
                  labelId="demo-simple-select-label"
                  id="demo-simple-select"
                  value={flCurrentStatus}
                  disabled={!editClicked}
                  label="Full Load Current Status"
                  onChange={(value) => {
                    setFullLoadCurrentStatus(value.target.value);
                    formik.setFieldValue('flCurrentStatus', value.target.value);
                  }}
                  MenuProps={{
                    PaperProps: {
                      sx: {
                        "& .MuiMenuItem-root.Mui-selected": {
                          backgroundColor: "#e0e0e0"
                        },
                        "& .MuiMenuItem-root:hover": {
                          backgroundColor: "#e0e0e0"
                        },
                        "& .MuiMenuItem-root.Mui-selected:hover": {
                          backgroundColor: "#e0e0e0"
                        }
                      }
                    }
                  }}

                >
                  <MenuItem value={"PASSED"}>PASSED</MenuItem>
                  <MenuItem value={"FAILED"}>FAILED</MenuItem>
                </Select>
              </FormControl>
            </Grid>
          </div>
          <div style={{ display: 'flex' }}>
            <TextField
              fullWidth
              label="Idle Current"
              margin="normal"
              name="idleCurrent"
              onBlur={formik.handleBlur}
              onChange={formik.handleChange}
              value={fullGarment != null ? fullGarment.idleCurrent ?? "" : ""}
              variant="outlined"
              disabled
              error={Boolean(formik.touched.idleCurrent && formik.errors.idleCurrent)}
              helperText={formik.touched.idleCurrent && formik.errors.idleCurrent}
            />
            <TextField
              fullWidth
              label="Full Load Current"
              margin="normal"
              name="flCurrent"
              onBlur={formik.handleBlur}
              onChange={formik.handleChange}
              value={fullGarment != null ? fullGarment.flCurrent ?? "" : ""}
              variant="outlined"
              disabled
              sx={{ ml: 1 }}
              error={Boolean(formik.touched.flCurrent && formik.errors.flCurrent)}
              helperText={formik.touched.flCurrent && formik.errors.flCurrent}
            />
          </div>
          <div style={{ display: 'flex' }}>
            <TextField
              fullWidth
              label="Idle Current Min"
              margin="normal"
              name="settingsIdleCurrentMin"
              onBlur={formik.handleBlur}
              onChange={formik.handleChange}
              value={fullGarment != null ? fullGarment.settingsIdleCurrentMin ?? "" : ""}
              variant="outlined"
              disabled
              error={Boolean(formik.touched.settingsIdleCurrentMin && formik.errors.settingsIdleCurrentMin)}
              helperText={formik.touched.settingsIdleCurrentMin && formik.errors.settingsIdleCurrentMin}
            />
            <TextField
              fullWidth
              label="Idle Current Max"
              margin="normal"
              name="settingsIdleCurrentMax"
              onBlur={formik.handleBlur}
              onChange={formik.handleChange}
              value={fullGarment != null ? fullGarment.settingsIdleCurrentMax ?? "" : ""}
              variant="outlined"
              disabled
              sx={{ ml: 1 }}
              error={Boolean(formik.touched.settingsIdleCurrentMax && formik.errors.settingsIdleCurrentMax)}
              helperText={formik.touched.settingsIdleCurrentMax && formik.errors.settingsIdleCurrentMax}
            />
          </div>
          <div style={{ display: 'flex' }}>
            <TextField
              fullWidth
              label="Full Load Current Min"
              margin="normal"
              name="settingsFlCurrentMin"
              onBlur={formik.handleBlur}
              onChange={formik.handleChange}
              value={fullGarment != null ? fullGarment.settingsFLCurrentMin ?? "" : ""}
              variant="outlined"
              disabled
              error={Boolean(formik.touched.settingsFlCurrentMin && formik.errors.settingsFlCurrentMin)}
              helperText={formik.touched.settingsFlCurrentMin && formik.errors.settingsFlCurrentMin}
            />
            <TextField
              fullWidth
              label="Full Load Current Max"
              margin="normal"
              name="settingsFlCurrentMax"
              onBlur={formik.handleBlur}
              onChange={formik.handleChange}
              value={fullGarment != null ? fullGarment.settingsFLCurrentMax ?? "" : ""}
              variant="outlined"
              disabled
              sx={{ ml: 1 }}
              error={Boolean(formik.touched.settingsFlCurrentMax && formik.errors.settingsFlCurrentMax)}
              helperText={formik.touched.settingsFlCurrentMax && formik.errors.settingsFlCurrentMax}
            />
          </div>

          {!editClicked ? <Box sx={{ py: 2 }}>
            <Button
              color="primary"
              disabled={formik.isSubmitting}
              fullWidth
              size="large"
              variant="contained"
              onClick={() => setEditClicked(true)}
            >
              Edit
            </Button>
          </Box> :
            <Box sx={{ py: 2 }}>
              <div style={{ display: 'flex' }}>
                <Button
                  color="error"
                  disabled={formik.isSubmitting}
                  fullWidth
                  size="large"
                  variant="contained"
                  onClick={() => setEditClicked(false)}
                >
                  Cancel
                </Button>
                <Button
                  color="success"
                  disabled={formik.isSubmitting}
                  fullWidth
                  size="large"
                  variant="contained"
                  type="submit"
                  sx={{ ml: 1 }}
                >
                  Save
                </Button>
              </div>
            </Box>}
        </form>
        <Snackbar open={openSuccess} autoHideDuration={6000} onClose={handleCloseSuccess} anchorOrigin={{ vertical: 'top', horizontal: 'center' }}>
          <Alert onClose={handleCloseSuccess} severity="success" sx={{ width: '100%' }}>
            Saving success
          </Alert>
        </Snackbar>

        <Snackbar open={openFail} autoHideDuration={6000} onClose={handleCloseFail} anchorOrigin={{ vertical: 'top', horizontal: 'center' }}>
          <Alert onClose={handleCloseFail} severity="error" sx={{ width: '100%' }}>
            Saving failed
          </Alert>
        </Snackbar>
      </DialogContent>

    </Dialog >
  );
};