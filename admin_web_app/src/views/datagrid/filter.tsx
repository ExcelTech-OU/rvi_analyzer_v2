// BasicSelect.tsx
import * as React from 'react';
import Box from '@mui/material/Box';
import InputLabel from '@mui/material/InputLabel';
import MenuItem from '@mui/material/MenuItem';
import FormControl from '@mui/material/FormControl';
import Select, { SelectChangeEvent } from '@mui/material/Select';

interface BasicSelectProps {
  label: string;
  onSelectChange: (selectedValue: string) => void;
}

const BasicSelect: React.FC<BasicSelectProps> = ({label, onSelectChange }) => {
  const [value, setValue] = React.useState('');

  const handleChange = (event: SelectChangeEvent) => {
    const selectedValue = event.target.value as string;
    setValue(selectedValue);
    onSelectChange(selectedValue); // Invoke the callback with the selected value
  };

  return (
    <Box sx={{ minWidth: 120 }}>
      <FormControl fullWidth>
        <InputLabel id="demo-simple-select-label">{label}</InputLabel>
        <Select
          labelId="demo-simple-select-label"
          id="demo-simple-select"
          value={value}
          label={label}
          onChange={handleChange}
        >
          <MenuItem value={"Pass"}>Pass</MenuItem>
          <MenuItem value={"Fail"}>Fail</MenuItem>
        </Select>
      </FormControl>
    </Box>
  );
}

export default BasicSelect;
