import { Grid } from "@mui/material";
import { Box, Container } from "@mui/system";
import { ReactNode, useEffect, useState } from "react";
import { useDispatch } from "react-redux";
import { useNavigate } from "react-router-dom";
import { useAppSelector } from "./store/hooks";
import { setJWT } from "./views/auth/login/auth-slice";
import Login from "./views/auth/login/login";
import { DashboardLayout } from "./views/components/dashboard-layout";

type AppProps = {
  children: ReactNode;
}

function App({ children }: AppProps) {

  const isLogin = localStorage.getItem("jwt") != null;
  const stateLogin = useAppSelector((state) => state.loginStatus.jwt)
  const navigate = useNavigate();

  console.log(isLogin)

  useEffect(() => {
    if (isLogin) {
      navigate("/");
    } else {
      navigate("/login");
    }
  }, [isLogin]);


  return (
    isLogin ? <>
      <DashboardLayout>
        <Box
          component="main"
          sx={{
            flexGrow: 1,
            py: 8
          }}
        >
          <Container maxWidth={false}>
            <Grid
              container
              spacing={3}
            >
              <Grid
                item
                xs={12}
              >
                {children}
              </Grid>
            </Grid>
          </Container>
        </Box>
      </DashboardLayout>
    </>
      :
      <>
        <Login />
      </>

  )
}

export default App
