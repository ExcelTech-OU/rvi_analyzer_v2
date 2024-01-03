import {
  Alert,
  Box,
  Button,
  Dialog,
  DialogContent,
  FormControl,
  FormHelperText,
  IconButton,
  InputLabel,
  MenuItem,
  Select,
  Snackbar,
  TextField,
  Typography,
  useMediaQuery,
  useTheme,
} from "@mui/material";
import React, { useState } from "react";
import { useFormik } from "formik";
import {
  User,
  useAddUserMutation,
  useUpdateUserMutation,
} from "../../../services/user_service";
import * as Yup from "yup";

import CloseIcon from "@mui/icons-material/Close";

type AddUserProps = {
  open: boolean;
  changeOpenStatus: (status: boolean) => void;
};

export function AddUserModel({ open, changeOpenStatus }: AddUserProps) {
  const [openSuccess, setOpenSuccess] = React.useState(false);
  const [openFail, setOpenFail] = useState(false);
  const [group, setGroup] = useState("");

  const theme = useTheme();
  const fullScreen = useMediaQuery(theme.breakpoints.down("md"));

  const [addUser] = useAddUserMutation();

  const handleCloseSuccess = () => {
    setOpenSuccess(false);
  };

  const handleCloseFail = () => {
    setOpenFail(false);
  };

  const formik = useFormik({
    initialValues: {
      email: "",
      group: "",
      status: "",
    },
    validationSchema: Yup.object({
      email: Yup.string()
        .email("Must be a valid email")
        .max(255)
        .required("Email is required"),
      group: Yup.string().max(25).required("Group is required"),
      status: Yup.string().max(255).required("Status is required"),
    }),
    onSubmit: (values, actions) => {
      addUser({
        username: values.email,
        group: values.group,
        status: values.status,
      })
        .unwrap()
        .then((payload) => {
          if (payload.status == "S1000") {
            actions.setSubmitting(false);
            actions.resetForm();
            setOpenSuccess(true);
          }
        })
        .catch((error) => {
          actions.setSubmitting(false);
          setOpenFail(true);
        });
    },
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
            position: "absolute",
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
            ></Typography>
          </Box>

          <TextField
            fullWidth
            label="Email"
            margin="normal"
            name="email"
            onBlur={formik.handleBlur}
            onChange={formik.handleChange}
            value={formik.values.email}
            variant="outlined"
            error={Boolean(formik.touched.email && formik.errors.email)}
            helperText={formik.touched.email && formik.errors.email}
          />
          {/* <TextField
            fullWidth
            label="Group"
            margin="normal"
            name="group"
            onBlur={formik.handleBlur}
            onChange={formik.handleChange}
            value={formik.values.group}
            variant="outlined"
          /> */}
          <FormControl
            sx={{ mt: 2 }}
            fullWidth
            error={Boolean(formik.touched.group && formik.errors.group)}
          >
            <InputLabel
            // id="demo-simple-select-helper-label"
            >
              Group
            </InputLabel>
            <Select
              fullWidth
              // labelId="demo-simple-select-label"
              id="group"
              label="Group"
              value={formik.values.group}
              name="group"
              onChange={formik.handleChange}
              onBlur={formik.handleBlur}
            >
              <MenuItem value={"TOP_ADMIN"}>TOP_ADMIN</MenuItem>
              <MenuItem value={"ADMIN"}>ADMIN</MenuItem>
              <MenuItem value={"USER"}>USER</MenuItem>
            </Select>
            <FormHelperText>
              {formik.touched.group && formik.errors.group}
            </FormHelperText>
          </FormControl>

          <FormControl
            sx={{ mt: 2 }}
            fullWidth
            error={Boolean(formik.touched.status && formik.errors.status)}
          >
            <InputLabel
            // id="demo-simple-select-helper-label"
            >
              Status
            </InputLabel>
            <Select
              fullWidth
              // labelId="demo-simple-select-label"
              id="status"
              label="Status"
              value={formik.values.status}
              name="status"
              onChange={formik.handleChange}
              onBlur={formik.handleBlur}
            >
              <MenuItem value={"ACTIVE"}>ACTIVE</MenuItem>
              <MenuItem value={"TEMPORARY_BLOCKED"} color="orange">
                TEMPORARY_BLOCKED
              </MenuItem>
              <MenuItem value={"INACTIVE"}>INACTIVE</MenuItem>
            </Select>
            <FormHelperText>
              {formik.touched.status && formik.errors.status}
            </FormHelperText>
          </FormControl>
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
        <Snackbar
          open={openSuccess}
          autoHideDuration={6000}
          onClose={handleCloseSuccess}
          anchorOrigin={{ vertical: "top", horizontal: "center" }}
        >
          <Alert
            onClose={handleCloseSuccess}
            severity="success"
            sx={{ width: "100%" }}
          >
            Saving success
          </Alert>
        </Snackbar>

        <Snackbar
          open={openFail}
          autoHideDuration={6000}
          onClose={handleCloseFail}
          anchorOrigin={{ vertical: "top", horizontal: "center" }}
        >
          <Alert
            onClose={handleCloseFail}
            severity="error"
            sx={{ width: "100%" }}
          >
            Saving failed
          </Alert>
        </Snackbar>
      </DialogContent>
    </Dialog>
  );
}
