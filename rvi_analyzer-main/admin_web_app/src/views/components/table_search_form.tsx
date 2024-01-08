import { Box, Button, FormControl, Grid, InputLabel, MenuItem, Select, SelectChangeEvent, TextField, Typography } from '@mui/material'
import { DatePicker, LocalizationProvider } from '@mui/x-date-pickers';
import { AdapterDayjs } from '@mui/x-date-pickers/AdapterDayjs';
import { useFormik } from 'formik';
import React, { useState } from 'react';
import * as Yup from 'yup';

type TableSearchProps = {
    searchFun: (date: Date | null, filterType: string, filterValue: string) => void
}

export default function TableSearchForm({ searchFun }: TableSearchProps) {

    const [age, setFilterType] = React.useState('');
    const [selectedDate, setSelectedDate] = useState<Date | null>(null);

    const formik = useFormik({
        initialValues: {
            searchValue: '',
            password: ''
        },
        validationSchema: Yup.object({
            searchValue: Yup
                .string()
                .max(255),
            password: Yup
                .string()
                .max(100)
        }),
        onSubmit: (values, actions) => {
            searchFun(selectedDate, age, values.searchValue);
        }
    });

    const handleDateChange = (date: Date | null) => {
        setSelectedDate(date);
    };

    const handleChange = (event: SelectChangeEvent) => {
        setFilterType(event.target.value as string);
    };

    return (
        <form onSubmit={formik.handleSubmit}>

            <Grid container spacing={{ xs: 2, md: 3 }} columns={{ xs: 4, sm: 8, md: 12 }}>
                <Grid item xs={4} sm={4} md={6} >
                    <TextField
                        sx={{ input: { color: 'grey' } }}
                        error={Boolean(formik.touched.searchValue && formik.errors.searchValue)}
                        fullWidth
                        helperText={formik.touched.searchValue && formik.errors.searchValue}
                        label="Search"
                        margin="normal"
                        name="searchValue"
                        onBlur={formik.handleBlur}
                        onChange={formik.handleChange}
                        type="string"
                        value={formik.values.searchValue}
                        variant="outlined"
                    />
                </Grid>
                <Grid item xs={4} sm={4} md={2} >
                    <FormControl style={{ minWidth: "100%" }} sx={{ mt: 2 }}>
                        <InputLabel id="demo-simple-select-label">Filter Type</InputLabel>
                        <Select
                            labelId="demo-simple-select-label"
                            id="demo-simple-select"
                            value={age}
                            label="Filter Type"
                            onChange={handleChange}
                            MenuProps={{
                                PaperProps: {
                                    sx: {
                                        "& .MuiMenuItem-root.Mui-selected": {
                                            backgroundColor: "#e0e0e0"
                                        },
                                        "& .MuiMenuItem-root:hover": {
                                            backgroundColor: "#e0e0e0"
                                        },
                                        "& .MuiMenuItem-root.Mui-selected:hover": {
                                            backgroundColor: "#e0e0e0"
                                        }
                                    }
                                }
                            }}

                        >
                            <MenuItem value={"CREATED_BY"}>CREATED BY</MenuItem>
                            <MenuItem value={"CUSTOMER_NAME"}>CUSTOMER NAME</MenuItem>
                            <MenuItem value={"OPERATOR_ID"}>OPERATOR ID</MenuItem>
                            <MenuItem value={"BATCH_NO"}>BATCH NO</MenuItem>
                            <MenuItem value={"SESSION_ID"}>SESSION ID</MenuItem>
                        </Select>
                    </FormControl>
                </Grid>
                <Grid item xs={4} sm={4} md={2}>
                    <FormControl style={{ minWidth: "100%" }} sx={{ mt: 2 }}>
                        <LocalizationProvider dateAdapter={AdapterDayjs} >
                            <DatePicker
                                label="Select Date"
                                value={selectedDate}
                                onChange={handleDateChange}
                            />
                        </LocalizationProvider>
                    </FormControl>
                </Grid>
                <Grid item xs={4} sm={4} md={2}  >
                    <Box sx={{ mt: 2, height: "500" }}>
                        <Button
                            color="primary"
                            fullWidth
                            size="large"
                            type="submit"
                            variant="contained"
                            sx={{ height: "54px" }}
                        >
                            Search
                        </Button>
                    </Box>
                </Grid>
            </Grid>
        </form>
    )
}