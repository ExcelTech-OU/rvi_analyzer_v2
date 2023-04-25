import { useEffect } from 'react';
import PropTypes from 'prop-types';
import { Box, Divider, Drawer, useMediaQuery } from '@mui/material';
import LooksOneIcon from '@mui/icons-material/LooksOne';
import LooksTwoIcon from '@mui/icons-material/LooksTwo';
import Looks3Icon from '@mui/icons-material/Looks3';
import Looks4Icon from '@mui/icons-material/Looks4';
import Looks5Icon from '@mui/icons-material/Looks5';
import Looks6Icon from '@mui/icons-material/Looks6';
import DashboardIcon from '@mui/icons-material/Dashboard';
import { NavItem } from './nav-item';

const items = [
  {
    href: '/',
    icon: (<DashboardIcon fontSize="small" />),
    title: 'Home'
  },
  {
    href: '/mode-one',
    icon: (<LooksOneIcon fontSize="small" />),
    title: 'Mode One'
  },
  {
    href: '/mode-two',
    icon: (<LooksTwoIcon fontSize="small" />),
    title: 'Mode Two'
  },
  {
    href: '/mode-three',
    icon: (<Looks3Icon fontSize="small" />),
    title: 'Mode Three'
  },
  {
    href: '/mode-four',
    icon: (<Looks4Icon fontSize="small" />),
    title: 'Mode Four'
  },
  {
    href: '/mode-five',
    icon: (<Looks5Icon fontSize="small" />),
    title: 'Mode Five'
  },
  {
    href: '/mode-six',
    icon: (<Looks6Icon fontSize="small" />),
    title: 'Mode Six'
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
