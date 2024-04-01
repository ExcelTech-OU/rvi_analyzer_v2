import React, { useState, useEffect } from "react";
import {
  Button,
  Dialog,
  Box,
  Chip,
  Grid,
  Card,
  CardContent,
  Typography,
} from "@mui/material";
import { DataGrid, GridToolbar, GridColDef } from "@mui/x-data-grid";
import { collection, getDocs } from "firebase/firestore";
import TableSearchForm from "../components/table_search_form";
import { db } from "./firebase_config";
import BasicDateRangePicker from "./date_range_picker";
import BasicSelect from "./filter";





interface Row {
  id: string;
  CI: number;
  CV: number;
  DI: number;
  DV: number;
  IV: number;
  UID: string;
  LED_status: string;
  time: string;
  date: string;
  DV_status: string;
  IV_status: string;
}

interface YourDocumentData {
  time: {
    seconds: number;
    nanoseconds: number;
  };
  id: string;
  CI: number;
  CV: number;
  DI: number;
  DV: number;
  IV: number;
  UID: string;
  LED_status: string;
  DV_status: string;
  IV_status: string;
}

interface BasicSelectProps {
  label: string;
  onSelectChange: (value: string) => void;
}

interface DatasetTableProps {
  collection1: string;
  collection2: string;
  hours: number;
  minutes: number;
}

