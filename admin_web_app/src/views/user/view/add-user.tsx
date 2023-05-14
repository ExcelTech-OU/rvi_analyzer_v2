import { Alert, Box, Button, Dialog, DialogContent, IconButton, MenuItem, Select, Snackbar, TextField, Typography, useMediaQuery, useTheme } from "@mui/material";
import React, { useState } from "react";
import { useFormik } from "formik";
import { User, useAddUserMutation, useUpdateUserMutation } from "../../../services/user_service";
import CloseIcon from '@mui/icons-material/Close';


type AddUserProps = {
  open: boolean;
  changeOpenStatus: (status: boolean) => void;
}

export function AddUserModel({ open, changeOpenStatus }: AddUserProps) {

  const [openSuccess, setOpenSuccess] = React.useState(false);
  const [openFail, setOpenFail] = useState(false);

  const theme = useTheme();
  const fullScreen = useMediaQuery(theme.breakpoints.down('md'));

  const [addUser] = useAddUserMutation()


  const handleCloseSuccess = () => {
    setOpenSuccess(false);
  };

  const handleCloseFail = () => {
    setOpenFail(false);
  };

  const formik = useFormik({
    initialValues: {
      username: "",
      group: "USER",
      status: "ACTIVE"

    },
    onSubmit: (values, actions) => {

      addUser({
        username: values.username,
        group: values.group,
        status: values.status
      })
        .unwrap()
        .then((payload) => {
          if (payload.status == 'S1000') {
            actions.setSubmitting(false)
            setOpenSuccess(true)
          }
        })
        .catch((error) => {
          actions.setSubmitting(false)
          setOpenFail(true)
        });

    }
  });

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
            label="Email"
            margin="normal"
            name="username"
            onBlur={formik.handleBlur}
            onChange={formik.handleChange}
            value={formik.values.username}
            variant="outlined"
          />
          <TextField
            fullWidth
            label="Group"
            margin="normal"
            name="group"
            onBlur={formik.handleBlur}
            onChange={formik.handleChange}
            value={formik.values.group}
            variant="outlined"
            disabled
          />

          <Select
            fullWidth
            labelId="demo-simple-select-label"
            id="batchNo"
            value={formik.values.status}
            name="status"
            onChange={formik.handleChange}
            disabled={true}
          >
            <MenuItem value={"ACTIVE"}>ACTIVE</MenuItem>
            <MenuItem value={"TEMPORARY_BLOCKED"} color="orange">TEMPORARY_BLOCKED</MenuItem>
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
              ADD
            </Button>
          </Box>
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

    </Dialog>
  );
};