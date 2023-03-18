import PropTypes from 'prop-types';
import { Box, Button, ListItem } from '@mui/material';
import { Link, useLocation } from 'react-router-dom';

export const NavItem = (props: any) => {
  const { href, icon, title, ...others } = props;
  const location = useLocation();
  const active = href ? (location.pathname === href) : false;

  return (
    <ListItem
      disableGutters
      sx={{
        display: 'flex',
        mb: 0.5,
        py: 0,
        px: 2
      }}
      {...others}
    >
      <Link
        to={href}
        style={{ textDecoration: 'none', width: '100%' }}
      >
        <Button
          startIcon={icon}
          disableRipple
          sx={{
            backgroundColor: active ? 'rgba(255,255,255, 0.08)' : '',
            borderRadius: 1,
            color: active ? 'secondary.main' : '#D1D5DB',
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
              backgroundColor: 'rgba(255,255,255, 0.08)'
            }
          }}
        >
          <Box sx={{ flexGrow: 1 }}>
            {title}
          </Box>
        </Button>
      </Link>
    </ListItem>
  );
};

NavItem.propTypes = {
  href: PropTypes.string,
  icon: PropTypes.node,
  title: PropTypes.string
};
