import React, { useEffect, useState } from "react";
import BatteryTest from "./battery";
import { ModeSeven, useGetGtTestsMutation } from "../../services/gt_service";
import { Typography } from '@mui/material';

export const Battery_srilanka = () => {
  const [getGtTests, { data, error, isLoading }] = useGetGtTestsMutation();
  const [feed, setFeed] = useState(false);

  useEffect(() => {
    getGtTests({});
    setFeed(true);
  }, []);

  useEffect(() => {
    console.log(data?.sessions);
  }, [data]);
  return (
    <div>
      <Typography
            color="grey"
            variant="h5"
            sx={{ ml: 5 }}
          >
           Battery Test Sri Lanka
          </Typography>
      <BatteryTest collection1="battery_test_3" collection2="battery_test_4" hours={5} minutes={20}/>
    </div>
  );
};
