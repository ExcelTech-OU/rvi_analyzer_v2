import React, { useState } from "react";
import { AdapterDayjs } from "@mui/x-date-pickers/AdapterDayjs";
import { LocalizationProvider } from "@mui/x-date-pickers/LocalizationProvider";
import { DatePicker } from "@mui/x-date-pickers/DatePicker";

interface DatePickerComponentProps {
  label: string;
  onChange: (date: React.SetStateAction<null>) => void;
}

export default function DatePickerComponentPackagingBox({
  label,
  onChange,
}: DatePickerComponentProps) {
  const [selectedDate, setSelectedDate] = useState(null);

  const handleDateChange = (date: React.SetStateAction<null>) => {
    setSelectedDate(date);
    onChange(date);
  };
  console.log(selectedDate);

  return (
    <LocalizationProvider dateAdapter={AdapterDayjs}>
      <DatePicker
        label={label}
        value={selectedDate}
        onChange={handleDateChange}
      />
    </LocalizationProvider>
  );
}
