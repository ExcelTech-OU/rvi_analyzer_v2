import { Grid } from "@mui/material";
import { Box, Container } from "@mui/system";
import { ReactNode, useEffect, useState } from "react";
import Login from "./views/auth/login/login";
import { DashboardLayout } from "./views/components/dashboard-layout";

type AppProps = {
  children: ReactNode;
}

function App({ children }: AppProps) {

  return (
    false ? <>
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
