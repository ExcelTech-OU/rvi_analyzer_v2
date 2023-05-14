import { Divider, IconButton, Menu, MenuItem, MenuProps, alpha, styled, useMediaQuery, useTheme } from "@mui/material";
import DownloadIcon from '@mui/icons-material/Download';
import VisibilityIcon from '@mui/icons-material/Visibility';
import MoreVertIcon from '@mui/icons-material/MoreVert';
import ShareIcon from '@mui/icons-material/Share';
import React, { useState } from "react";
import { ModeFiveDto, ModeSixDto, ModeThreeDto } from "../../services/sessions_service";
import ModeSixShareAlertDialog from "./session-six-share-dialog";
import { PDFDownloadLink } from "@react-pdf/renderer";
import ModeSixPdfDocument from "./mode-six-pdf";
import { ModeSixSingleView } from "./mode-six-single-view";

type CustomMenuModeSixProps = {
    session: ModeSixDto;
}

const StyledMenu = styled((props: MenuProps) => (
    <Menu
        elevation={0}
        anchorOrigin={{
            vertical: 'bottom',
            horizontal: 'right',
        }}
        transformOrigin={{
            vertical: 'top',
            horizontal: 'right',
        }}
        {...props}
    />
))(({ theme }) => ({
    '& .MuiPaper-root': {
        borderRadius: 6,
        marginTop: theme.spacing(1),
        minWidth: 180,
        color:
            theme.palette.mode === 'light' ? 'rgb(55, 65, 81)' : theme.palette.grey[300],
        boxShadow:
            'rgb(255, 255, 255) 0px 0px 0px 0px, rgba(0, 0, 0, 0.05) 0px 0px 0px 1px, rgba(0, 0, 0, 0.1) 0px 10px 15px -3px, rgba(0, 0, 0, 0.05) 0px 4px 6px -2px',
        '& .MuiMenu-list': {
            padding: '4px 0',
        },
        '& .MuiMenuItem-root': {
            '& .MuiSvgIcon-root': {
                fontSize: 18,
                color: theme.palette.text.secondary,
                marginRight: theme.spacing(1.5),
            },
            '&:active': {
                backgroundColor: alpha(
                    theme.palette.primary.main,
                    theme.palette.action.selectedOpacity,
                ),
            },
        },
    },
}));

export default function CustomizedMenusModeSix({ session }: CustomMenuModeSixProps) {
    const [anchorEl, setAnchorEl] = React.useState<null | HTMLElement>(null);
    const open = Boolean(anchorEl);
    const handleClick = (event: React.MouseEvent<HTMLElement>) => {
        setAnchorEl(event.currentTarget);
    };
    const handleClose = () => {
        setAnchorEl(null);
    };

    const [openCloseDetailView, setOpenCloseDetailView] = useState(false);
    const [openCloseLinkView, setOpenCloseLinkView] = useState(false);
    const [openSuccessCloseDetailView, setOpenSuccessCloseDetailView] = useState(false);

    const theme = useTheme();
    const fullScreen = useMediaQuery(theme.breakpoints.down('md'));

    return (
        <div>
            <IconButton
                aria-label="more"
                id="long-button"
                aria-controls={open ? 'long-menu' : undefined}
                aria-expanded={open ? 'true' : undefined}
                aria-haspopup="true"
                onClick={handleClick}
            >
                <MoreVertIcon />
            </IconButton>
            <StyledMenu
                id="demo-customized-menu"
                MenuListProps={{
                    'aria-labelledby': 'demo-customized-button',
                }}
                anchorEl={anchorEl}
                open={open}
                onClose={handleClose}
            >
                <MenuItem onClick={() => {
                    setOpenCloseDetailView(true);
                    handleClose();
                }} disableRipple>
                    <VisibilityIcon />
                    View
                </MenuItem>
                <MenuItem onClick={() => {
                    setOpenCloseLinkView(true);
                    handleClose();
                }} disableRipple>
                    <ShareIcon />
                    Share
                </MenuItem>
                <Divider sx={{ my: 0.5 }} />
                <MenuItem onClick={handleClose} disableRipple>
                    <DownloadIcon />
                    <PDFDownloadLink document={<ModeSixPdfDocument session={session} />} fileName={"mode_six_" + session.defaultConfigurations.sessionId + ".pdf"}
                        style={{ color: "grey", textDecoration: "none" }}>
                        {({ blob, url, loading, error }) =>
                            loading ? 'Loading...' : 'Download'
                        }
                    </PDFDownloadLink>
                </MenuItem>
            </StyledMenu>
            <ModeSixSingleView open={openCloseDetailView} changeOpenStatus={setOpenCloseDetailView} session={session} />
            <ModeSixShareAlertDialog open={openCloseLinkView} changeOpenStatus={setOpenCloseLinkView} session={session} />
        </div>
    );
}