import React, { useEffect } from "react";
import BatteryTest from "./battery";

import { useGetGtTestsMutation } from "../../services/gt_service";

export const Battery_srilanka = () => {

  const [getGtTests, {data, error, isLoading}] = useGetGtTestsMutation();

  useEffect(() => {
    getGtTests({});
    console.log("dddfff");
    
  }, []);

  useEffect(() => {
    console.log(data?.sessions);
  },[data])



  return (
    <div>
      <BatteryTest collection1="battery_test_1" collection2="battery_test_2" />
    </div>
  );
};
