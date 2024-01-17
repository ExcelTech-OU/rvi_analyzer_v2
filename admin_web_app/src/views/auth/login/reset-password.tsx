import { useFormik } from "formik";
import * as Yup from "yup";
import {
  Alert,
  Box,
  Button,
  Container,
  Snackbar,
  TextField,
  Typography,
} from "@mui/material";
import { useNavigate } from "react-router-dom";
import React, { useState } from "react";
import { useDispatch } from "react-redux";
import { loginSuccess } from "./auth-slice";
import { alignProperty } from "@mui/material/styles/cssUtils";
import { useResetDefaultPasswordMutation } from "../../../services/user_service";
import Login from "./login";

export default function Reset() {
  const [reset] = useResetDefaultPasswordMutation();
  const navigate = useNavigate();
  const [open, setOpen] = useState(false);
  const dispatch = useDispatch();
  const [resetSuccess, setResetSuccess] = useState(false);

  const handleClick = () => {
    setOpen(true);
  };

  const handleClose = (
    event?: React.SyntheticEvent | Event,
    reason?: string
  ) => {
    if (reason === "clickaway") {
      return;
    }

    setOpen(false);
  };

  const formik = useFormik({
    initialValues: {
      password: "",
    },
    validationSchema: Yup.object({
      password: Yup.string().max(100).required("Password is required"),
    }),
    onSubmit: (values, actions) => {
      reset({
        password: values.password,
        source: "WEB",
      })
        .unwrap()
        .then((payload) => {
          if (payload.status == "S1000") {
            // dispatch(loginSuccess(payload));
            setResetSuccess(true);
            console.log("success");
            navigate("/login");
          } else {
            setResetSuccess(false);
            setOpen(true);
            console.log("failed");
            navigate("/password-reset");
          }
        })
        .catch((error) => {
          setResetSuccess(false);
          actions.setSubmitting(false);
          actions.resetForm();
          console.log(error);
          setOpen(true);
        });
    },
  });

  return resetSuccess ? (
    <Login />
  ) : (
    <Box
      component="main"
      sx={{
        alignItems: "center",
        display: "flex",
        flexGrow: 1,
        minHeight: "100%",
      }}
      style={{ minHeight: "100vh" }}
    >
      <Container maxWidth="sm">
        <form onSubmit={formik.handleSubmit}>
          <Box sx={{ my: 3 }}>
            <Typography color="textPrimary" variant="h4">
              Reset password
            </Typography>
            <Typography color="textSecondary" gutterBottom variant="body2">
              Reset your password for your account
            </Typography>
          </Box>

          {/* <TextField
            error={Boolean(formik.touched.userName && formik.errors.userName)}
            fullWidth
            helperText={formik.touched.userName && formik.errors.userName}
            label="Email Address"
            margin="normal"
            name="userName"
            onBlur={formik.handleBlur}
            onChange={formik.handleChange}
            type="email"
            value={formik.values.userName}
            variant="outlined"
          /> */}
          <TextField
            error={Boolean(formik.touched.password && formik.errors.password)}
            fullWidth
            helperText={formik.touched.password && formik.errors.password}
            label="Password"
            margin="normal"
            name="password"
            onBlur={formik.handleBlur}
            onChange={formik.handleChange}
            type="password"
            value={formik.values.password}
            variant="outlined"
          />
          <Box sx={{ py: 2 }}>
            <Button
              color="primary"
              disabled={formik.isSubmitting}
              fullWidth
              size="large"
              type="submit"
              variant="contained"
            >
              Reset password
            </Button>
            {/* <Box
              sx={{
                padding: 3,
                display: "flex",
                justifyContent: "center",
                alignItems: "center",
              }}
            >
              <Typography
                color="textSecondary"
                variant="body1"
                sx={{
                  mr: 1,
                  // backgroundColor: "blue",
                }}
              >
                Don't have an account ?
              </Typography>
              <Typography
                onClick={() => handleSignUp()}
                variant="body1"
                color="#4dabf5"
                sx={{
                  cursor: "pointer",
                  "&:hover": { color: "#1769aa", transitionDelay: "150ms" },
                }}
              >
                Create account
              </Typography>
            </Box> */}
          </Box>
        </form>
      </Container>
      <Snackbar
        open={open}
        autoHideDuration={6000}
        onClose={handleClose}
        anchorOrigin={{ vertical: "bottom", horizontal: "center" }}
      >
        <Alert onClose={handleClose} severity="error" sx={{ width: "100%" }}>
          Password reset Failed! please try again later
        </Alert>
      </Snackbar>
    </Box>
  );
}
