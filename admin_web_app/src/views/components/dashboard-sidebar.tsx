import { useEffect } from "react";
import PropTypes from "prop-types";
import {
  Box,
  Divider,
  Drawer,
  List,
  ListItem,
  ListItemButton,
  ListItemIcon,
  ListItemText,
  ListSubheader,
  Typography,
  useMediaQuery,
} from "@mui/material";
import LooksOneIcon from "@mui/icons-material/LooksOne";
import LooksTwoIcon from "@mui/icons-material/LooksTwo";
import Looks3Icon from "@mui/icons-material/Looks3";
import PeopleAltIcon from '@mui/icons-material/PeopleAlt';
import InventoryIcon from '@mui/icons-material/Inventory';
import AllInboxIcon from '@mui/icons-material/AllInbox';
import LocalShippingIcon from '@mui/icons-material/LocalShipping';
import Looks4Icon from "@mui/icons-material/Looks4";
import Looks5Icon from "@mui/icons-material/Looks5";
import Looks6Icon from "@mui/icons-material/Looks6";
import DashboardIcon from "@mui/icons-material/Dashboard";
import Pattern from "@mui/icons-material/Pattern";
import BugReport from "@mui/icons-material/BugReport";
import HardwareIcon from "@mui/icons-material/Hardware";
import AddIcon from "@mui/icons-material/Add";
import SupportAgentIcon from "@mui/icons-material/SupportAgent";
import SportsMmaIcon from "@mui/icons-material/SportsMma";
import BatteryChargingFullIcon from "@mui/icons-material/BatteryChargingFull";
import SportsEsportsIcon from "@mui/icons-material/SportsEsports";
import CableIcon from "@mui/icons-material/Cable";
import { NavItem } from "./nav-item";
import {
  Add,
  Construction,
  Devices,
  Domain,
  Group,
  ListAlt,
  LocalShipping,
  People,
  PersonAddAlt,
} from "@mui/icons-material";

const items = [
  {
    href: "/",
    icon: <DashboardIcon fontSize="small" />,
    title: "Dashboard",
    childs: [],
  },
  {
    href: "#",
    icon: <Domain fontSize="small" />,
    title: "Plants",
    childs: [
      {
        href: "/plants",
        icon: <ListAlt fontSize="small" />,
        title: "List",
        childs: [],
      },
    ],
  },
  {
    href: "#",
    icon: <SupportAgentIcon fontSize="small" />,
    title: "Customers",
    childs: [
      {
        href: "/customers",
        icon: <ListAlt fontSize="small" />,
        title: "List",
        childs: [],
      },
    ],
  },
  {
    href: "#",
    icon: <Pattern fontSize="small" />,
    title: "Styles",
    childs: [
      {
        href: "/styles",
        icon: <ListAlt fontSize="small" />,
        title: "List",
        childs: [],
      },
    ],
  },
  {
    href: "#",
    icon: <Construction fontSize="small" />,
    title: "Sessions",
    childs: [
      {
        href: "/mode-one",
        icon: <LooksOneIcon fontSize="small" />,
        title: "Mode One",
        childs: [],
      },
      {
        href: "/mode-two",
        icon: <LooksTwoIcon fontSize="small" />,
        title: "Mode Two",
        childs: [],
      },
      {
        href: "/mode-three",
        icon: <Looks3Icon fontSize="small" />,
        title: "Mode Three",
        childs: [],
      },
      {
        href: "/mode-four",
        icon: <Looks4Icon fontSize="small" />,
        title: "Mode Four",
        childs: [],
      },
      {
        href: "/mode-five",
        icon: <Looks5Icon fontSize="small" />,
        title: "Mode Five",
        childs: [],
      },
      {
        href: "/mode-six",
        icon: <Looks6Icon fontSize="small" />,
        title: "Mode Six",
        childs: [],
      },
    ],
  },
  {
    href: "#",
    icon: <People fontSize="small" />,
    title: "Users",
    childs: [
      {
        href: "/users",
        icon: <ListAlt fontSize="small" />,
        title: "List",
        childs: [],
      },
    ],
  },
  {
    href: "#",
    icon: <Devices fontSize="small" />,
    title: "Devices",
    childs: [
      // {
      //   href: '/add-device',
      //   icon: (<Add fontSize="small" />),
      //   title: 'Add',
      //   childs: []
      // },
      {
        href: "/devices",
        icon: <ListAlt fontSize="small" />,
        title: "List",
        childs: [],
      },
    ],
  },
  {
    href: "#",
    icon: <BugReport fontSize="small" />,
    title: "Testing",
    childs: [
      {
        href: "/tests",
        icon: <ListAlt fontSize="small" />,
        title: "List",
        childs: [],
      },
    ],
  },
  {
    href: "#",
    icon: <SportsEsportsIcon fontSize="small" />,
    title: "Gamer Tech",
    childs: [
      {
        href: "#",
        icon: <BatteryChargingFullIcon fontSize="small" />,
        title: "Battery Tests",
        childs: [
          {
            href: "/battery_srilanka",
            icon: <ListAlt fontSize="small" />,
            title: "Battery Tests (Sri Lanka)",
            childs: [],
          },
          {
            href: "/battery_china",
            icon: <ListAlt fontSize="small" />,
            title: "Battery Tests (China)",
            childs: [],
          },
        ],
      },
      {
        href: "#",
        icon: <CableIcon fontSize="small" />,
        title: "PCB Tests",
        childs: [
          {
            href: "/pcb_srilanka",
            icon: <ListAlt fontSize="small" />,
            title: "PCB Tests (Sri Lanka)",
            childs: [],
          },
          {
            href: "/pcb_china",
            icon: <ListAlt fontSize="small" />,
            title: "PCB Tests (China)",
            childs: [],
          },
        ],
      },
      {
        href: "#",
        icon: <SportsMmaIcon fontSize="small" />,
        title: "Glove Testing",
        childs: [
          {
            href: "/end/line/qc",
            icon: <ListAlt fontSize="small" />,
            title: "List",
            childs: [],
          },
        ],
      },
    ],
  },

  {
    href: "#",
    icon: <LocalShippingIcon fontSize="small" />,
    title: "GT Packaging",
    childs: [
      // {
      //   href: "#",
      //   icon: <AllInboxIcon fontSize="small" />,
      //   title: "Packaging Box",
      //   childs: [
      //     {
      //       href: "/packaging-box",
      //       icon: <ListAlt fontSize="small" />,
      //       title: "List",
      //       childs: [],
      //     },          
      //   ],
      // },
      // {
      //   href: "#",
      //   icon: <InventoryIcon fontSize="small" />,
      //   title: "Corrugated Box",
      //   childs: [
      //     {
      //       href: "/corrugated-box",
      //       icon: <ListAlt fontSize="small" />,
      //       title: "List",
      //       childs: [],
      //     },         
      //   ],
      // },
      {
        href: "#",
        icon: <InventoryIcon fontSize="small" />,
        title: "GT Tracking",
        childs: [
          {
            href: "/gtTracking-box",
            icon: <ListAlt fontSize="small" />,
            title: "List",
            childs: [],
          },         
        ],
      },
      {
        href: "#",
        icon: <PeopleAltIcon fontSize="small" />,
        title: "Shipping Details",
        childs: [
          {
            href: "/shipping-detail-list",
            icon: <ListAlt fontSize="small" />,
            title: "List",
            childs: [],
          },
        ],
      },
      {
        href: "#",
        icon: <PeopleAltIcon fontSize="small" />,
        title: "Users",
        childs: [
          {
            href: "/box-user-list",
            icon: <ListAlt fontSize="small" />,
            title: "List",
            childs: [],
          },
        ],
      },
    ],
  },

  

];

