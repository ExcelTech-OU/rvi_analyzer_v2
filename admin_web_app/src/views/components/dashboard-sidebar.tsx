import { useEffect } from 'react';
import PropTypes from 'prop-types';
import { Box, Divider, Drawer, useMediaQuery } from '@mui/material';
import PeopleIcon from '@mui/icons-material/People';
import AccessibilityIcon from '@mui/icons-material/Accessibility';
import ForumIcon from '@mui/icons-material/Forum';
import DevicesOtherIcon from '@mui/icons-material/DevicesOther';
import DashboardIcon from '@mui/icons-material/Dashboard';
import { NavItem } from './nav-item';

const items = [
  {
    href: '/',
    icon: (<DashboardIcon fontSize="small" />),
    title: 'Dashboard'
  },
  {
    href: '/devices',
    icon: (<DevicesOtherIcon fontSize="small" />),
    title: 'Device Management'
  },
  {
    href: '/users',
    icon: (<PeopleIcon fontSize="small" />),
    title: 'User Management'
  },
  {
    href: '/sessions',
    icon: (<AccessibilityIcon fontSize="small" />),
    title: 'Session Management'
  },
  {
    href: '/questions',
    icon: (<ForumIcon fontSize="small" />),
    title: 'Question Management'
  }
];

type DashboardSidebarData = {
  open: boolean,
  closeSideBar: () => void
}

export const DashboardSidebar = ({ open, closeSideBar }: DashboardSidebarData) => {
  const lgUp = useMediaQuery((theme: any) => theme.breakpoints.up('lg'), {
    defaultMatches: true,
    noSsr: false
  });

  const content = (
    <>
      <Box
        sx={{
          display: 'flex',
          flexDirection: 'column',
          height: '100%'
        }}
      >
        <div>
          <Box sx={{ p: 4 }}>

          </Box>

        </div>
        <Divider
          sx={{
            borderColor: '#2D3748',
            my: 3
          }}
        />
        <Box sx={{ flexGrow: 1 }}>
          {items.map((item) => (
            <NavItem
              key={item.title}
              icon={item.icon}
              href={item.href}
              title={item.title}
            />
          ))}
        </Box>
        <Divider sx={{ borderColor: '#2D3748' }} />
      </Box>
    </>
  );

  if (lgUp) {
    return (
      <Drawer
        anchor="left"
        open
        PaperProps={{
          sx: {
            backgroundColor: '#121826',
            color: '#FFFFFF',
            width: 280
          }
        }}
        variant="permanent"
      >
        {content}
      </Drawer>
    );
  }

  return (
    <Drawer
      anchor="left"
      onClose={closeSideBar}
      open={open}
      PaperProps={{
        sx: {
          backgroundColor: 'black',
          color: '#FFFFFF',
          width: 280
        }
      }}
      sx={{ zIndex: (theme) => theme.zIndex.appBar + 100 }}
      variant="temporary"
    >
      {content}
    </Drawer>
  );
};

DashboardSidebar.propTypes = {
  onClose: PropTypes.func,
  open: PropTypes.bool
};
