import React, { useEffect } from "react";
import BatteryTest from "./battery";
import { ModeSeven, useGetGtTestsMutation } from "../../services/gt_service";
import { Typography } from '@mui/material';

export const Battery_china = () => {
  return (
    <div>
       <Typography
            color="grey"
            variant="h5"
            sx={{ ml: 5 }}
          >
           Battery Test China
          </Typography>
      <BatteryTest collection1="battery_test_1" collection2="battery_test_2" hours={8} minutes={0}/>
    </div>
  );
};
