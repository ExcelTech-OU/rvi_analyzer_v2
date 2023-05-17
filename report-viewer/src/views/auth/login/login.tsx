import { useFormik } from 'formik';
import * as Yup from 'yup';
import { Alert, Box, Button, Container, Snackbar, TextField, Typography } from '@mui/material';
import { useLocation, useNavigate, useParams } from 'react-router-dom';
import React, { useEffect, useState } from 'react';
import { PasswordValidationReportResponse, useCheckPasswordMutation, useCheckSessionQuery } from '../../../services/login_service';
import { ModeOneSingleView } from '../../mode_one/mode-one-single-view';
import { ModeTwoSingleView } from '../../mode_two/mode-two-single-view';
import { ModeThreeSingleView } from '../../mode_three/mode-three-single-view';
import { ModeFourSingleView } from '../../mode_four/mode-four-single-view';
import { ModeFiveSingleView } from '../../mode_five/mode-five-single-view';
import { ModeSixSingleView } from '../../mode_six/mode-six-single-view';


export default function login() {
  const location = useLocation();
  const pathSegments = location.pathname.split('/');
  const lastParam = pathSegments[pathSegments.length - 1];


  const navigate = useNavigate();
  const [open, setOpen] = useState(false);
  const [checkPassword] = useCheckPasswordMutation();
  const [dataState, setDataState] = React.useState<PasswordValidationReportResponse | null>(null);

  const handleClick = () => {
    setOpen(true);
  };

  const { data, isLoading, isFetching, isError } = useCheckSessionQuery({ hash: lastParam })




  const handleClose = (event?: React.SyntheticEvent | Event, reason?: string) => {
    if (reason === 'clickaway') {
      return;
    }
    setOpen(false);
  };

  const formik = useFormik({
    initialValues: {
      password: ''
    },
    validationSchema: Yup.object({
      password: Yup
        .string()
        .max(100)
        .required('Password is required')
    }),
    onSubmit: (values, actions) => {
      checkPassword({ hash: lastParam, password: values.password })
        .unwrap()
        .then((payload) => {
          if (payload.status == 'S1000') {
            setDataState(payload)
          } else {
            actions.setSubmitting(false)
            actions.resetForm()
            setOpen(true)
          }
        })
        .catch((error) => {
          actions.setSubmitting(false)
          actions.resetForm()
          setOpen(true)
        });
    }
  });

  if (isLoading) {
    return <Box
      component="main"
      sx={{
        alignItems: 'center',
        display: 'flex',
        flexGrow: 1,
        minHeight: '100%'
      }}
      style={{ minHeight: '100vh' }}
    >
      <Container sx={{
        display: 'flex',
        justifyContent: 'center',
        alignItems: 'center',
        height: '100vh',
      }}>
        <Typography align="center"
          color="grey"
          gutterBottom
          variant="h6"
        >
          Checking your url...
        </Typography>
      </Container>
    </Box>
  }

  if (isError) {
    return <Box
      component="main"
      sx={{
        justifyContent: 'center',
        alignItems: 'center',
        display: 'flex',
        height: '100vh',
      }}
    >
      <Container sx={{
        display: 'flex',
        justifyContent: 'center',
        alignItems: 'center',
        height: '100vh',
      }}>
        <Typography align="center"
          color="grey"
          gutterBottom
          variant="h6"
        >
          Something went wrong. Please check the URL and try again later
        </Typography>
      </Container>
    </Box>
  }

  return (
    <Box
      component="main"
      sx={{
        alignItems: 'center',
        display: 'flex',
        flexGrow: 1,
        minHeight: '100%',
        my: 5
      }}
      style={{ minHeight: '95vh' }}
    >
      {dataState != null ?
        dataState.modeId == 1
          ? <Container sx={{
            display: 'flex',
            justifyContent: 'center',
            alignItems: 'center',
            mt: 5

          }}>
            <ModeOneSingleView session={dataState.modeOneDto!} />
          </Container>
          : dataState.modeId == 2
            ? <Container sx={{
              display: 'flex',
              justifyContent: 'center',
              alignItems: 'center',
              mt: 10
            }}>
              <ModeTwoSingleView session={dataState.modeTwoDto!} />
            </Container>
            : dataState.modeId == 3
              ? <Container sx={{
                display: 'flex',
                justifyContent: 'center',
                alignItems: 'center',
                mt: 5
              }}>
                <ModeThreeSingleView session={dataState.modeThreeDto!} />
              </Container>
              : dataState.modeId == 4
                ? <Container sx={{
                  display: 'flex',
                  justifyContent: 'center',
                  alignItems: 'center',
                  mt: 5

                }}>
                  <ModeFourSingleView session={dataState.modeFourDto!} />
                </Container>
                : dataState.modeId == 5
                  ? <Container sx={{
                    display: 'flex',
                    justifyContent: 'center',
                    alignItems: 'center',
                    mt: 5

                  }}>
                    <ModeFiveSingleView session={dataState.modeFiveDto!} />
                  </Container>
                  :
                  <Container sx={{
                    display: 'flex',
                    justifyContent: 'center',
                    alignItems: 'center',
                    mt: 5

                  }}>
                    <ModeSixSingleView session={dataState.modeSixDto!} />
                  </Container>

        :
        <Container maxWidth="sm">
          {data && data.status == "S1000" ? <form onSubmit={formik.handleSubmit}>
            <Box sx={{ my: 3 }}>
              <Typography
                color="textPrimary"
                variant="h4"
              >
                RVI REPORT VIEWER
              </Typography>
              <Typography
                color="textSecondary"
                gutterBottom
                variant="body2"
              >
                Use your password to check the report
              </Typography>
            </Box>


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
                Submit
              </Button>
            </Box>
          </form> : <Typography align="center"
            color="grey"
            gutterBottom
            variant="h6"
          >
            URL Not found Please re check try again later
          </Typography>}

        </Container>}
      <Snackbar open={open} autoHideDuration={6000} onClose={handleClose} anchorOrigin={{ vertical: 'bottom', horizontal: 'center' }}>
        <Alert onClose={handleClose} severity="error" sx={{ width: '100%' }}>
          Invalid Password
        </Alert>
      </Snackbar>
    </Box>
  );
};
