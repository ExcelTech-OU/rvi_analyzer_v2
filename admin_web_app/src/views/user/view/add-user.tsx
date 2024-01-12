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
import React, { useEffect, useState } from "react";
import { useFormik } from "formik";
import {
  User,
  useAddUserMutation,
  useGetUsersQuery,
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
  const { data, error, isLoading } = useGetUsersQuery("");
  const [openFail, setOpenFail] = useState(false);
  const [formReset, setFormReset] = useState(false);
  const [supervisor, setSupervisor] = useState(false);
  var userRoles: string | string[] = [];
  var admin = "";

  // if (open != null) {
  //   setFormReset(open);
  // }

  // useEffect(() => {
  //   formik.resetForm();
  // }, [formReset]);

  //filters users according to admin's permissions
  if (localStorage.getItem("roles") === "") {
    console.log("roles empty");
  } else {
    userRoles = localStorage
      .getItem("roles")
      .split(",")
      .map((item) => item.trim());
    if (
      userRoles.includes("CREATE_TOP_ADMIN") &&
      userRoles.includes("CREATE_ADMIN")
    ) {
      admin = "TOP_ADMIN";
    } else if (userRoles.includes("CREATE_USER")) {
      admin = "ADMIN";
    }
  }

  const theme = useTheme();
  const fullScreen = useMediaQuery(theme.breakpoints.down("md"));

  const [addUser] = useAddUserMutation();

  const handleCloseSuccess = () => {
    setOpenSuccess(false);
  };

  const handleCloseFail = () => {
    setOpenFail(false);
  };

  const handleSupervisor = (value: string) => {
    if (value === "USER") {
      setSupervisor(true);
    } else {
      setSupervisor(false);
    }
  };

  const formik = useFormik({
    initialValues: {
      email: "",
      group: "",
      status: "",
      supervisor: "",
    },
    validationSchema: Yup.object({
      email: Yup.string()
        .email("Must be a valid email")
        .max(255)
        .required("Email is required"),
      group: Yup.string().max(25).required("Group is required"),
      status: Yup.string().max(255).required("Status is required"),
      supervisor:
        supervisor === false
          ? Yup.string().max(255)
          : Yup.string().max(255).required("supervisor is required"),
    }),
    onSubmit: (values, actions) => {
      addUser({
        username: values.email,
        group: values.group,
        status: values.status,
        supervisor: values.supervisor,
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

  const formikAdmin = useFormik({
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
        {admin === "TOP_ADMIN" ? (
          <form onSubmit={formik.handleSubmit}>
            <Box sx={{ my: 3 }}>
              <Typography
                color="textSecondary"
                sx={{
                  textAlign: "center",
                  fontSize: "1.1rem",
                  color: "#424242",
                }}
                gutterBottom
                variant="body2"
              >
                {localStorage.getItem("user")}
              </Typography>
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
            <FormControl
              sx={{ mt: 2 }}
              fullWidth
              error={Boolean(formik.touched.group && formik.errors.group)}
            >
              <InputLabel id="demo-simple-select-helper-label">
                Group
              </InputLabel>
              {admin === "TOP_ADMIN" ? (
                <Select
                  fullWidth
                  labelId="demo-simple-select-label"
                  id="group"
                  label="Group"
                  value={formik.values.group}
                  name="group"
                  // onChange={formik.handleChange}
                  onChange={(event) => {
                    formik.handleChange(event);
                    handleSupervisor(event.target.value);
                  }}
                  onBlur={formik.handleBlur}
                >
                  <MenuItem key={"TOP_ADMIN"} value={"TOP_ADMIN"}>
                    TOP_ADMIN
                  </MenuItem>
                  <MenuItem key={"ADMIN"} value={"ADMIN"}>
                    ADMIN
                  </MenuItem>
                  <MenuItem key={"USER"} value={"USER"}>
                    USER
                  </MenuItem>
                </Select>
              ) : admin === "ADMIN" ? (
                <Select
                  fullWidth
                  labelId="demo-simple-select-label"
                  id="group"
                  label="Group"
                  value={formik.values.group}
                  name="group"
                  onChange={formik.handleChange}
                  onBlur={formik.handleBlur}
                >
                  <MenuItem value={"USER"}>USER</MenuItem>
                </Select>
              ) : (
                <></>
              )}

              <FormHelperText>
                {formik.touched.group && formik.errors.group}
              </FormHelperText>
            </FormControl>

            {supervisor ? (
              <FormControl
                sx={{ mt: 2 }}
                fullWidth
                error={Boolean(
                  formik.touched.supervisor && formik.errors.supervisor
                )}
              >
                <InputLabel id="demo-simple-select-helper-label">
                  Supervisor
                </InputLabel>
                <Select
                  fullWidth
                  labelId="demo-simple-select-label"
                  id="supervisor"
                  label="Supervisor"
                  value={formik.values.supervisor}
                  name="supervisor"
                  onChange={formik.handleChange}
                  onBlur={formik.handleBlur}
                >
                  {data?.users
                    .filter((user) => {
                      if (admin === "TOP_ADMIN") {
                        return user.group === "ADMIN";
                      }
                    })
                    .map((item: User, index: any) => {
                      return (
                        <MenuItem value={item.username}>
                          {item.username}
                        </MenuItem>
                      );
                    })}
                </Select>
                <FormHelperText>
                  {formik.touched.supervisor && formik.errors.supervisor}
                </FormHelperText>
              </FormControl>
            ) : (
              <></>
            )}

            <FormControl
              sx={{ mt: 2 }}
              fullWidth
              error={Boolean(formik.touched.status && formik.errors.status)}
            >
              <InputLabel id="demo-simple-select-helper-label">
                Status
              </InputLabel>
              <Select
                fullWidth
                labelId="demo-simple-select-label"
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
        ) : (
          <form onSubmit={formikAdmin.handleSubmit}>
            <Box sx={{ my: 3 }}>
              <Typography
                color="textSecondary"
                sx={{
                  textAlign: "center",
                  fontSize: "1.1rem",
                  color: "#424242",
                }}
                gutterBottom
                variant="body2"
              >
                {localStorage.getItem("user")}
              </Typography>
            </Box>
            <TextField
              fullWidth
              label="Email"
              margin="normal"
              name="email"
              onBlur={formikAdmin.handleBlur}
              onChange={formikAdmin.handleChange}
              value={formikAdmin.values.email}
              variant="outlined"
              error={Boolean(
                formikAdmin.touched.email && formikAdmin.errors.email
              )}
              helperText={formikAdmin.touched.email && formikAdmin.errors.email}
            />
            <FormControl
              sx={{ mt: 2 }}
              fullWidth
              error={Boolean(
                formikAdmin.touched.group && formikAdmin.errors.group
              )}
            >
              <InputLabel id="demo-simple-select-helper-label">
                Group
              </InputLabel>
              {admin === "TOP_ADMIN" ? (
                <Select
                  fullWidth
                  labelId="demo-simple-select-label"
                  id="group"
                  label="Group"
                  value={formikAdmin.values.group}
                  name="group"
                  onChange={formikAdmin.handleChange}
                  onBlur={formikAdmin.handleBlur}
                >
                  <MenuItem value={"TOP_ADMIN"}>TOP_ADMIN</MenuItem>
                  <MenuItem value={"ADMIN"}>ADMIN</MenuItem>
                  <MenuItem value={"USER"}>USER</MenuItem>
                </Select>
              ) : admin === "ADMIN" ? (
                <Select
                  fullWidth
                  labelId="demo-simple-select-label"
                  id="group"
                  label="Group"
                  value={formikAdmin.values.group}
                  name="group"
                  onChange={formikAdmin.handleChange}
                  onBlur={formikAdmin.handleBlur}
                >
                  <MenuItem value={"USER"}>USER</MenuItem>
                </Select>
              ) : (
                <></>
              )}

              <FormHelperText>
                {formikAdmin.touched.group && formikAdmin.errors.group}
              </FormHelperText>
            </FormControl>

            <FormControl
              sx={{ mt: 2 }}
              fullWidth
              error={Boolean(
                formikAdmin.touched.status && formikAdmin.errors.status
              )}
            >
              <InputLabel id="demo-simple-select-helper-label">
                Status
              </InputLabel>
              <Select
                fullWidth
                labelId="demo-simple-select-label"
                id="status"
                label="Status"
                value={formikAdmin.values.status}
                name="status"
                onChange={formikAdmin.handleChange}
                onBlur={formikAdmin.handleBlur}
              >
                <MenuItem value={"ACTIVE"}>ACTIVE</MenuItem>
                <MenuItem value={"TEMPORARY_BLOCKED"} color="orange">
                  TEMPORARY_BLOCKED
                </MenuItem>
              </Select>
              <FormHelperText>
                {formikAdmin.touched.status && formikAdmin.errors.status}
              </FormHelperText>
            </FormControl>
            <Box sx={{ py: 2 }}>
              <Button
                color="primary"
                disabled={formikAdmin.isSubmitting}
                fullWidth
                size="large"
                type="submit"
                variant="contained"
              >
                ADD
              </Button>
            </Box>
          </form>
        )}

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
