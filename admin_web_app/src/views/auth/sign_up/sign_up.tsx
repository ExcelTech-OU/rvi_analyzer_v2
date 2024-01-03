import {
  Alert,
  Box,
  Button,
  Container,
  FormControl,
  FormHelperText,
  InputLabel,
  MenuItem,
  Select,
  SelectChangeEvent,
  Snackbar,
  TextField,
  Typography,
} from "@mui/material";
import { useFormik } from "formik";
import * as Yup from "yup";
import React, { useEffect, useState } from "react";
import { Navigate, useNavigate } from "react-router-dom";
import { useSignUpMutation } from "../../../services/sign_up_service";
import { signUpSuccess } from "./sign-up-slice";
import { useDispatch } from "react-redux";

export default function SignUp() {
  const [signUp] = useSignUpMutation();
  const [isLogin, setLogin] = useState(false);
  const navigate = useNavigate();
  const [group, setGroup] = useState("");
  const [open, setOpen] = useState(false);
  const dispatch = useDispatch();

  useEffect(() => {
    formik.handleChange;
  }, [group]);

  const handleLogin = () => {
    setLogin(true);
    navigate("/login");
  };

  const formik = useFormik({
    initialValues: {
      userName: "",
      password: "",
      confirmPassword: "",
      group: "",
    },
    validationSchema: Yup.object({
      userName: Yup.string()
        .email("Must be a valid email")
        .max(255)
        .required("Email is required"),
      password: Yup.string().max(100).required("Password is required"),
      confirmPassword: Yup.string().max(100).required("Password is required"),
      group: Yup.string().max(100).required("User group is required"),
    }),
    onSubmit: (values, actions) => {
      signUp({
        userName: values.userName,
        password: values.password,
        confirmPassword: values.confirmPassword,
        group: values.group,
        source: "WEB",
      })
        .unwrap()
        .then((payload) => {
          if (payload.state == "S1000") {
            dispatch(signUpSuccess(payload));
            navigate("/");
          }
        })
        .catch((error) => {
          actions.setSubmitting(false);
          actions.resetForm();
          setOpen(true);
        });
    },
  });

  const handleClose = (
    event?: React.SyntheticEvent | Event,
    reason?: string
  ) => {
    if (reason === "clickaway") {
      return;
    }

    setOpen(false);
  };

  const handleChangeGroup = (event: SelectChangeEvent) => {
    setGroup(event.target.value);
  };
  return (
    <>
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
                Sign up
              </Typography>
              <Typography color="textSecondary" gutterBottom variant="body2">
                Create an admin account using the RVI Analyzer admin panel
              </Typography>
            </Box>

            <TextField
              error={Boolean(formik.touched.userName && formik.errors.userName)}
              fullWidth
              helperText={formik.touched.userName && formik.errors.userName}
              label="Email Address"
              margin="normal"
              name="userName"
              type="email"
              onBlur={formik.handleBlur}
              onChange={formik.handleChange}
              value={formik.values.userName}
              variant="outlined"
            />
            <TextField
              error={Boolean(formik.touched.password && formik.errors.password)}
              fullWidth
              helperText={formik.touched.password && formik.errors.password}
              label="Password"
              margin="normal"
              name="password"
              type="password"
              onBlur={formik.handleBlur}
              onChange={formik.handleChange}
              value={formik.values.password}
              variant="outlined"
            />
            <TextField
              error={Boolean(
                formik.touched.confirmPassword && formik.errors.confirmPassword
              )}
              fullWidth
              helperText={
                formik.touched.confirmPassword && formik.errors.confirmPassword
              }
              label="Confirm Password"
              margin="normal"
              name="confirmPassword"
              type="password"
              onBlur={formik.handleBlur}
              onChange={formik.handleChange}
              value={formik.values.confirmPassword}
              variant="outlined"
            />
            <FormControl
              sx={{ my: 2 }}
              fullWidth
              error={Boolean(formik.touched.group && formik.errors.group)}
            >
              <InputLabel id="demo-simple-select-helper-label">
                User group
              </InputLabel>
              <Select
                // error={Boolean(formik.touched.group && formik.errors.group)}
                // helperText={formik.touched.userName && formik.errors.group}
                onBlur={formik.handleBlur}
                labelId="demo-simple-select-helper-label"
                id="demo-simple-select-helper"
                value={group}
                label="Group"
                name="group"
                // required
                onChange={handleChangeGroup}
              >
                <MenuItem value="">
                  <em>None</em>
                </MenuItem>
                <MenuItem value={1}>Top_Admin</MenuItem>
                <MenuItem value={2}>Admin</MenuItem>
                <MenuItem value={3}>User</MenuItem>
              </Select>
              <FormHelperText>
                {formik.touched.userName && formik.errors.group}
              </FormHelperText>
            </FormControl>
            <Box sx={{ py: 2 }}>
              <Button
                disabled={formik.isSubmitting}
                color="primary"
                fullWidth
                size="large"
                type="submit"
                variant="contained"
              >
                Sign up
              </Button>
              <Box
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
                  }}
                >
                  Already have an account ?
                </Typography>
                <Typography
                  onClick={() => navigate("/login")}
                  variant="body1"
                  color="#4dabf5"
                  sx={{
                    cursor: "pointer",
                    "&:hover": { color: "#1769aa", transitionDelay: "150ms" },
                  }}
                >
                  Login
                </Typography>
              </Box>
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
            Sign up Failed! something went wrong
          </Alert>
        </Snackbar>
      </Box>
    </>
  );
}
