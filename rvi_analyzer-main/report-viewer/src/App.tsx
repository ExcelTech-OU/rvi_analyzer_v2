import { AppBar, Grid, Slide, Toolbar, Typography, useScrollTrigger } from "@mui/material";
import { Box, Container } from "@mui/system";
import { ReactNode, useEffect, useState } from "react";
import Login from "./views/auth/login/login";
import { DashboardLayout } from "./views/components/dashboard-layout";

type AppProps = {
  children: ReactNode;
}

const footerStyles = {
  position: 'fixed',
  bottom: 0,
  left: 0,
  width: '100%',
  height: '50px',
  backgroundColor: '#f5f5f5',
  display: 'flex',
  alignItems: 'center',
  justifyContent: 'center',
};

const copyrightStyles = {
  fontSize: '12px',
  color: '#999',
};

interface Props {
  /**
   * Injected by the documentation to work in an iframe.
   * You won't need it on your project.
   */
  window?: () => Window;
  children: React.ReactElement;
}

function HideOnScroll(props: Props) {
  const { children, window } = props;
  // Note that you normally won't need to set the window ref as useScrollTrigger
  // will default to window.
  // This is only being set here because the demo is in an iframe.
  const trigger = useScrollTrigger({
    target: window ? window() : undefined,
  });

  return (
    <Slide appear={false} direction="down" in={!trigger}>
      {children}
    </Slide>
  );
}

function App({ children }: AppProps) {
  const currentYear = new Date().getFullYear();


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
        <HideOnScroll >
          <AppBar>
            <Toolbar>
              <Typography variant="h6" component="div">
                RVI report viewer
              </Typography>
            </Toolbar>
          </AppBar>
        </HideOnScroll>
        <Login />
        <Box sx={footerStyles}>
          <span style={copyrightStyles}>
            &copy; {currentYear} RVI. All rights reserved.
          </span>
        </Box>
      </>

  )
}

export default App
