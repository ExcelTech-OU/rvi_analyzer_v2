import {
  Alert,
  Box,
  Button,
  Container,
  Dialog,
  DialogContent,
  FormControl,
  FormControlLabel,
  FormHelperText,
  FormLabel,
  IconButton,
  InputLabel,
  MenuItem,
  Radio,
  RadioGroup,
  Select,
  Snackbar,
  Table,
  TableHead,
  TextField,
  Typography,
  useMediaQuery,
  useTheme,
} from "@mui/material";
import React, { useEffect, useState } from "react";
import { WithContext as ReactTags } from "react-tag-input";
import { useFormik } from "formik";
import {
  Customer,
  useAddCustomerMutation,
} from "../../../services/customer_service";
import * as Yup from "yup";
import CloseIcon from "@mui/icons-material/Close";
import AddIcon from "@mui/icons-material/Add";
import { useAddStyleMutation } from "../../../services/styles_service";
import { useAddTestMutation } from "../../../services/test_service";
import { StyledTableCell, StyledTableRow } from "../../mode_one/mode-one-list";
import CustomSelect from "../../user/view/custom-select";

type AddStyleProps = {
  open: boolean;
  changeOpenStatus: (status: boolean) => void;
};

interface Material {
  name: string;
  plant: string;
  customer: string;
}

