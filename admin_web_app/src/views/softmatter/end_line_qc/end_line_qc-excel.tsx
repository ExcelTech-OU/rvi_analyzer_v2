import * as XLSX from "xlsx";
import { List } from "reselect/es/types";
// import { FullGarment } from '../../../services/softmatter_service';
import { format, parseISO } from "date-fns";

import { ModeSeven } from "../../../services/gt_service";

///////////////////////
// interface FullGarment {
//     _id: string
//     dateCode: string
//     idleCurrent: string
//     settingsIdleCurrentMin: string
//     settingsIdleCurrentMax: string
//     idleCurrentStatus: string
//     flCurrent: string
//     settingsFLCurrentMin: string
//     settingsFLCurrentMax: string
//     flCurrentStatus: string
//     voltage: string
//     noiseIdle: string
//     settingsNoiseMin: string
//     settingsNoiseMax: string
//     noiseStatusIdle: string
//     noiseFL: string
//     noiseStatusFL: string
//     createdBy: string
//     soNumber: string
//     productionOrder: string
//     qrCode: string
//     createdDateTime: string
// }
///////////////////////

export function handleGenerateExcelEndLineQc(singleMotors: List<ModeSeven>) {
  // Create a new workbook
  const workbook = XLSX.utils.book_new();

  // Create a new worksheet 'NOISE_IDLE', 'SETTINGS_NOISE_MIN', 'SETTINGS_NOISE_MAX', 'NOISE_STATUS_IDLE', 'NOISE_FL', 'NOISE_STATUS_FL'
  const worksheet = XLSX.utils.aoa_to_sheet([
    [
      "CUSTOMER_ID",
      "MAC_ADDRESS",
      "PRODUCTION",
      "OPERATOR_ID",
      "VOLTAGE",
      "CURRENT",
      "RESISTANCE",
      "LED_SEQUENCE",
      "DATE",
      "TIME",
    ],
    ...singleMotors.map((data) => [
      data.defaultConfigurations.customerName,
      data.result.reading.macAddress,
      data.result.reading.productionOrder,
      data.defaultConfigurations.operatorId,
      data.result.reading.voltage,
      data.result.reading.current,
      data.result.reading.resistance,
      data.result.reading.result,
      data.createdDateTime.split("T")[0],
      data.createdDateTime.split("T")[1],

      // data.noiseIdle,
      // data.settingsNoiseMin,
      // data.settingsNoiseMax,
      // data.noiseStatusIdle,
      // data.noiseFL,
      // data.noiseStatusFL,

      // format(parseISO(data.createdDateTime), 'yyyy-MM-dd hh:mm:ss a')
    ]),
  ]);

  // Add the worksheet to the workbook
  XLSX.utils.book_append_sheet(workbook, worksheet, "Sheet1");

  // Save the workbook as an Excel file
  XLSX.writeFile(workbook, "end_line_qc_" + new Date().toISOString() + ".xlsx");
}
