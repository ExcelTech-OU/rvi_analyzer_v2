import { Alert, Box, Button, Dialog, DialogContent, IconButton, MenuItem, Select, Snackbar, TextField, Tooltip, Typography, useMediaQuery, useTheme } from "@mui/material";
import { Edit, Visibility } from '@mui/icons-material';
import React, { useState } from "react";
import { useFormik } from "formik";
import * as Yup from 'yup';
import { User, useUpdateUserMutation } from "../../../services/user_service";
import CloseIcon from '@mui/icons-material/Close';
import { useNavigate } from "react-router-dom";


type UserActionsProps = {
  user: User;
}

export function UserActions({ user }: UserActionsProps) {

  const [open, setOpen] = React.useState(false);
  const [openSuccess, setOpenSuccess] = React.useState(false);
  const [openFail, setOpenFail] = useState(false);

  const theme = useTheme();
  const navigate = useNavigate();
  const fullScreen = useMediaQuery(theme.breakpoints.down('md'));

  const [edit, setEdit] = useState(false);
  const [updateUser] = useUpdateUserMutation()

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
      name: user.name,
      email: user.email,
      age: user.age || 0,
      occupation: user.occupation || "Occupation",
      condition: user.condition || "Condition",
      status: user.enabled ? "ACTIVE" : "TEMPORARY_BLOCKED"

    },
    validationSchema: Yup.object({
      age: Yup
        .string()
        .max(50)
        .required('Age is required'),
      occupation: Yup
        .string()
        .max(100)
        .required('Occupation is required'),
      condition: Yup
        .string()
        .max(100)
        .required('Condition is required')
    }),
    onSubmit: (values, actions) => {
      if (!edit) {
        setEdit(true)
        actions.setSubmitting(false)
      } else {
        updateUser({
          email: values.email,
          condition: values.condition,
          age: values.age,
          occupation: values.occupation,
          status: values.status
        })
          .unwrap()
          .then((payload) => {
            if (payload.state == 'S1000') {
              actions.setSubmitting(false)
              setOpenSuccess(true)
              setEdit(false)
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
      <Tooltip title="Edit User">
        <IconButton onClick={handleClickOpen}
        >
          <Edit />
        </IconButton>
      </Tooltip>
      <Tooltip title="View Sessions">
        <IconButton onClick={() => navigate("/sessions/sp/" + user.id)}
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
              label="Email"
              margin="normal"
              name="email"
              onBlur={formik.handleBlur}
              onChange={formik.handleChange}
              value={formik.values.email}
              variant="outlined"
              disabled
            />
            <TextField
              error={Boolean(formik.touched.age && formik.errors.age)}
              fullWidth
              helperText={formik.touched.age && formik.errors.age}
              label="Age"
              margin="normal"
              name="age"
              onBlur={formik.handleBlur}
              onChange={formik.handleChange}
              type="text"
              value={formik.values.age}
              variant="outlined"
              disabled={!edit}
            />
            <TextField
              error={Boolean(formik.touched.condition && formik.errors.condition)}
              fullWidth
              helperText={formik.touched.condition && formik.errors.condition}
              label="Condition"
              margin="normal"
              name="condition"
              onBlur={formik.handleBlur}
              onChange={formik.handleChange}
              type="text"
              value={formik.values.condition}
              variant="outlined"
              disabled={!edit}
            />
            <TextField
              error={Boolean(formik.touched.occupation && formik.errors.occupation)}
              fullWidth
              helperText={formik.touched.occupation && formik.errors.occupation}
              label="Occupation"
              margin="normal"
              name="occupation"
              onBlur={formik.handleBlur}
              onChange={formik.handleChange}
              type="text"
              value={formik.values.occupation}
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
          <Snackbar open={openSuccess} autoHideDuration={6000} onClose={handleCloseSuccess} anchorOrigin={{ vertical: 'top', horizontal: 'center' }}>
            <Alert onClose={handleCloseSuccess} severity="success" sx={{ width: '100%' }}>
              {user.name} Update success
            </Alert>
          </Snackbar>

          <Snackbar open={openFail} autoHideDuration={6000} onClose={handleCloseFail} anchorOrigin={{ vertical: 'top', horizontal: 'center' }}>
            <Alert onClose={handleCloseFail} severity="error" sx={{ width: '100%' }}>
              {user.name} Update failed
            </Alert>
          </Snackbar>
        </DialogContent>

      </Dialog>
    </Box>
  );
};