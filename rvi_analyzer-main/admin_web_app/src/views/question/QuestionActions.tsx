import { Alert, Box, Button, Dialog, DialogContent, IconButton, MenuItem, Select, Snackbar, TextField, Tooltip, Typography, useMediaQuery, useTheme } from "@mui/material";
import { Edit } from '@mui/icons-material';
import React, { useState } from "react";
import { useFormik } from "formik";
import * as Yup from 'yup';
import CloseIcon from '@mui/icons-material/Close';
import { Question, useUpdateQuestionMutation } from "../../services/question_service";


type QuestionActionsProps = {
  question: Question;
}

export function QuestionActions({ question }: QuestionActionsProps) {

  const [open, setOpen] = React.useState(false);
  const [openSuccess, setOpenSuccess] = React.useState(false);
  const [openFail, setOpenFail] = useState(false);

  const theme = useTheme();
  const fullScreen = useMediaQuery(theme.breakpoints.down('md'));

  const [edit, setEdit] = useState(false);
  const [updateQuestion] = useUpdateQuestionMutation()

  const handleClickOpen = () => {
    setOpen(true);
  };

  const handleClose = () => {
    setOpen(false);
  };

  const handleCloseSuccess = () => {
    setOpenSuccess(false);
  };

  const handleCloseFail = () => {
    setOpenFail(false);
  };

  const formik = useFormik({
    initialValues: {
      question: question.question,
      status: question.enabled ? "ACTIVE" : "DISABLED"

    },
    validationSchema: Yup.object({
      question: Yup
        .string()
        .max(50)
        .required('Question is required'),
    }),
    onSubmit: (values, actions) => {
      if (!edit) {
        setEdit(true)
        actions.setSubmitting(false)
      } else {
        updateQuestion({
          id: question.id,
          question: values.question,
          status: values.status
        })
          .unwrap()
          .then((payload) => {
            if (payload.state == 'S1000') {
              actions.setSubmitting(false)
              setOpenSuccess(true)
              setEdit(false)
            }
          })
          .catch((error) => {
            actions.setSubmitting(false)
            setOpenFail(true)
          });
      }
    }
  });

  return (
    <Box>
      <Tooltip title="Edit User">
        <IconButton onClick={handleClickOpen}
        >
          <Edit />
        </IconButton>
      </Tooltip>
      <Dialog
        fullScreen={fullScreen}
        open={open}
        onClose={handleClose}
        aria-labelledby="responsive-dialog-title"
      >
        <DialogContent>
          <IconButton
            aria-label="close"
            onClick={handleClose}
            sx={{
              position: 'absolute',
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
              >
              </Typography>
            </Box>

            <TextField
              error={Boolean(formik.touched.question && formik.errors.question)}
              fullWidth
              helperText={formik.touched.question && formik.errors.question}
              label="Question"
              margin="normal"
              name="question"
              onBlur={formik.handleBlur}
              onChange={formik.handleChange}
              type="text"
              value={formik.values.question}
              variant="outlined"
              disabled={!edit}
            />

            <TextField
              fullWidth
              label="Type"
              margin="normal"
              name="type"
              onBlur={formik.handleBlur}
              onChange={formik.handleChange}
              value={question.formFieldType}
              variant="outlined"
              disabled
            />

            <Select
              fullWidth
              labelId="demo-simple-select-label"
              id="batchNo"
              value={formik.values.status}
              name="status"
              onChange={formik.handleChange}
              disabled={!edit}
            >
              <MenuItem value={"ACTIVE"}>ACTIVE</MenuItem>
              <MenuItem value={"DISABLED"} color="orange">DISABLED</MenuItem>
            </Select>
            <Box sx={{ py: 2 }}>
              <Button
                color="primary"
                disabled={formik.isSubmitting}
                fullWidth
                size="large"
                type="submit"
                variant="contained"
              >
                {edit ? "Save" : "Edit"}
              </Button>
            </Box>
          </form>
          <Snackbar open={openSuccess} autoHideDuration={6000} onClose={handleCloseSuccess} anchorOrigin={{ vertical: 'top', horizontal: 'center' }}>
            <Alert onClose={handleCloseSuccess} severity="success" sx={{ width: '100%' }}>
              {question.question} Update success
            </Alert>
          </Snackbar>

          <Snackbar open={openFail} autoHideDuration={6000} onClose={handleCloseFail} anchorOrigin={{ vertical: 'top', horizontal: 'center' }}>
            <Alert onClose={handleCloseFail} severity="error" sx={{ width: '100%' }}>
              {question.question} Update failed
            </Alert>
          </Snackbar>
        </DialogContent>

      </Dialog>
    </Box>
  );
};