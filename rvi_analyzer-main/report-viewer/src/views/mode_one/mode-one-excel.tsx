import { Button } from '@mui/material';
import * as XLSX from 'xlsx';
import { ModeOneDto } from '../../services/sessions_service';



export function handleGenerateExcelModeOne(session: ModeOneDto) {
    // Create a new workbook
    const workbook = XLSX.utils.book_new();

    // Create a new worksheet
    const worksheet = XLSX.utils.aoa_to_sheet([
        ['TEST ID', 'TEMPERATURE', 'CURRENT', 'VOLTAGE', 'READ DATE TIME', 'RESULT'],
        ...session.results.map((reading) => [
            reading.testId,
            reading.readings[0].temperature,
            reading.readings[0].current,
            session.sessionConfigurationModeOne.voltage,
            reading.readings[0].readAt,
            reading.readings[0].result,
        ]),
    ]);



    // Add the worksheet to the workbook
    XLSX.utils.book_append_sheet(workbook, worksheet, 'Sheet1');

    // Save the workbook as an Excel file
    XLSX.writeFile(workbook, 'mode_one_' + session.defaultConfigurations.sessionId + '.xlsx');
};