import React, { useEffect } from "react";
import BatteryTest from "./battery";
import { ModeSeven, useGetGtTestsMutation } from "../../services/gt_service";

export const Battery_china = () => {
  return (
    <div>
      <BatteryTest collection1="battery_test_3" collection2="battery_test_4" />
    </div>
  );
};
