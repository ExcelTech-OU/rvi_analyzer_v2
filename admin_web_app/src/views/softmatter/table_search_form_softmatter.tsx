import { Box, Button, FormControl, Grid, InputLabel, MenuItem, Select, SelectChangeEvent, TextField, Typography } from '@mui/material'
import { DatePicker, LocalizationProvider } from '@mui/x-date-pickers';
import { AdapterDayjs } from '@mui/x-date-pickers/AdapterDayjs';
import { useFormik } from 'formik';
import React, { useState } from 'react';
import * as Yup from 'yup';

type TableSearchCommonProps = {
    searchFun: (date: Date | null, filterType: string, filterValue: string) => void
}

export default function TableSearchFormSoftmatter({ searchFun }: TableSearchCommonProps) {

    const [age, setFilterType] = React.useState('');
    const [selectedDate, setSelectedDate] = useState<Date | null>(null);

    const formik = useFormik({
        initialValues: {
            project: '', // Update the field names here
            S_O: '',
            date: '',
            time: '',
            test: '',
            pass_fail: '',
        },
        validationSchema: Yup.object({
            project: Yup
                .string()
                .max(255),
            S_O: Yup
                .string()
                .max(255),
            date: Yup
                .string()
                .max(255),
            time: Yup
                .string()
                .max(255),
            test: Yup
                .string()
                .max(255),
            pass_fail: Yup
                .string()
                .max(255),
        }),
        onSubmit: (values, actions) => {
            searchFun(selectedDate, age, values.S_O); // Update the field names here
        }
    });

    const handleDateChange = (date: Date | null) => {
        setSelectedDate(date);
        console.log(selectedDate);
        
    };

    const handleChange = (event: SelectChangeEvent) => {
        setFilterType(event.target.value as string);
    };

    return (
        <form onSubmit={formik.handleSubmit}>

            <Grid container spacing={{ xs: 2, md: 3 }} columns={{ xs: 4, sm: 8, md: 12 }}>
            <Grid item xs={4} sm={4} md={2} >
                <TextField
                    sx={{ input: { color: 'grey' } }}
                    error={Boolean(formik.touched.project && formik.errors.project)}
                    fullWidth
                    helperText={formik.touched.project && formik.errors.project}
                    label="project"
                    margin="normal"
                    name="project"
                    onBlur={formik.handleBlur}
                    onChange={formik.handleChange}
                    type="string"
                    value={formik.values.project}
                    variant="outlined"
                />
            </Grid>
            <Grid item xs={4} sm={4} md={2} >
                <TextField
                    sx={{ input: { color: 'grey' } }}
                    error={Boolean(formik.touched.S_O && formik.errors.S_O)}
                    fullWidth
                    helperText={formik.touched.S_O && formik.errors.S_O}
                    label="S_O"
                    margin="normal"
                    name="S_O"
                    onBlur={formik.handleBlur}
                    onChange={formik.handleChange}
                    type="string"
                    value={formik.values.S_O}
                    variant="outlined"
                />
            </Grid>
            <Grid item xs={4} sm={4} md={2} >
                <TextField
                    sx={{ input: { color: 'grey' } }}
                    error={Boolean(formik.touched.date && formik.errors.date)}
                    fullWidth
                    helperText={formik.touched.date && formik.errors.date}
                    label="date"
                    margin="normal"
                    name="date"
                    onBlur={formik.handleBlur}
                    onChange={formik.handleChange}
                    type="string"
                    value={formik.values.date}
                    variant="outlined"
                />
            </Grid>
            <Grid item xs={4} sm={4} md={2} >
                <TextField
                    sx={{ input: { color: 'grey' } }}
                    error={Boolean(formik.touched.time && formik.errors.time)}
                    fullWidth
                    helperText={formik.touched.time && formik.errors.time}
                    label="time"
                    margin="normal"
                    name="time"
                    onBlur={formik.handleBlur}
                    onChange={formik.handleChange}
                    type="string"
                    value={formik.values.time}
                    variant="outlined"
                />
            </Grid>
            <Grid item xs={4} sm={4} md={2} >
                <TextField
                    sx={{ input: { color: 'grey' } }}
                    error={Boolean(formik.touched.test && formik.errors.test)}
                    fullWidth
                    helperText={formik.touched.test && formik.errors.test}
                    label="test"
                    margin="normal"
                    name="test"
                    onBlur={formik.handleBlur}
                    onChange={formik.handleChange}
                    type="string"
                    value={formik.values.test}
                    variant="outlined"
                />
            </Grid>
            <Grid item xs={4} sm={4} md={2} >
                <TextField
                    sx={{ input: { color: 'grey' } }}
                    error={Boolean(formik.touched.pass_fail && formik.errors.pass_fail)}
                    fullWidth
                    helperText={formik.touched.pass_fail && formik.errors.pass_fail}
                    label="pass_fail"
                    margin="normal"
                    name="pass_fail"
                    onBlur={formik.handleBlur}
                    onChange={formik.handleChange}
                    type="string"
                    value={formik.values.pass_fail}
                    variant="outlined"
                />
            </Grid>
            </Grid>
        </form>
    )
}