import { Alert, Box, Dialog, DialogContent, DialogTitle, Divider, IconButton, List, ListItem, ListItemText, Snackbar, Tooltip, useMediaQuery, useTheme } from "@mui/material";
import { Visibility } from '@mui/icons-material';
import { useState } from "react";
import CloseIcon from '@mui/icons-material/Close';
import { useGetSessionQuestionsQuery, UserTreatmentSession } from "../../services/sessions_service";


type SessionDetailsProps = {
  session: UserTreatmentSession;
}

export function SessionDetailsActions({ session }: SessionDetailsProps) {

  const [open, setOpen] = useState(false);
  const [openSuccess, setOpenSuccess] = useState(false);

  const theme = useTheme();
  const fullScreen = useMediaQuery(theme.breakpoints.down('md'));
  var { data, error, isLoading } = useGetSessionQuestionsQuery({
    sessionId: session.id
  })

  const handleClickOpen = () => {
    setOpen(true);
  };

  const handleClose = () => {
    setOpen(false);
  };

  const handleCloseSuccess = () => {
    setOpenSuccess(false);
  };

  return (
    isLoading ? <></> : <Box>
      <Tooltip title="View Feedback">
        <IconButton onClick={handleClickOpen}
        >
          <Visibility />
        </IconButton>
      </Tooltip>
      <Dialog
        fullScreen={fullScreen}
        fullWidth={true}
        open={open}
        onClose={handleClose}
        aria-labelledby="responsive-dialog-title"
      >
        <DialogTitle id="alert-dialog-title">
          {"Feedback answers for \nUser " + session.user.name + " \nDevice " + session.device.name}
        </DialogTitle>
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
          <Box sx={{ my: 3 }}>
            <List
              sx={{
                width: '100%',
                bgcolor: 'background.paper',
              }}
            >
              {
                Object.entries(data!.questionAnswers).map(
                  ([key, value]: [string, string]) =>
                    <>
                      <ListItem>
                        <ListItemText primary={key} secondary={value} />
                      </ListItem>
                      <Divider light={false} />
                    </>
                )
              }

            </List>
          </Box>
          <Snackbar open={openSuccess} autoHideDuration={6000} onClose={handleCloseSuccess} anchorOrigin={{ vertical: 'top', horizontal: 'center' }}>
            <Alert onClose={handleCloseSuccess} severity="success" sx={{ width: '100%' }}>
              {session.device_id} Update success
            </Alert>
          </Snackbar>
        </DialogContent>

      </Dialog>
    </Box>
  );
};