export function AddTestModel({ open, changeOpenStatus }: AddStyleProps) {
  const [openSuccess, setOpenSuccess] = React.useState(false);
  const [openFail, setOpenFail] = useState(false);
  const [formReset, setFormReset] = useState(false);
  const theme = useTheme();
  const fullScreen = useMediaQuery(theme.breakpoints.down("md"));
  const [isParameterSet, setIsParameterSet] = useState(false);
  const [parameterModes, setParameterModes] = useState([]);
  const [parameter, setParameter] = useState(null);
  const [parameterError, setParameterError] = useState("");
  //   let materials: Material[] = [];

  const materials = [
    { value: "Material 01", label: "Material 01" },
    { value: "Material 02", label: "Material 02" },
    { value: "Material 03", label: "Material 03" },
  ];

  const [addTest] = useAddTestMutation();

  const handleCloseSuccess = () => {
    setOpenSuccess(false);
  };

  const handleCloseFail = () => {
    setOpenFail(false);
  };

  const handleParameters = (event: any) => {
    setParameter(event.target.value);
    // formik.handleChange;
    if (event.target.value != null) {
      console.log(event.target.value);
      setIsParameterSet(true);
    }
  };

  const formik = useFormik({
    initialValues: {
      testGate: "",
      material: "",
      parameterMode: "",
    },
    validationSchema: Yup.object({
      testGate: Yup.string().max(255).required("Test Gate is required"),
      material: Yup.string().max(255).required("Material is required"),
      parameterMode: isParameterSet
        ? Yup.string().max(255).required("Parameter mode is required")
        : Yup.string().max(255).required("Parameter is required"),
      // parameterMode: Yup.string()
      //   .max(255)
      //   .required("Parameter mode is required"),
    }),
    onSubmit: (values, actions) => {
      console.log("works");
      //   addTest({
      //     testGate: values.testGate,
      //     material: values.material,
      //   })
      //     .unwrap()
      //     .then((payload) => {
      //       if (payload.status == "S1000") {
      //         actions.setSubmitting(false);
      //         actions.resetForm();
      //         setOpenSuccess(true);
      //       }
      //     })
      //     .catch((error) => {
      //       actions.setSubmitting(false);
      //       setOpenFail(true);
      //     });
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

          <Container
            sx={{ backgroundColor: "#9e9e9e", borderRadius: "8px", py: 1 }}
          >
            <Table>
              <TableHead>
                <StyledTableRow>
                  <StyledTableCell
                    style={{
                      color: "#e0e0e0",
                      fontWeight: "normal",
                    }}
                  >
                    Plant
                  </StyledTableCell>
                  <StyledTableCell
                    style={{
                      color: "#424242",
                      fontWeight: "normal",
                    }}
                  >
                    Plant 01
                  </StyledTableCell>
                </StyledTableRow>
                <StyledTableRow>
                  <StyledTableCell
                    style={{
                      color: "#e0e0e0",
                      fontWeight: "normal",
                    }}
                  >
                    Customer
                  </StyledTableCell>
                  <StyledTableCell
                    style={{
                      color: "#424242",
                      fontWeight: "normal",
                    }}
                  >
                    Customer 01
                  </StyledTableCell>
                </StyledTableRow>
                <StyledTableRow>
                  <StyledTableCell
                    style={{
                      color: "#e0e0e0",
                      fontWeight: "normal",
                    }}
                  >
                    Style
                  </StyledTableCell>
                  <StyledTableCell
                    style={{
                      color: "#424242",
                      fontWeight: "normal",
                    }}
                  >
                    Style 01
                  </StyledTableCell>
                </StyledTableRow>
              </TableHead>
            </Table>
          </Container>

          <TextField
            fullWidth
            label="Test Gate"
            margin="normal"
            name="testGate"
            onBlur={formik.handleBlur}
            onChange={formik.handleChange}
            value={formik.values.testGate}
            variant="outlined"
            error={Boolean(formik.touched.testGate && formik.errors.testGate)}
            helperText={formik.touched.testGate && formik.errors.testGate}
          />

          <FormControl
            sx={{ mt: 1 }}
            fullWidth
            error={Boolean(formik.touched.material && formik.errors.material)}
          >
            <CustomSelect
              id="material"
              options={materials}
              onChange={(value: { value: any }) => {
                formik.setFieldValue("material", value.value);
              }}
              name="material"
              className={"input"}
              value={formik.values.material}
              onBlur={formik}
            />
            <FormHelperText>
              {formik.touched.material && formik.errors.material}
            </FormHelperText>
          </FormControl>

          <Box
            sx={{
              borderRadius: "8px",
              borderColor: "#9e9e9e",
              borderWidth: 1,
              borderStyle: "solid",
              marginTop: 1.5,
              padding: 2,
            }}
          >
            <Typography color="textSecondary" gutterBottom variant="body1">
              Parameters
            </Typography>

            <FormControl
              error={Boolean(
                formik.touched.parameterMode && formik.errors.parameterMode
              )}
            >
              {/* <FormLabel id="demo-radio-buttons-group-label">Gender</FormLabel> */}
              <RadioGroup
                row
                aria-labelledby="demo-radio-buttons-group-label"
                // defaultValue="female"
                name="parameter"
                onChange={(event) => {
                  handleParameters(event);
                }}
                // value={formik.values.parameterMode}
                value={parameter}
              >
                <FormControlLabel value="V" control={<Radio />} label="V" />
                <FormControlLabel value="I" control={<Radio />} label="I" />
                <FormControlLabel value="R" control={<Radio />} label="R" />
                <FormControlLabel value="T" control={<Radio />} label="T" />
                <FormControlLabel
                  value="V & R"
                  control={<Radio />}
                  label="V & R"
                />
                <FormControlLabel
                  value="I & R"
                  control={<Radio />}
                  label="I & R"
                />
                <FormControlLabel
                  value="T & I"
                  control={<Radio />}
                  label="T & I"
                />
              </RadioGroup>
              {isParameterSet ? (
                <Box
                  sx={{
                    marginTop: 1.5,
                  }}
                >
                  <Typography
                    color="textSecondary"
                    gutterBottom
                    variant="body1"
                  >
                    Testing Setup
                  </Typography>
                  <Box sx={{ py: 2 }}>
                    <Container
                      style={{
                        display: "flex",
                        justifyContent: "space-between",
                        flexDirection: "row",
                        padding: 0,
                      }}
                    >
                      {/* {parameterModes.map((mode:any)=>{
                      <Typography
                      color="textSecondary"
                      gutterBottom
                      variant="body1"
                    >
                      P01
                    </Typography>
                    })} */}
                    </Container>
                    <TextField
                      fullWidth
                      label="Parameter Mode"
                      margin="normal"
                      name="parameterMode"
                      onBlur={formik.handleBlur}
                      onChange={formik.handleChange}
                      value={formik.values.parameterMode}
                      variant="outlined"
                      error={Boolean(
                        formik.touched.parameterMode &&
                          formik.errors.parameterMode
                      )}
                    />
                    <Button
                      variant="contained"
                      startIcon={<AddIcon />}
                      sx={{
                        backgroundColor: "#00e676",
                        "&:hover": { backgroundColor: "#00a152" },
                      }}
                      // onClick={() => setOpen(true)}
                    >
                      SAVE
                    </Button>
                  </Box>
                </Box>
              ) : (
                <></>
              )}
              {parameter === null ? (
                <FormHelperText>
                  {formik.touched.parameterMode && formik.errors.parameterMode}
                </FormHelperText>
              ) : formik.errors.parameterMode ===
                "Parameter mode is required" ? (
                <FormHelperText>
                  {formik.touched.parameterMode && formik.errors.parameterMode}
                </FormHelperText>
              ) : (
                <></>
              )}
            </FormControl>
          </Box>
          <Box sx={{ py: 2 }}>
            <Button
              color="primary"
              disabled={formik.isSubmitting}
              fullWidth
              size="large"
              type="submit"
              variant="contained"
              // onClick={(e) => {
              //   parameter === null
              //     ? setParameterError("Parameter is required")
              //     : setParameterError("");
              // }}
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