type DashboardSidebarData = {
  open: boolean;
  closeSideBar: () => void;
};

export const DashboardSidebar = ({
  open,
  closeSideBar,
}: DashboardSidebarData) => {
  var userRoles: string | string[] = [];
  var admin = "";
  var roles = localStorage.getItem("roles");

  if (roles === null) {
    console.log("roles empty");
  } else {
    userRoles = roles.split(",").map((item) => item.trim());
    if (
      userRoles.includes("CREATE_TOP_ADMIN") &&
      userRoles.includes("CREATE_ADMIN")
    ) {
      admin = "TOP_ADMIN";
    } else if (userRoles.includes("CREATE_USER")) {
      admin = "ADMIN";
    }
  }

  //customizes side bar according to user's permissions
  const newList = items.filter(
    (item) =>
      item.title !== "Customers" &&
      item.title !== "Plants" &&
      item.title !== "Styles"
    //  &&
    // item.title !== "Testing"
  );

  const lgUp = useMediaQuery((theme: any) => theme.breakpoints.up("lg"), {
    defaultMatches: true,
    noSsr: false,
  });

  const content = (
    <>
      <Box
        sx={{
          display: "flex",
          flexDirection: "column",
          height: "100%",
          width: "100%",
        }}
      >
        <div>
          <Box sx={{ pt: 4, pl: 5 }}>
            <Typography color="grey" variant="h5" sx={{}}>
              RVI Analyzer
            </Typography>
          </Box>
        </div>
        <Divider
          sx={{
            borderColor: "#2D3748",
            my: 3,
          }}
        />
        <Box sx={{ flexGrow: 1, marginY: 2 }}>
          {admin === "ADMIN"
            ? newList.map((item) => (
                <NavItem
                  key={item.title}
                  icon={item.icon}
                  href={item.href}
                  title={item.title}
                  childs={item.childs}
                />
              ))
            : items
                .filter((item) => item.title !== "Sessions")
                .map((item) => (
                  <NavItem
                    key={item.title}
                    icon={item.icon}
                    href={item.href}
                    title={item.title}
                    childs={item.childs}
                  />
                ))}
        </Box>

        <Divider sx={{ borderColor: "#2D3748" }} />
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
            width: 280,
            borderRightStyle: "dashed",
            borderColor: "#9d9e9d",
          },
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
          width: 300,
          borderRightStyle: "dashed",
          borderColor: "#9d9e9d",
        },
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
  open: PropTypes.bool,
};
