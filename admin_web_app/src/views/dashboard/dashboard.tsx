import { Container, Grid } from "@mui/material";
import { SummaryCard } from "./summary_card";
import DevicesOtherIcon from "@mui/icons-material/DevicesOther";
import PeopleIcon from "@mui/icons-material/People";
import AccessibilityIcon from "@mui/icons-material/Accessibility";
import { useGetDashboardSummaryQuery } from "../../services/dashboard_service";
import ForumIcon from "@mui/icons-material/Forum";
import LooksOneIcon from "@mui/icons-material/LooksOne";
import LooksTwoIcon from "@mui/icons-material/LooksTwo";
import Looks3Icon from "@mui/icons-material/Looks3";
import Looks4Icon from "@mui/icons-material/Looks4";
import Looks5Icon from "@mui/icons-material/Looks5";
import Looks6Icon from "@mui/icons-material/Looks6";
import { SummaryCardThin } from "./summary_card_thin";
import SessionTimeoutPopup from "../components/session_logout";
import { GraphSummaryCardBattery } from "./summary_card_gt";
import { ModeSeven, useGetGtTestsMutation } from "../../services/gt_service";
import { collection, getDocs } from "firebase/firestore";
import { db } from "../datagrid/firebase_config";
import React, { useState, useEffect } from "react";
import { Height } from "@mui/icons-material";

