import React from "react";
import DatasetTable from "./pcb";
import { Typography } from '@mui/material';

export const Pcb_srilanka = () => {
  return (
    <div>
      <Typography
            color="grey"
            variant="h5"
            sx={{ ml: 5 }}
          >
           PCB Test Sri Lanka
          </Typography>
      <DatasetTable collection1="pcb_test_3" collection2="pcb_test_4" hours={5} minutes={30} />
    </div>
  );
};
