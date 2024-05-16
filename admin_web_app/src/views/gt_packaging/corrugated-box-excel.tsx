import * as XLSX from "xlsx";
import { List } from "reselect/es/types";
// import { FullGarment } from '../../../services/softmatter_service';
import { format, parseISO } from "date-fns";
import React, { useEffect } from "react";

export function handleGenerateExcelCorrugatedBox(datas: any[]) {

  const workbook = XLSX.utils.book_new();


  const worksheet = XLSX.utils.aoa_to_sheet([
    ["Corrugated Box ID","Packaging Box Qr-1", "Packaging Box Qr-2","Packaging Box Qr-3","Packaging Box Qr-4","Packaging Box Qr-5","Packaging Box Qr-6","Packaging Box Qr-7","Packaging Box Qr-8","Packaging Box Qr-9","Packaging Box Qr-10", "Where", "Shipping ID", "Customer PO","Packed Data","Packed By"],
    ...datas.map((data) => [
      data.corBox_QR,
      data.retailQR_1,
      data.retailQR_2,
      data.retailQR_3,
      data.retailQR_4,
      data.retailQR_5,
      data.retailQR_6,
      data.retailQR_7,
      data.retailQR_8,
      data.retailQR_9,
      data.retailQR_10,
      data.destination,
      data.shipping_Id,
      data.customer_PO,
      data.packed_date,
      data.packed_by
      

      
    ]),
  ]);

  // Add the worksheet to the workbook
  XLSX.utils.book_append_sheet(workbook, worksheet, "Sheet1");

  // Save the workbook as an Excel file
  XLSX.writeFile(workbook, "Corrugated_box_" + new Date().toISOString() + ".xlsx");
}
