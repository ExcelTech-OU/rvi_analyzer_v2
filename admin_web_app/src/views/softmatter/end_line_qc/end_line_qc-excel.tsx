import * as XLSX from 'xlsx';
import { List } from 'reselect/es/types'
// import { FullGarment } from '../../../services/softmatter_service';
import { format, parseISO } from 'date-fns';

///////////////////////
interface FullGarment {
    _id: string
    dateCode: string
    idleCurrent: string
    settingsIdleCurrentMin: string
    settingsIdleCurrentMax: string
    idleCurrentStatus: string
    flCurrent: string
    settingsFLCurrentMin: string
    settingsFLCurrentMax: string
    flCurrentStatus: string
    voltage: string
    noiseIdle: string
    settingsNoiseMin: string
    settingsNoiseMax: string
    noiseStatusIdle: string
    noiseFL: string
    noiseStatusFL: string
    createdBy: string
    soNumber: string
    productionOrder: string
    qrCode: string
    createdDateTime: string
}
///////////////////////

export function handleGenerateExcelEndLineQc(singleMotors: List<FullGarment>) {


    // Create a new workbook
    const workbook = XLSX.utils.book_new();

    // Create a new worksheet 'NOISE_IDLE', 'SETTINGS_NOISE_MIN', 'SETTINGS_NOISE_MAX', 'NOISE_STATUS_IDLE', 'NOISE_FL', 'NOISE_STATUS_FL'
    const worksheet = XLSX.utils.aoa_to_sheet([
        ['DATE_CODE', 'IDLE_CURRENT', 'SETTINGS_IDLE_CURRENT_MIN', 'SETTINGS_IDLE_CURRENT_MAX', 'IDLE_CURRENT_STATUS', 'FL_CURRENT', 'SETTINGS_FL_CURRENT_MIN', 'SETTINGS_FL_CURRENT_MAX', "FL_CURRENT_STATUS", 'VOLTAGE', 'SO_NUMBER', 'PRODUCTION_ORDER', 'QR_CODE', 'CREATED_DATE_TIME'],
        ...singleMotors.map((data) => [
            data.dateCode,
            data.idleCurrent,
            data.settingsIdleCurrentMin,
            data.settingsIdleCurrentMax,
            data.idleCurrentStatus,
            data.flCurrent,
            data.settingsFLCurrentMin,
            data.settingsFLCurrentMax,
            data.flCurrentStatus,
            data.voltage,
            data.soNumber,
            data.productionOrder,
            data.qrCode,
            // data.noiseIdle,
            // data.settingsNoiseMin,
            // data.settingsNoiseMax,
            // data.noiseStatusIdle,
            // data.noiseFL,
            // data.noiseStatusFL,
            format(parseISO(data.createdDateTime), 'yyyy-MM-dd hh:mm:ss a')
        ]),
    ]);



    // Add the worksheet to the workbook
    XLSX.utils.book_append_sheet(workbook, worksheet, 'Sheet1');

    // Save the workbook as an Excel file
    XLSX.writeFile(workbook, 'end_line_qc_' + new Date().toISOString() + '.xlsx');
}