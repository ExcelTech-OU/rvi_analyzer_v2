import PropTypes from "prop-types";
import { Box, MenuItem, MenuList, Popover, Typography } from "@mui/material";
import { useDispatch } from "react-redux";
import { logout } from "../auth/login/auth-slice";
import { useNavigate } from "react-router-dom";
import { userApi } from "../../services/user_service";
import { deviceApi } from "../../services/device_service";
import { sessionApi } from "../../services/sessions_service";

export const AccountPopover = (props: any) => {
  const { anchorEl, onClose, open, ...other } = props;
  const dispatch = useDispatch();
  const navigate = useNavigate();

  const logoutUser = () => {
    dispatch(logout());
    dispatch(userApi.util.resetApiState());
    dispatch(deviceApi.util.resetApiState());
    dispatch(sessionApi.util.resetApiState());
    navigate("/login");
    localStorage.removeItem("roles");
  };
  return (
    <Popover
      anchorEl={anchorEl}
      anchorOrigin={{
        horizontal: "left",
        vertical: "bottom",
      }}
      onClose={onClose}
      open={open}
      PaperProps={{
        sx: { width: "150px" },
      }}
      {...other}
    >
      <Box
        sx={{
          py: 1.5,
          px: 2,
        }}
      >
        <Typography variant="overline">Account</Typography>
        <Typography color="text.secondary" variant="body2">
          RVI Admin
        </Typography>
      </Box>
      <MenuList
        disablePadding
        sx={{
          "& > *": {
            "&:first-of-type": {
              borderTopColor: "divider",
              borderTopStyle: "solid",
              borderTopWidth: "1px",
            },
            padding: "12px 16px",
          },
        }}
      >
        <MenuItem onClick={logoutUser}>Sign out</MenuItem>
      </MenuList>
    </Popover>
  );
};

AccountPopover.propTypes = {
  anchorEl: PropTypes.any,
  onClose: PropTypes.func,
  open: PropTypes.bool.isRequired,
};
