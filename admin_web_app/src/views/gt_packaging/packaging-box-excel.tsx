import * as XLSX from "xlsx";
import { List } from "reselect/es/types";
import { format, parseISO } from "date-fns";
import React, { useEffect } from "react";

export function handleGenerateExcelPackageBox(datas: any[]) {
  const workbook = XLSX.utils.book_new();

  // Create a new worksheet 'NOISE_IDLE', 'SETTINGS_NOISE_MIN', 'SETTINGS_NOISE_MAX', 'NOISE_STATUS_IDLE', 'NOISE_FL', 'NOISE_STATUS_FL'
  const worksheet = XLSX.utils.aoa_to_sheet([
    [
      "Retail Box QR",
      "Battery01 Serial",
      "Battery02 Serial",
      "DeviceL Mac",
      "DeviceR Mac",
      "Packed Date",
      "Packed By",
    ],
    ...datas.map((data) => [
      data.retailBox_QR,
      data.battery01_Serial,
      data.battery02_Serial,
      data.deviceL_Mac,
      data.deviceR_Mac,
      data.packed_Date,
      data.packed_By,
    ]),
  ]);

  // Add the worksheet to the workbook
  XLSX.utils.book_append_sheet(workbook, worksheet, "Sheet1");

  // Save the workbook as an Excel file
  XLSX.writeFile(workbook, "Retail Box " + new Date().toISOString() + ".xlsx");
}