const BatteryTest: React.FC<DatasetTableProps> = ({
  collection1,
  collection2,
  hours,
  minutes,
}) => {
  const [rows, setRows] = useState<Row[]>([]);
  const [uniqueRows, setUniqueRows] = useState<Row[]>([]);
  const [filteredRows, setFilteredRows] = useState<Row[]>([]);
  const [editOpen, setEditOpen] = useState(false);
  const [selectedColumn, setSelectedColumn] = useState("");
  const [date, setDate] = React.useState<Date | null>(null);
  const [filterType, setFilterType] = React.useState("CREATED_BY");
  const [filterValue, setFilterValue] = React.useState("");
  const [pageCount, setPageCount] = React.useState(1);
  const [page, setPage] = React.useState(1);

  /////////////////////////////////
  const [activeCard, setActiveCard] = useState<string | null>('All');


  /////////////////////////////////

  const database1 = collection(db, collection1);
  const database2 = collection(db, collection2);

  const getData = async (): Promise<void> => {
    const data1 = await getDocs(database1);
    const updatedRows1 = data1.docs.map((doc) => {
      const docData = doc.data() as YourDocumentData;
      const timeInMilliseconds1 =
      docData.time.seconds * 1000 + docData.time.nanoseconds / 1e6;
    const adjustedTime1 = new Date(timeInMilliseconds1);
    adjustedTime1.setHours(adjustedTime1.getHours() - hours);
    adjustedTime1.setMinutes(adjustedTime1.getMinutes() - minutes);
  
    const dateValue1 = adjustedTime1.toLocaleDateString();
    const timeValue1 = adjustedTime1.toLocaleTimeString();
      
      
      return {
        ...docData,
        id: doc.id,
        time: timeValue1,
        date: dateValue1,
      };
    });

  // console.log(updatedRows1);

    const data2 = await getDocs(database2);
    const updatedRows2 = data2.docs.map((doc) => {
      const docData = doc.data() as YourDocumentData;
      const timeInMilliseconds2 =
      docData.time.seconds * 1000 + docData.time.nanoseconds / 1e6;
    const adjustedTime2 = new Date(timeInMilliseconds2);
    adjustedTime2.setHours(adjustedTime2.getHours() - hours); 
    adjustedTime2.setMinutes(adjustedTime2.getMinutes() - minutes); 
  
    const dateValue2 = adjustedTime2.toLocaleDateString();
    const timeValue2 = adjustedTime2.toLocaleTimeString();

      return {
        ...docData,
        id: doc.id,
        time: timeValue2,
        date: dateValue2,
      };
    });

    const combinedRows = [...updatedRows1, ...updatedRows2];

    const uniqueUIDs = new Set<string>();

    const uniqueRows = combinedRows.filter((row) => {
      if (row.LED_status === "Pass" && row.DV_status === "Pass" && row.IV_status === "Pass") {
        if (!uniqueUIDs.has(row.UID)) {
          uniqueUIDs.add(row.UID);
          return true;
        }
        return false;
      } else {
        return true;
      }
    });


    const sortedRows = combinedRows.sort((a, b) => b.id.localeCompare(a.id));
    // const sortedRows = combinedRows.sort((a, b) => new Date(a.time).getTime() - new Date(b.time).getTime());
    setRows(sortedRows);
    setFilteredRows(sortedRows);
    setUniqueRows(uniqueRows);
  };

  useEffect(() => {
    getData();
  }, []);

  const handleDelete = (params: any): void => {
    const { id } = params.row;
    // console.log(`Deleting row with ID: ${id}`);

    // Send DELETE request to the server
    // axios.delete(`http://localhost:4000/pcb_test/delete/${id}`)
    //   .then(response => {
    //     if (!response.ok) {
    //       throw new Error(`HTTP error! Status: ${response.status}`);
    //     }
    //     console.log('Delete request successful');
    //     // Add any additional logic you need after a successful deletion
    //   })
    //   .catch(error => {
    //     console.error('Error during delete request:', error);
    //     // Handle error as needed
    //   });
  };

  const setSearchParams = (
    date: Date | null,
    filterType: string,
    filterValue: string
  ) => {
    setFilterType(filterType);
    setFilterValue(filterValue);
    setDate(date);
    setPage(1);
  };

  const handleFilter = (): void => {
    const searchTerm = filterValue.toLowerCase();
    const filteredData = rows.filter((row) => {
      const isDateInRange =
        (!ledSequence || ledSequence.includes(row.LED_status)) &&
        (!dvStatus || dvStatus.includes(row.DV_status)) &&
        (!ivStatus || ivStatus.includes(row.IV_status)) &&
        (!startingDate || new Date(row.date) >= new Date(startingDate)) &&
        (!finishingDate || new Date(row.date) <= new Date(finishingDate));

      return !searchTerm && isDateInRange;
    });
    // console.log(filteredData);

    setFilteredRows(filteredData);
  };

  const handleColumnChange = (
    event: React.ChangeEvent<{ value: unknown }>
  ): void => {
    setSelectedColumn(event.target.value as string);
  };
  

  const columns : GridColDef[] = [
    {
      field: "id",
      headerName: "id",
      width: 80,
      headerClassName: "customDataGridHeader",
      
    },
    {
      field: "UID",
      headerName: "UID",
      width: 120,
      headerClassName: "customDataGridHeader",
      description: "USER_ID",
    },
    {
      field: "IV",
      headerName: "IV",
      width: 100,
      headerClassName: "customDataGridHeader",
      description: "IDEAL_VOLTAGE",
    },
    {
      field: "CI",
      headerName: "CI",
      width: 100,
      headerClassName: "customDataGridHeader",
      description: "CHARGING_CURRENT",
    },
    {
      field: "CV",
      headerName: "CV",
      width: 100,
      headerClassName: "customDataGridHeader",
      description: "CHARGING_VOLTAGE",
    },
    {
      field: "DI",
      headerName: "DI",
      width: 100,
      headerClassName: "customDataGridHeader",
      description: "DISCHARGING_CURRENT",
    },
    {
      field: "DV",
      headerName: "DV",
      width: 100,
      headerClassName: "customDataGridHeader",
      description: "DISCHARGING_VOLTAGE",
    },
    {
      field: "LED_status",
      headerName: "LED_sequence",
      width: 120,
      headerClassName: "customDataGridHeader",
    },
    {
      field: "DV_status",
      headerName: "DV_status",
      width: 100,
      headerClassName: "customDataGridHeader",
    },
    {
      field: "IV_status",
      headerName: "IV_status",
      width: 100,
      headerClassName: "customDataGridHeader",
    },
    {
      field: "date",
      headerName: "date",
      width: 100,
      headerClassName: "customDataGridHeader",
    },
    {
      field: "time",
      headerName: "time",
      width: 120,
      headerClassName: "customDataGridHeader",
    },
    // {
    //   field: 'actions',
    //   headerName: 'Actions',
    //   flex: 1,
    //   type: 'actions',
    //   renderCell: (params: any) => (
    //     <>
    //       <Button variant="outlined" color="primary" size="small">
    //         Edit
    //       </Button>
    //       <Button
    //         onClick={() => handleDelete(params)}
    //         variant="outlined"
    //         color="secondary"
    //         size="small"
    //       >
    //         Delete
    //       </Button>
    //     </>
    //   ),
    // },
  ];



  const [ledSequence, setLedSequence] = useState<string>('');
  const [dvStatus, setDvStatus] = useState<string>('');
  const [ivStatus, setIvStatus] = useState<string>('');

  const handleChange = (label: string, selectedValue: string) => {
    switch (label) {
      case 'LED Sequence':
        setLedSequence(selectedValue);
        break;
      case 'DV Status':
        setDvStatus(selectedValue);
        break;
      case 'IV status':
        setIvStatus(selectedValue);
        break;
      default:
        // Handle default case or do nothing
    }
  };
  
  


  ///////////////////////////
const handlePrintPassData = (data: Row[], cardType: string) => {

  setActiveCard(cardType);

  setFilteredRows(data);

};
  ///////////////////////////

  const [startingDate, setStartingDate] = useState(null);
  const [finishingDate, setFinishingDate] = useState(null);

  const handleStartingDateChange = (date: React.SetStateAction<null>) => {
    setStartingDate(date);
    // console.log("startingDate);
  };

  const handleFinishingDateChange = (date: React.SetStateAction<null>) => {
    setFinishingDate(date);
    // console.log(finishingDate);
  };

  // const passData = uniqueRows.filter((item) => item.LED_status === "Pass");
  // const failData = rows.filter((item) => item.LED_status === "Fail");
  
  const passData = uniqueRows.filter((item) => item.LED_status === "Pass" && item.DV_status === "Pass" && item.IV_status === "Pass");
  const failData = rows.filter((item) => item.LED_status === "Fail" || item.DV_status === "Fail" || item.IV_status === "Fail");


  console.log(passData.length);
  console.log(failData.length);

  return (
    <div>
      <Grid
        container
        spacing={4}
        justifyContent="center"
        style={{ padding: "20px" }}
      >
        <Grid item xs={12} sm={6} md={4} lg={4}>
          <Card
            onClick={() => handlePrintPassData(rows, 'All')}
            sx={{
              backgroundColor: activeCard === 'All' ? '#d3d3d3' : '#FFFFFF',
              boxShadow: "1px 1px 10px 10px #e8e8e8",
              display: "flex",
              flexDirection: "column",
              alignItems: "center",
              height: "100%",
            }}
          >
            <CardContent>
              <Typography variant="h6" component="div">
                Number of Tests: {rows.length}
              </Typography>
            </CardContent>
          </Card>
        </Grid>
        <Grid item xs={12} sm={6} md={4} lg={4}>
            <Card
              onClick={() => handlePrintPassData(passData, 'Pass')} 
              sx={{
                backgroundColor: activeCard === 'Pass' ? '#d3d3d3' : '#FFFFFF',
                boxShadow: "1px 1px 10px 10px #e8e8e8",
                display: "flex",
                flexDirection: "column",
                alignItems: "center",
                height: "100%",
              }}
            >
              <CardContent>
                <Typography variant="h6" component="div" >
                  Number of Pass Tests: {passData.length}
                </Typography>
              </CardContent>
            </Card>
        </Grid>
        <Grid item xs={12} sm={6} md={4} lg={4}>
            <Card
              onClick={() => handlePrintPassData(failData, 'Fail')} 
              sx={{
                backgroundColor: activeCard === 'Fail' ? '#d3d3d3' : '#FFFFFF',
                boxShadow: "1px 1px 10px 10px #e8e8e8",
                display: "flex",
                flexDirection: "column",
                alignItems: "center",
                height: "100%",
              }}
            >
            <CardContent>
              <Typography variant="h6" component="div">
                Number of Fail Tests: {failData.length}
              </Typography>
            </CardContent>
          </Card>
        </Grid>
      </Grid>
      <Card
        sx={{
          maxWidth: 1600,
          backgroundColor: "#FFFFFF",
          boxShadow: "1px 1px 10px 10px #e8e8e8",
          display: "flex",
          flexDirection: "column",
          alignItems: "center",
          justifyContent: "flex-start",
          padding: "20px",
        }}
      >
        <style>{`
        .customDataGridHeader {
          background-color: #9e9e9e;
          color: white;
        }
      `}</style>
        <div
          style={{
            width: "100%",
            display: "flex",
            justifyContent: "flex-end",
            marginBottom: "20px",
          }}
        >
          <div style={{ marginRight: "10px", width: "150px" }}>
            <BasicSelect label="LED Sequence" onSelectChange={(value) => handleChange('LED Sequence', value)} />
          </div>
          <div style={{ marginRight: "10px" }}>
            <BasicSelect label="DV Status" onSelectChange={(value) => handleChange('DV Status', value)} />
          </div>
          <div style={{ marginRight: "10px" }}>
            <BasicSelect label="IV status" onSelectChange={(value) => handleChange('IV status', value)} />
          </div>
          <div style={{ marginRight: "10px"}}>
            <BasicDateRangePicker
              label="Starting Date"
              onChange={handleStartingDateChange}
            />
          </div>

          <div style={{ marginRight: "10px"}}>
            <BasicDateRangePicker
              label="Finishing Date"
              onChange={handleFinishingDateChange}
            />
          </div>

          <Button
            onClick={handleFilter}
            variant="contained"
            className="customDataGridHeader"
          >
            Filter
          </Button>
        </div>

        <div
          style={{
            height: 600,
            width: "95%",
            display: "flex",
            alignItems: "center",
            justifyContent: "center",
          }}
        >
          <DataGrid sx={{ width: "100%", overflow: "hidden" }}
            rows={filteredRows.length > 0 ? filteredRows : []}
            columns={columns}
            getRowId={(row) => row.id}
            pageSize={10}
            rowsPerPageOptions={[5, 10, 20]}
            components={{
              Toolbar: GridToolbar,
            }}
          />
        </div>
      </Card>

      {/* Edit Dialog */}
      <Dialog open={editOpen} onClose={() => setEditOpen(false)}>
        {/* ... rest of the code */}
      </Dialog>
    </div>
  );
};

export default BatteryTest;
