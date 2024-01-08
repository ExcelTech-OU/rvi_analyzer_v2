import { Button } from '@mui/material';
import * as XLSX from 'xlsx';
import { ModeThreeDto } from '../../services/sessions_service';



export function handleGenerateExcelModeThree(session: ModeThreeDto) {
    // Create a new workbook
    const workbook = XLSX.utils.book_new();

    // Create a new worksheet
    const worksheet = XLSX.utils.aoa_to_sheet([
        ['TIME (Sec)', 'TEMPERATURE', 'CURRENT', 'VOLTAGE'],
        ...session.results.readings.map((reading, index) => [
            parseFloat(session.sessionConfigurationModeThree.chargeInTime) * (index + 1),
            reading.temperature,
            reading.current,
            reading.voltage,
        ]),
    ]);



    // Add the worksheet to the workbook
    XLSX.utils.book_append_sheet(workbook, worksheet, 'Sheet1');

    // Save the workbook as an Excel file
    XLSX.writeFile(workbook, 'mode_three_' + session.defaultConfigurations.sessionId + '.xlsx');
};