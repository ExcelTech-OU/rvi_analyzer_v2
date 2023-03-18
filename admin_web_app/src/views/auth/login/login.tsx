import { useFormik } from 'formik';
import * as Yup from 'yup';
import { Alert, Box, Button, Container, Snackbar, TextField, Typography } from '@mui/material';
import { useLoginMutation } from '../../../services/login_service';
import { useNavigate } from 'react-router-dom';
import React, { useState } from 'react';
import { useDispatch } from 'react-redux';
import { loginSuccess } from './auth-slice';

const Login = () => {

  const [login] = useLoginMutation()
  const navigate = useNavigate();
  const [open, setOpen] = useState(false);
  const dispatch = useDispatch()

  const handleClick = () => {
    setOpen(true);
  };

  const handleClose = (event?: React.SyntheticEvent | Event, reason?: string) => {
    if (reason === 'clickaway') {
      return;
    }

    setOpen(false);
  };

  const formik = useFormik({
    initialValues: {
      email: '',
      password: ''
    },
    validationSchema: Yup.object({
      email: Yup
        .string()
        .email('Must be a valid email')
        .max(255)
        .required('Email is required'),
      password: Yup
        .string()
        .max(100)
        .required('Password is required')
    }),
    onSubmit: (values, actions) => {
      login({ username: values.email, password: values.password })
        .unwrap()
        .then((payload) => {
          if (payload.state == 'S1000') {
            dispatch(loginSuccess(payload))
            navigate('/devices')
          }
        })
        .catch((error) => {
          actions.setSubmitting(false)
          actions.resetForm()
          setOpen(true)
        });
    }
  });

  return (
    <Box
      component="main"
      sx={{
        alignItems: 'center',
        display: 'flex',
        flexGrow: 1,
        minHeight: '100%'
      }}
      style={{ minHeight: '100vh' }}
    >
      <Container maxWidth="sm">
        <form onSubmit={formik.handleSubmit}>
          <Box sx={{ my: 3 }}>
            <Typography
              color="textPrimary"
              variant="h4"
            >
              Sign in
            </Typography>
            <Typography
              color="textSecondary"
              gutterBottom
              variant="body2"
            >
              Sign in to the achilies admin panel
            </Typography>
          </Box>

          <TextField
            error={Boolean(formik.touched.email && formik.errors.email)}
            fullWidth
            helperText={formik.touched.email && formik.errors.email}
            label="Email Address"
            margin="normal"
            name="email"
            onBlur={formik.handleBlur}
            onChange={formik.handleChange}
            type="email"
            value={formik.values.email}
            variant="outlined"
          />
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
              Sign In
            </Button>
          </Box>
        </form>
      </Container>
      <Snackbar open={open} autoHideDuration={6000} onClose={handleClose} anchorOrigin={{ vertical: 'bottom', horizontal: 'center' }}>
        <Alert onClose={handleClose} severity="error" sx={{ width: '100%' }}>
          Login Failed! username or password incorrect
        </Alert>
      </Snackbar>
    </Box>
  );
};

export default Login;
