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
import Lottie from "react-lottie";
import animationData from "../../animations/active.json";
import { useFormik } from "formik";
import SupportAgentIcon from "@mui/icons-material/SupportAgent";
import * as Yup from "yup";
import CloseIcon from "@mui/icons-material/Close";
import {
  Plant,
  useAddPlantMutation,
  useGetPlantQuery,
} from "../../../services/plant_service";
import {
  Style,
  useAllocateStyleMutation,
  useGetStyleQuery,
} from "../../../services/styles_service";
import {
  Customer,
  useGetCustomerQuery,
} from "../../../services/customer_service";
import CustomSelect from "../../user/view/custom-select";

type AddPlantProps = {
  open: boolean;
  changeOpenStatus: (status: boolean) => void;
};

export function AllocateStyleModel({ open, changeOpenStatus }: AddPlantProps) {
  const [openSuccess, setOpenSuccess] = React.useState(false);
  const [openFail, setOpenFail] = useState(false);
  const [formReset, setFormReset] = useState(false);
  const theme = useTheme();
  const [style, setStyle] = useState("");
  const fullScreen = useMediaQuery(theme.breakpoints.down("md"));
  const [submitted, setSubmitted] = useState(false);

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

  const [allocateStyle] = useAllocateStyleMutation();

  const handleCloseSuccess = () => {
    setOpenSuccess(false);
  };

  const handleCloseFail = () => {
    setOpenFail(false);
  };

  const formik = useFormik({
    initialValues: {
      customer: "",
      plant: "",
      style: "",
    },
    validationSchema: Yup.object({
      customer: Yup.string().max(255).required("Customer is required"),
      plant: Yup.string().max(255).required("Plant is required"),
      style: Yup.string().max(255).required("Style is required"),
    }),
    onSubmit: (values, actions) => {
      allocateStyle({
        name: values.style,
        customer: values.customer,
        plant: values.plant,
      })
        .unwrap()
        .then((payload) => {
          if (payload.status == "S1000") {
            setSubmitted(true);
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
                <SupportAgentIcon sx={{ width: "20px", color: "#ffb74d" }} />
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
                Allocate customers
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
              submitted={submitted}
            />
            <FormHelperText>
              {formik.touched.style && formik.errors.style}
            </FormHelperText>
          </FormControl>

          <FormControl
            sx={{ mt: 1 }}
            fullWidth
            error={Boolean(formik.touched.customer && formik.errors.customer)}
          >
            <CustomSelect
              id="customer"
              options={customers}
              placeholder="Customer"
              onChange={(value: { value: any }) => {
                formik.setFieldValue("customer", value.value);
              }}
              name="customer"
              className={"input"}
              value={formik.values.customer}
              onBlur={formik}
              submitted={submitted}
            />
            <FormHelperText>
              {formik.touched.customer && formik.errors.customer}
            </FormHelperText>
          </FormControl>

          <FormControl
            sx={{ mt: 1 }}
            fullWidth
            error={Boolean(formik.touched.plant && formik.errors.plant)}
          >
            <CustomSelect
              id="plant"
              options={plants}
              placeholder="Plant"
              onChange={(value: { value: any }) => {
                formik.setFieldValue("plant", value.value);
              }}
              name="plant"
              className={"input"}
              value={formik.values.plant}
              onBlur={formik}
              submitted={submitted}
            />
            <FormHelperText>
              {formik.touched.plant && formik.errors.plant}
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
