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
  List,
  ListItem,
  ListItemText,
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
import React, { ReactNode, useEffect, useState } from "react";
import { WithContext as ReactTags } from "react-tag-input";
import { useFormik } from "formik";
import {
  Customer,
  useAddCustomerMutation,
} from "../../../services/customer_service";
import * as Yup from "yup";
import CloseIcon from "@mui/icons-material/Close";
import DeleteIcon from "@mui/icons-material/Delete";
import AddIcon from "@mui/icons-material/Add";
import { useAddStyleMutation } from "../../../services/styles_service";
import { useAddTestMutation } from "../../../services/test_service";
import { StyledTableCell, StyledTableRow } from "../../mode_one/mode-one-list";
import CustomSelect from "../../user/view/custom-select";
import { useGetMaterialQuery } from "../../../services/material_service";

type AddStyleProps = {
  open: boolean;
  changeOpenStatus: (status: boolean) => void;
};

interface Material {
  name: string;
  plant: string;
  customer: string;
  style: string;
}

interface parameterSetup {
  param: string;
  mode: string;
}

interface Option {
  value: string;
  label: string;
}

export function AddTestModel({ open, changeOpenStatus }: AddStyleProps) {
  const [openSuccess, setOpenSuccess] = React.useState(false);
  const [openFail, setOpenFail] = useState(false);
  const [formReset, setFormReset] = useState(false);
  const theme = useTheme();
  const {
    data: materialData,
    error: materialError,
    isLoading: materialLoading,
  } = useGetMaterialQuery("");
  const [material, setMaterial] = useState("");
  const fullScreen = useMediaQuery(theme.breakpoints.down("md"));
  const [isParameterSet, setIsParameterSet] = useState(false);
  const [parameterModes, setParameterModes] = useState<parameterSetup[]>([]);
  const [parameter, setParameter] = useState(null);
  const [parameterMode, setParameterMode] = useState("");
  const [parameterModeError, setParameterModeError] = useState("");
  const [customer, setCustomer] = useState("");
  const [plant, setPlant] = useState("");
  const [style, setStyle] = useState("");
  let materials: Option[] = [];

  materials = materialData?.materials.map((material: Material) => ({
    value: material.name,
    label: material.name,
  }));

  useEffect(() => {
    console.log(
      materialData?.materials.find((item) => item.name === material)?.plant
    );
    setPlant(
      materialData?.materials.find((item) => item.name === material)?.plant
    );
    setStyle(
      materialData?.materials.find((item) => item.name === material)?.style
    );
    setCustomer(
      materialData?.materials.find((item) => item.name === material)?.customer
    );
  }, [material]);
  // const materials = [
  //   { value: "Material 01", label: "Material 01" },
  //   { value: "Material 02", label: "Material 02" },
  //   { value: "Material 03", label: "Material 03" },
  // ];

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
      // console.log(event.target.value);
      setIsParameterSet(true);
    }
  };

  const handleParameterModesList = () => {
    if (!parameterModes.some((object) => object.mode === parameterMode)) {
      setParameterModeError("");
      const newParameterModes: parameterSetup = [
        ...parameterModes,
        { param: parameter, mode: parameterMode },
      ];
      setParameterModes(newParameterModes);
    } else {
      // console.log("Duplicate found");
      setParameterModeError("Mode is already added");
    }

    // console.log(parameter + ", " + parameterMode);
  };

  const removeParameterModes = (name: string) => {
    const updatedList: parameterSetup[] = parameterModes.filter(
      (mode: parameterSetup) => {
        return mode.mode !== name;
      }
    );

    setParameterModes(updatedList);
  };

  // const removePrameterModes = (name: String) => {
  //   setParameterModes(parameterModes.filter((mode) => mode.mode !== name));
  // };

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
      // console.log("works");
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
                    {plant != "" ? plant : ""}
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
                    {customer != "" ? customer : ""}
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
                    {style != "" ? style : ""}
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
              placeholder="Material"
              options={materials}
              onChange={(value: { value: any }) => {
                formik.setFieldValue("material", value.value);
                setMaterial(value.value);
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
                      <List
                        sx={{
                          width: "100%",
                          maxWidth: 360,
                        }}
                      >
                        {parameterModes.map((value: parameterSetup) => (
                          <ListItem
                            key={value.mode}
                            disableGutters
                            sx={{
                              backgroundColor: "#e0e0e0",
                              color: "white",
                              mt: 1,
                              borderRadius: "6px",
                              padding: 1,
                            }}
                            secondaryAction={
                              <IconButton
                                aria-label="comment"
                                onClick={() => {
                                  removeParameterModes(value.mode);
                                }}
                              >
                                <DeleteIcon sx={{ color: "white" }} />
                              </IconButton>
                            }
                          >
                            <ListItemText
                              primary={`Parameter mode ${
                                parameterModes.findIndex(
                                  (object) => object.mode === value.mode
                                ) + 1
                              }:  ${value.mode}`}
                            />
                          </ListItem>
                        ))}
                      </List>
                    </Container>
                    <TextField
                      fullWidth
                      label="Parameter Mode"
                      margin="normal"
                      name="parameterMode"
                      onBlur={formik.handleBlur}
                      onChange={(event) => {
                        formik.handleChange(event);
                        setParameterMode(event.target.value);
                      }}
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
                      onClick={handleParameterModesList}
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
              ) : parameterModeError != "" ? (
                <FormHelperText sx={{ color: "#d32f2f" }}>
                  {parameterModeError}
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
