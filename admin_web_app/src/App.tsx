import { Grid } from "@mui/material";
import { Box, Container } from "@mui/system";
import { ReactNode, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import { useAppSelector } from "./store/hooks";
import Login from "./views/auth/login/login";
import { DashboardLayout } from "./views/components/dashboard-layout";
import { useGetRolesMutation } from "./services/user_service";
import { useDispatch } from "react-redux";
import { logout, rolesGetSuccess } from "./views/auth/login/auth-slice";
import SignUp from "./views/auth/sign_up/sign_up";
import { Password } from "@mui/icons-material";

type AppProps = {
  children: ReactNode;
};

const footerStyles = {
  position: "fixed",
  bottom: 0,
  left: 0,
  width: "100%",
  height: "50px",
  backgroundColor: "#f5f5f5",
  display: "flex",
  alignItems: "center",
  justifyContent: "center",
};

const copyrightStyles = {
  fontSize: "12px",
  color: "#999",
};

function App({ children }: AppProps) {
  const isToken = localStorage.getItem("jwt") != null;
  const isUser = localStorage.getItem("user") != null;
  // const stateLogin = useAppSelector((state) => state.loginStatus.jwt);
  const navigate = useNavigate();
  const currentYear = new Date().getFullYear();
  const [roles] = useGetRolesMutation();
  const dispatch = useDispatch();

  console.log(isUser);

  useEffect(() => {
    if (isToken) {
      roles({})
        .unwrap()
        .then((payload) => {
          dispatch(rolesGetSuccess(payload));
          navigate("/");
        })
        .catch((error) => {
          console.log(error);
          dispatch(logout());
          navigate("/login");
        });
    } else {
      navigate("/login");
    }
  }, [isToken]);

  return isToken && isUser ? (
    <>
      <DashboardLayout>
        <Box
          component="main"
          sx={{
            flexGrow: 1,
            py: 8,
          }}
        >
          <Container maxWidth={false}>
            <Grid container spacing={3}>
              <Grid item xs={12}>
                {children}
              </Grid>
            </Grid>
          </Container>
        </Box>
        <Box sx={footerStyles}>
          <span style={copyrightStyles}>
            &copy; {currentYear} RVi. All rights reserved.
          </span>
        </Box>
      </DashboardLayout>
    </>
  ) : (
    <>
      <Login />
    </>
  );
}

export default App;
