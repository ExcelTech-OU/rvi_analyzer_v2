import { Button } from '@mui/material';
import * as XLSX from 'xlsx';
import { ModeFiveDto } from '../../services/sessions_service';



export function handleGenerateExcelModeFive(session: ModeFiveDto) {
    // Create a new workbook
    const workbook = XLSX.utils.book_new();

    // Create a new worksheet
    const worksheet = XLSX.utils.aoa_to_sheet([
        ['TIME (Sec)', 'TEMPERATURE', 'CURRENT', 'VOLTAGE'],
        ...session.results.readings.map((reading, index) => [
            index + 1,
            reading.temperature,
            reading.current,
            reading.voltage
        ]),
    ]);



    // Add the worksheet to the workbook
    XLSX.utils.book_append_sheet(workbook, worksheet, 'Sheet1');

    // Save the workbook as an Excel file
    XLSX.writeFile(workbook, 'mode_five_' + session.defaultConfigurations.sessionId + '.xlsx');
};