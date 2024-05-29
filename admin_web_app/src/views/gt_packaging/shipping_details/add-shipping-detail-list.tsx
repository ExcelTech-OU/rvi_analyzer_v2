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
// import CustomSelect from "./custom-select";
import AsyncSelect from "react-select/async";
import React, { useEffect, useState } from "react";
import { useFormik } from "formik";
import * as Yup from "yup";
import PersonIcon from "@mui/icons-material/Person";
import CircleIcon from "@mui/icons-material/Circle";
import CloseIcon from "@mui/icons-material/Close";
import Lottie from "react-lottie";
import animationData from "../../animations/active.json";

type AddUserProps = {
  label: string;
  open: boolean;
  changeOpenStatus: (status: boolean) => void;
};

interface Option {
  value: string;
  label: string;
}

export function AddShippingDetailModel({label, open, changeOpenStatus }: AddUserProps) {
  const [openSuccess, setOpenSuccess] = React.useState(false);
  const [openFail, setOpenFail] = useState(false);
  const [formReset, setFormReset] = useState(false);
  const [supervisor, setSupervisor] = useState(false);
  const [failMessage, setFailMessage] = useState("");
  const [submitted, setSubmitted] = useState(false);

  const theme = useTheme();
  const fullScreen = useMediaQuery(theme.breakpoints.down("md"));

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
      destination: "",
      shipping_Id: "",
      customer_PO: "",
    },
    // validationSchema: Yup.object({
    //   email: Yup.string()
    //     .email("Must be a valid email")
    //     .max(255)
    //     .required("Email is required"),
    //   user_name: Yup.string().max(50).required("User Name is required"),
    //   password: Yup.string().max(50).required("Password is required"),
    //   // group: Yup.string().max(25).required("Group is required"),
    //   // status: Yup.string().max(255).required("Status is required"),
    //   // supervisor:
    //   //   supervisor === false
    //   //     ? Yup.string().max(255)
    //   //     : Yup.string().max(255).required("Supervisor is required"),
    // }),
    onSubmit: async (values, actions) => {
      try {
        const response = await fetch('http://52.187.127.25/api/createShipping', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({
            destination: values.destination,
            shipping_Id: values.shipping_Id,
            customer_PO: values.customer_PO
          })
        });
        const data = await response.json();
        if (response.ok) {
          setSubmitted(true);
          actions.setSubmitting(false);
          actions.resetForm();
          setOpenSuccess(true);
        } else {
          actions.setSubmitting(false);
          setOpenFail(true);
          setFailMessage(data.message || "Failed to add user");
        }
      } catch (error) {
        actions.setSubmitting(false);
        setOpenFail(true);
        setFailMessage("Failed to add user");
      }
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
            <Box
              sx={{
                display: "flex",
                flexDirection: "row",
                alignItems: "center",
              }}
            >
              <Box
                sx={{
                  borderRadius: "50%",
                  backgroundColor: "#fff3e0",
                  width: "40px",
                  height: "40px",
                  padding: 1,
                  mr: 1,
                  display: "flex",
                  justifyContent: "center",
                  alignItems: "center",
                }}
              >
                <PersonIcon sx={{ width: "20px", color: "#ffb74d" }} />
              </Box>
              <Typography
                fontWeight={"bold"}
                color="textSecondary"
                sx={{
                  textAlign: "left",
                  fontSize: "1.1rem",
                  color: "#424242",
                  margin: 0,
                }}
                gutterBottom
                variant="body2"
              >
                Add Shipping Details
              </Typography>
            </Box>

            <Box
              sx={{
                display: "flex",
                flexDirection: "row",
                alignItems: "center",
              }}
            >
              <Box
                sx={{
                  width: "20px",
                  display: "flex",
                  justifyContent: "center",
                  alignItems: "center",
                  ml: 4,
                }}
              >
                <Lottie
                  style={{
                    display: "flex",
                    justifyContent: "center",
                  }}
                  options={{
                    animationData,
                    loop: true,
                    autoplay: true,
                  }}
                />
              </Box>
              <Typography sx={{ fontSize: "0.9rem", color: "#bdbdbd" }}>
                Active
              </Typography>
            </Box>
          </Box>
          {label === "destination" && (
          <TextField
            fullWidth
            type="destination"
            label="destination"
            margin="normal"
            name="destination"
            onBlur={formik.handleBlur}
            onChange={formik.handleChange}
            value={formik.values.destination}
            variant="outlined"
            error={Boolean(formik.touched.destination && formik.errors.destination)}
            helperText={formik.touched.destination && formik.errors.destination}
          />
          )}
          {label === "shipping_Id" && (
          <TextField
            fullWidth
            type="shipping_Id"
            label="shipping_Id"
            margin="normal"
            name="shipping_Id"
            onBlur={formik.handleBlur}
            onChange={formik.handleChange}
            value={formik.values.shipping_Id}
            variant="outlined"
            error={Boolean(formik.touched.shipping_Id && formik.errors.shipping_Id)}
            helperText={formik.touched.shipping_Id && formik.errors.shipping_Id}
          />
          )}
          {label === "customer_PO" && (
          <TextField
            fullWidth
            type="customer_PO"
            label="customer_PO"
            margin="normal"
            name="customer_PO"
            onBlur={formik.handleBlur}
            onChange={formik.handleChange}
            value={formik.values.customer_PO}
            variant="outlined"
            error={Boolean(formik.touched.customer_PO && formik.errors.customer_PO)}
            helperText={formik.touched.customer_PO && formik.errors.customer_PO}
          />
          )}
          
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
            {failMessage}
          </Alert>
        </Snackbar>
      </DialogContent>
    </Dialog>
  );
}