export default function Dashboard() {

  const [pcbChina, setPcbChina] = React.useState(0);
  const [pcbSrilanka, setPcbSrilanka] = React.useState(0);
  const [batteryChina, setBatteryChina] = React.useState(0);
  const [batterySrilanka, setBatterySrilanka] = React.useState(0);

  const [isLoading3, setIsLoading3] = React.useState(true);

  const pcb_test_1 = collection(db, "pcb_test_1");
  const pcb_test_2 = collection(db, "pcb_test_2");
  const pcb_test_3 = collection(db, "pcb_test_3");
  const pcb_test_4 = collection(db, "pcb_test_4");

  const battery_test_1 = collection(db, "battery_test_1");
  const battery_test_2 = collection(db, "battery_test_2");
  const battery_test_3 = collection(db, "battery_test_3");
  const battery_test_4 = collection(db, "battery_test_4");

  const getNumber = async (): Promise<void> => {

    
    const pcb1 = await getDocs(pcb_test_1);
    const pcb2 = await getDocs(pcb_test_2);
    const pcb_china = pcb1.docs.length + pcb2.docs.length;
    setPcbChina(pcb_china);

    const pcb3 = await getDocs(pcb_test_3);
    const pcb4 = await getDocs(pcb_test_4);
    const pcb_srilanka = pcb3.docs.length + pcb4.docs.length;
    setPcbSrilanka(pcb_srilanka);

    const battery1 = await getDocs(battery_test_1);
    const battery2 = await getDocs(battery_test_2);
    const battery_china = battery1.docs.length + battery2.docs.length;
    setBatteryChina(battery_china);

    const battery3 = await getDocs(battery_test_3);
    const battery4 = await getDocs(battery_test_4);
    const battery_srilanka = battery3.docs.length + battery4.docs.length;
    setBatterySrilanka(battery_srilanka);

    setIsLoading3(false);
    
  };
  
  useEffect(() => {
    getNumber();
    getGtTests({});
  }, []);
  


  const { data, error, isLoading } = useGetDashboardSummaryQuery("");
  const [getGtTests, { data:data1, error:error1, isLoading:isLoading1 }] = useGetGtTestsMutation();
  var userRoles: string | string[] = [];
  var admin = "";
  var roles = localStorage.getItem("roles");

  

  //get user roles from local storage
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

  if (isLoading || isLoading1 || isLoading3) {
    return <div>Loading...</div>;
  }

  if (error != null && "status" in error) {
    if (error.status == 401 && error.data == null) {
      return <SessionTimeoutPopup />;
    } else {
      return <></>;
    }
  } else {
    return (
      // isLoading ? <></> :
      <Container maxWidth={false}>
        <Grid container  spacing={3}>
          <Grid  item lg={2} sm={6} xl={2} xs={12}>
            <SummaryCard 
              title="Mode 01"
              icon={<LooksOneIcon />}
              value={data?.modeOne.toString() || "0"}
              color="warning.main"
              path="/mode-one"
            />
          </Grid>
          <Grid item xl={2} lg={2} sm={6} xs={12}>
            <SummaryCard
              title="Glove test"
              icon={<Looks6Icon />}
              value={data1?.sessions.length.toString() || "0"}
              color="success.dark"
              path="/end/line/qc"
            />
          </Grid>
          <Grid item xl={2} lg={2} sm={6} xs={12}>
            <SummaryCard
              title="Battery test Sri Lanka"
              icon={<LooksTwoIcon />}
              value={batterySrilanka.toString() || "0"}
              color="success.light"
              path="/battery_srilanka"
            />
          </Grid>
          <Grid item xl={2} lg={2} sm={6} xs={12}>
            <SummaryCard
              title="Battery test China"
              icon={<Looks3Icon />}
              value={batteryChina.toString() || "0"}
              color="success.main"
              path="/battery_china"
            />
          </Grid>
          <Grid item xl={2} lg={2} sm={6} xs={12}>
            <SummaryCard
              title="PCB test Sri Lanka"
              icon={<Looks4Icon />}
              value={pcbSrilanka.toString() || "0"}
              color="success.dark"
              path="/pcb_srilanka"
            />
          </Grid>
          <Grid item xl={2} lg={2} sm={6} xs={12}>
            <SummaryCard
              title="PCB test China"
              icon={<Looks5Icon />}
              value={ pcbChina.toString() || "0"}
              color="success.dark"
              path="/pcb_china"
            />
          </Grid>
          


          {/* <Grid item xl={2} lg={2} sm={6} xs={12}>
            <SummaryCard
              title="Mode 02"
              icon={<LooksTwoIcon />}
              value={data?.modeTwo.toString() || "0"}
              color="success.light"
              path="/mode-two"
            />
          </Grid>
          <Grid item xl={2} lg={2} sm={6} xs={12}>
            <SummaryCard
              title="Mode 03"
              icon={<Looks3Icon />}
              value={data?.modeThree.toString() || "0"}
              color="success.main"
              path="/mode-three"
            />
          </Grid>
          <Grid item xl={2} lg={2} sm={6} xs={12}>
            <SummaryCard
              title="Mode 04"
              icon={<Looks4Icon />}
              value={data?.modeFour.toString() || "0"}
              color="success.dark"
              path="/mode-four"
            />
          </Grid>
          <Grid item xl={2} lg={2} sm={6} xs={12}>
            <SummaryCard
              title="Mode 05"
              icon={<Looks5Icon />}
              value={data?.modeFive.toString() || "0"}
              color="success.dark"
              path="/mode-five"
            />
          </Grid>
          <Grid item xl={2} lg={2} sm={6} xs={12}>
            <SummaryCard
              title="Mode 06"
              icon={<Looks6Icon />}
              value={data?.modeSix.toString() || "0"}
              color="success.dark"
              path="/mode-six"
            />
          </Grid> */}
        </Grid>

        <Grid container spacing={3} sx={{ mt: 5 }}>
          <Grid item lg={6} sm={6} xl={6} xs={12}>
            <SummaryCardThin
              title="Devices"
              icon={<DevicesOtherIcon />}
              value={data?.devices.toString() || "0"}
              color="warning.main"
              path="/devices"
            />
          </Grid>
          <Grid item lg={6} sm={6} xl={6} xs={12}>
            <SummaryCardThin
              title="Users"
              icon={<PeopleIcon />}
              value={data?.users.toString() || "0"}
              color="warning.main"
              path="/users"
            />
          </Grid>
        </Grid>

        {/* <Grid container spacing={3} sx={{ mt: 3 }}>
          <Grid item lg={6} sm={6} xl={6} xs={12} sx={{ width: "100%" }}>
            <GraphSummaryCardBattery />
          </Grid>
        </Grid> */}
      </Container>
    );
  }
}
