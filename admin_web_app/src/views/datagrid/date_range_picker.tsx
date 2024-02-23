import React, { useState } from 'react';
import { AdapterDayjs } from '@mui/x-date-pickers/AdapterDayjs';
import { LocalizationProvider } from '@mui/x-date-pickers/LocalizationProvider';
import { DatePicker } from '@mui/x-date-pickers/DatePicker';

export default function DatePickerComponent({ label, onChange }) {
  const [selectedDate, setSelectedDate] = useState(null);

  const handleDateChange = (date: React.SetStateAction<null>) => {
    setSelectedDate(date);
    onChange(date);
  };

  return (
    <LocalizationProvider dateAdapter={AdapterDayjs}>
      <DatePicker label={label} value={selectedDate} onChange={handleDateChange} />
    </LocalizationProvider>
  );
}