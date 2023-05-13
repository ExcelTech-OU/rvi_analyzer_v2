import PropTypes from 'prop-types';
import { Box, Button, Collapse, List, ListItem, ListItemButton, ListItemIcon, ListItemText } from '@mui/material';
import { Link, useLocation } from 'react-router-dom';
import { ExpandLess, ExpandMore, StarBorder } from '@mui/icons-material';
import { useEffect, useState } from 'react';

export type NavItemProps = {
  href: string,
  icon: React.ReactNode,
  title: string,
  childs: NavItemProps[]
}

export const NavItem = ({ href, icon, title, childs }: NavItemProps) => {
  const location = useLocation();
  const active = href ? (location.pathname === href) : false;
  const [open, setOpen] = useState(false);


  return (
    <>
      <ListItem
        disableGutters
        sx={{
          display: 'flex',
          mb: 0.5,
          py: 0,
          px: 2
        }}
      >
        <Link
          to={href}
          onClick={childs.length != 0 ? () => setOpen(!open) : () => null}
          style={{ textDecoration: 'none', width: '100%' }}
        >
          <Button
            startIcon={icon}
            disableRipple
            sx={{
              backgroundColor: active ? '#dfeff5' : '',
              borderRadius: 1,
              color: active ? 'secondary.main' : 'grey',
              fontWeight: active ? 'fontWeightBold' : '',
              justifyContent: 'flex-start',
              px: 3,
              textAlign: 'left',
              textTransform: 'none',
              width: '100%',
              '& .MuiButton-startIcon': {
                color: active ? 'secondary.main' : '#9CA3AF'
              },
              '&:hover': {
                backgroundColor: active ? '#dfeff5' : '#e3e3e3'
              }
            }}
            endIcon={childs.length != 0 ? (open ? <ExpandLess /> : <ExpandMore />) : ""}
          >
            <Box sx={{ flexGrow: 1 }}>
              {title}
            </Box>

          </Button>
        </Link>

      </ListItem>
      <Collapse in={open} timeout="auto" unmountOnExit>
        <List component="div" disablePadding>
          <Box sx={{ flexGrow: 1, ml: 2 }}>
            {childs.map((item) => (
              <NavItem
                key={item.title}
                icon={item.icon}
                href={item.href}
                title={item.title}
                childs={item.childs}
              />
            ))}
          </Box>
        </List>
      </Collapse>
    </>
  );
};

NavItem.propTypes = {
  href: PropTypes.string,
  icon: PropTypes.node,
  title: PropTypes.string
};
