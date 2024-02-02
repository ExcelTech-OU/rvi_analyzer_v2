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
  Customer,
  useAddCustomerMutation,
} from "../../../services/customer_service";
import Lottie from "react-lottie";
import animationData from "../../animations/active.json";
import { List } from "reselect/es/types";
import AdminPanelSettingsIcon from "@mui/icons-material/AdminPanelSettings";
import * as Yup from "yup";
import CloseIcon from "@mui/icons-material/Close";
import {
  Style,
  useAddStyleMutation,
  useAllocateAdminMutation,
  useGetStyleQuery,
} from "../../../services/styles_service";
import CustomSelect from "../../user/view/custom-select";
import { useGetCustomerQuery } from "../../../services/customer_service";
import { Plant, useGetPlantQuery } from "../../../services/plant_service";
import { User, useGetUsersQuery } from "../../../services/user_service";

type AddStyleProps = {
  open: boolean;
  changeOpenStatus: (status: boolean) => void;
};

export function AllocateAdminsModel({ open, changeOpenStatus }: AddStyleProps) {
  const [openSuccess, setOpenSuccess] = React.useState(false);
  const [openFail, setOpenFail] = useState(false);
  const [formReset, setFormReset] = useState(false);
  const theme = useTheme();
  const fullScreen = useMediaQuery(theme.breakpoints.down("md"));
  const [style, setStyle] = useState("");
  const [admin, setAdmin] = useState("");
  const [allocateAdmin] = useAllocateAdminMutation();

  const {
    data: adminData,
    error: adminError,
    isLoading: adminLoading,
  } = useGetUsersQuery("");

  const {
    data: styleData,
    error: styleError,
    isLoading: styleLoading,
  } = useGetStyleQuery("");

  const {
    data: customerData,
    error: customerError,
    isLoading: customerLoading,
  } = useGetCustomerQuery("");

  const {
    data: plantData,
    error: plantError,
    isLoading: plantLoading,
  } = useGetPlantQuery("");

  const styles = styleData?.styles.map((object: Style) => {
    return { value: object.name, label: object.name };
  });

  const customers = customerData?.customers.map((object: Customer) => {
    return { value: object.name, label: object.name };
  });

  const plants = plantData?.plants.map((object: Plant) => {
    return { value: object.name, label: object.name };
  });

  const admins = adminData?.users
    .filter((object: User) => {
      return object.group === "ADMIN";
    })
    .map((plant: User) => {
      return { value: plant.username, label: plant.username };
    });
  const [addStyle] = useAddStyleMutation();

  const handleCloseSuccess = () => {
    setOpenSuccess(false);
  };

  const handleCloseFail = () => {
    setOpenFail(false);
  };

  const formik = useFormik({
    initialValues: {
      style: "",
      admin: "",
    },
    validationSchema: Yup.object({
      admin: Yup.string().max(255).required("Admin is required"),
      style: Yup.string().max(255).required("Style is required"),
    }),
    onSubmit: (values, actions) => {
      console.log(admin + " , " + style);
      allocateAdmin({
        admin: values.admin,
        name: values.style,
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
                <AdminPanelSettingsIcon
                  sx={{ width: "20px", color: "#ffb74d" }}
                />
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
                Allocate admins
                {/* {localStorage.getItem("user")} */}
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
                {localStorage.getItem("user")} is active
              </Typography>
            </Box>
          </Box>

          {/* <TextField
            fullWidth
            label="Style name"
            margin="normal"
            name="name"
            onBlur={formik.handleBlur}
            onChange={formik.handleChange}
            value={formik.values.name}
            variant="outlined"
            error={Boolean(formik.touched.name && formik.errors.name)}
            helperText={formik.touched.name && formik.errors.name}
          /> */}

          <FormControl
            sx={{ mt: 1 }}
            fullWidth
            error={Boolean(formik.touched.style && formik.errors.style)}
          >
            <CustomSelect
              id="style"
              options={styles}
              placeholder="Style"
              onChange={(value: { value: any }) => {
                formik.setFieldValue("style", value.value);
                setStyle(value.value);
              }}
              name="style"
              className={"input"}
              value={formik.values.style}
              onBlur={formik}
            />
            <FormHelperText>
              {formik.touched.style && formik.errors.style}
            </FormHelperText>
          </FormControl>

          <FormControl
            sx={{ mt: 1 }}
            fullWidth
            error={Boolean(formik.touched.admin && formik.errors.admin)}
          >
            <CustomSelect
              id="admin"
              options={admins}
              placeholder="Admin"
              onChange={(value: { value: any }) => {
                formik.setFieldValue("admin", value.value);
                setAdmin(value.value);
              }}
              name="admin"
              className={"input"}
              value={formik.values.admin}
              onBlur={formik}
            />
            <FormHelperText>
              {formik.touched.admin && formik.errors.admin}
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
