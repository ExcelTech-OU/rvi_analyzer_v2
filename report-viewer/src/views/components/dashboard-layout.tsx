import { useState } from 'react';
import { Box } from '@mui/material';
import { styled } from '@mui/material/styles';
import { DashboardNavbar } from './dashboard-navbar';
import { DashboardSidebar } from './dashboard-sidebar';

const DashboardLayoutRoot = styled('div')(({ theme }) => ({
  display: 'flex',
  flex: '1 1 auto',
  maxWidth: '100%',
  paddingTop: 64,
  [theme.breakpoints.up('lg')]: {
    paddingLeft: 280
  }
}));

export const DashboardLayout = (props: any) => {
  const { children } = props;
  const [isSidebarOpen, setSidebarOpen] = useState(false);

  const handleOpen = () => {
    setSidebarOpen(true);
  };

  const handleClose = () => {
    setSidebarOpen(false);
  };

  return (
    <>
      <DashboardLayoutRoot>
        <Box
          sx={{
            display: 'flex',
            flex: '1 1 auto',
            flexDirection: 'column',
            width: '100%'
          }}
        >
          {children}
        </Box>
      </DashboardLayoutRoot>
      <DashboardNavbar openSideBar={() => handleOpen()} />
      <DashboardSidebar
        closeSideBar={() => handleClose()}
        open={isSidebarOpen}
      />
    </>
  );
};
