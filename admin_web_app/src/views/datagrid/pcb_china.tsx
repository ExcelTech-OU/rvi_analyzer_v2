import React from "react";
import DatasetTable from "./pcb";
import { Typography } from '@mui/material';

export const Pcb_china = () => {
  return (
    <div>
      <Typography
            color="grey"
            variant="h5"
            sx={{ ml: 5 }}
          >
           PCB Test China
          </Typography>
      <DatasetTable collection1="pcb_test_1" collection2="pcb_test_2" hours={8} minutes={0} />
    </div>
  );
};
