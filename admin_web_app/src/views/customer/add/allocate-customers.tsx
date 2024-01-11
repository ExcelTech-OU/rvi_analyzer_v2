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
import * as Yup from "yup";
import CloseIcon from "@mui/icons-material/Close";
import { useAddPlantMutation } from "../../../services/plant_service";

type AddPlantProps = {
  open: boolean;
  changeOpenStatus: (status: boolean) => void;
};

export function AddPlantModel({ open, changeOpenStatus }: AddPlantProps) {
  const [openSuccess, setOpenSuccess] = React.useState(false);
  const [openFail, setOpenFail] = useState(false);
  const [formReset, setFormReset] = useState(false);
  const theme = useTheme();
  const fullScreen = useMediaQuery(theme.breakpoints.down("md"));

  const [addPLant] = useAddPlantMutation();

  const handleCloseSuccess = () => {
    setOpenSuccess(false);
  };

  const handleCloseFail = () => {
    setOpenFail(false);
  };

  const formik = useFormik({
    initialValues: {
      name: "",
    },
    validationSchema: Yup.object({
      name: Yup.string().max(25).required("Plant name is required"),
    }),
    onSubmit: (values, actions) => {
      addPLant({
        name: values.name,
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

          <FormControl
            sx={{ mt: 2 }}
            fullWidth
            // error={Boolean(formik.touched.status && formik.errors.status)}
          >
            <InputLabel id="demo-simple-select-helper-label">Status</InputLabel>
            <Select
              fullWidth
              labelId="demo-simple-select-label"
              id="plant"
              label="Plant"
              // value={formik.values.status}
              name="plant"
              // onChange={formik.handleChange}
              // onBlur={formik.handleBlur}
            >
              <MenuItem value={"ACTIVE"}>ACTIVE</MenuItem>
              <MenuItem value={"TEMPORARY_BLOCKED"} color="orange">
                TEMPORARY_BLOCKED
              </MenuItem>
            </Select>
            <FormHelperText>
              {/* {formik.touched.status && formik.errors.status} */}
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
