import * as React from 'react';
import Button from '@mui/material/Button';
import Dialog from '@mui/material/Dialog';
import DialogContent from '@mui/material/DialogContent';
import CloseIcon from '@mui/icons-material/Close';
import { ModeTwoDto, useShareReportMutation } from '../../services/sessions_service';
import { CircularProgress, Grid, IconButton, Link, Typography } from '@mui/material';
import ContentCopyIcon from '@mui/icons-material/ContentCopy';

type ModeTWOShareAlertDialogProps = {
    session: ModeTwoDto;
    open: boolean;
    changeOpenStatus: (status: boolean) => void;
}

export default function ModeTwoShareAlertDialog({ open, session, changeOpenStatus }: ModeTWOShareAlertDialogProps) {
    const [shareClicked, setShareClicked] = React.useState(false)
    const [url, setUrl] = React.useState("")
    const [password, setPassword] = React.useState("")
    const [completed, setShareCompleted] = React.useState(false)

    const [shareReport] = useShareReportMutation({});


    function share() {
        setShareClicked(true)
        shareReport({})
            .unwrap()
            .then((payload) => {
                if (payload.status == 'S1000') {
                    setShareClicked(false);
                    setUrl(payload.url)
                    setPassword(payload.password)
                    setShareCompleted(true)
                }
            })
            .catch((error) => {
                setShareClicked(false);
                setShareCompleted(false);
            });


    }

    return (
        <div>
            <Dialog
                fullWidth={true}
                maxWidth="md"
                open={open}
                onClose={() => changeOpenStatus(false)}
                aria-labelledby="alert-dialog-title"
                aria-describedby="alert-dialog-description"
            >
                <IconButton
                    aria-label="close"
                    onClick={() => changeOpenStatus(false)}
                    sx={{
                        position: 'absolute',
                        right: 15,
                        top: 8,
                        color: (theme) => theme.palette.grey[500],
                    }}
                >
                    <CloseIcon />
                </IconButton>
                <DialogContent style={{ display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                    {completed ?
                        <Grid container spacing={{ xs: 2, md: 3 }} columns={{ xs: 4, sm: 8, md: 12 }}>
                            <Grid item xs={4} sm={4} md={6} >

                                <Typography variant="button" display="inline">
                                    URL :  </Typography>
                                <IconButton aria-label="fingerprint" color="secondary" >
                                    <ContentCopyIcon />
                                </IconButton>
                                <Typography variant="subtitle2" sx={{ fontSize: 15 }}>

                                    <Link href={url} target="_blank" rel="noopener noreferrer">
                                        {url}
                                    </Link>
                                </Typography>

                                <Typography variant="button" sx={{ mt: 5 }} >
                                    PASSWORD : <IconButton aria-label="fingerprint" color="secondary" >
                                        <ContentCopyIcon />
                                    </IconButton><Typography variant="subtitle1" gutterBottom color="black">{password}</Typography>
                                </Typography>

                            </Grid>
                        </Grid>
                        : <Button variant="contained" sx={{ minWidth: 250 }} onClick={share}>
                            {shareClicked ? <CircularProgress color="inherit" /> : "Generate Link"}
                        </Button>}
                </DialogContent>
            </Dialog>
        </div>
    );
}