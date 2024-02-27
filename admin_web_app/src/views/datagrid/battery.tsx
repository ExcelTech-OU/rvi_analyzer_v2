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
import { DataGrid, GridToolbar } from "@mui/x-data-grid";
import { collection, getDocs } from "firebase/firestore";
import TableSearchForm from "../components/table_search_form";
import { db } from "./firebase_config";
import BasicDateRangePicker from "./date_range_picker";

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
}

interface DatasetTableProps {
  collection1: string;
  collection2: string;
}

const BatteryTest: React.FC<DatasetTableProps> = ({
  collection1,
  collection2,
}) => {
  const [rows, setRows] = useState<Row[]>([]);
  const [filteredRows, setFilteredRows] = useState<Row[]>([]);
  const [editOpen, setEditOpen] = useState(false);
  const [selectedColumn, setSelectedColumn] = useState("");
  const [date, setDate] = React.useState<Date | null>(null);
  const [filterType, setFilterType] = React.useState("CREATED_BY");
  const [filterValue, setFilterValue] = React.useState("");
  const [pageCount, setPageCount] = React.useState(1);
  const [page, setPage] = React.useState(1);

  const database1 = collection(db, collection1);
  const database2 = collection(db, collection2);

  const getData = async (): Promise<void> => {
    const data1 = await getDocs(database1);
    const updatedRows1 = data1.docs.map((doc) => {
      const docData = doc.data() as YourDocumentData;
      const timeInMilliseconds =
        docData.time.seconds * 1000 + docData.time.nanoseconds / 1e6;
      const dateValue = new Date(timeInMilliseconds).toLocaleDateString();
      const timeValue = new Date(timeInMilliseconds).toLocaleTimeString();

      return {
        ...docData,
        id: doc.id,
        time: timeValue,
        date: dateValue,
      };
    });

    const data2 = await getDocs(database2);
    const updatedRows2 = data2.docs.map((doc) => {
      const docData = doc.data() as YourDocumentData;
      const timeInMilliseconds =
        docData.time.seconds * 1000 + docData.time.nanoseconds / 1e6;
      const dateValue = new Date(timeInMilliseconds).toLocaleDateString();
      const timeValue = new Date(timeInMilliseconds).toLocaleTimeString();

      return {
        ...docData,
        id: doc.id,
        time: timeValue,
        date: dateValue,
      };
    });

    const combinedRows = [...updatedRows1, ...updatedRows2];

    const uniqueUIDs = new Set<string>();

    const uniqueRows = combinedRows.filter((row) => {
      if (row.LED_status == "Pass") {
        if (!uniqueUIDs.has(row.UID)) {
          uniqueUIDs.add(row.UID);
          return true;
        }
        return false;
      } else {
        return true;
      }
    });

    const sortedRows = uniqueRows.sort(
      (a, b) => new Date(a.time).getTime() - new Date(b.time).getTime()
    );
    setRows(sortedRows);
  };

  useEffect(() => {
    getData();
  }, []);

  const handleDelete = (params: any): void => {
    const { id } = params.row;
    console.log(`Deleting row with ID: ${id}`);

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
        (!startingDate || new Date(row.time) >= new Date(startingDate)) &&
        (!finishingDate || new Date(row.time) <= new Date(finishingDate));

      return (
        (!searchTerm || // Check for other conditions if needed
          Object.values(row).some((value, index) => {
            if (
              (typeof value === "string" || typeof value === "number") &&
              columns[index].field === selectedColumn
            ) {
              const stringValue = String(value).toLowerCase();
              return stringValue.includes(searchTerm);
            }
            return false;
          })) &&
        isDateInRange
      );
    });

    setFilteredRows(filteredData);
  };

  const handleColumnChange = (
    event: React.ChangeEvent<{ value: unknown }>
  ): void => {
    setSelectedColumn(event.target.value as string);
  };

  const columns = [
    {
      field: "id",
      headerName: "id",
      flex: 1,
      headerClassName: "customDataGridHeader",
    },
    {
      field: "CI",
      headerName: "CI",
      flex: 1,
      headerClassName: "customDataGridHeader",
    },
    {
      field: "CV",
      headerName: "CV",
      flex: 1,
      headerClassName: "customDataGridHeader",
    },
    {
      field: "DI",
      headerName: "DI",
      flex: 1,
      headerClassName: "customDataGridHeader",
    },
    {
      field: "UID",
      headerName: "UID",
      flex: 1,
      headerClassName: "customDataGridHeader",
    },
    {
      field: "LED_status",
      headerName: "LED_status",
      flex: 1,
      headerClassName: "customDataGridHeader",
    },
    {
      field: "date",
      headerName: "date",
      flex: 1,
      headerClassName: "customDataGridHeader",
    },
    {
      field: "time",
      headerName: "time",
      flex: 1,
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

  const [startingDate, setStartingDate] = useState(null);
  const [finishingDate, setFinishingDate] = useState(null);

  const handleStartingDateChange = (date: React.SetStateAction<null>) => {
    setStartingDate(date);
    console.log(startingDate);
  };

  const handleFinishingDateChange = (date: React.SetStateAction<null>) => {
    setFinishingDate(date);
    console.log(finishingDate);
  };

  const passData = rows.filter((item) => item.LED_status === "Pass");
  const failData = rows.filter((item) => item.LED_status === "Fail");

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
        <Grid item xs={12} sm={6} md={4} lg={3}>
          <Card
            sx={{
              backgroundColor: "#FFFFFF",
              boxShadow: "1px 1px 10px 10px #e8e8e8",
              display: "flex",
              flexDirection: "column",
              alignItems: "center",
              height: "100%",
            }}
          >
            <CardContent>
              <Typography variant="h6" component="div">
                Number of Data: {rows.length}
              </Typography>
            </CardContent>
          </Card>
        </Grid>
        <Grid item xs={12} sm={6} md={4} lg={3}>
          <Card
            sx={{
              backgroundColor: "#FFFFFF",
              boxShadow: "1px 1px 10px 10px #e8e8e8",
              display: "flex",
              flexDirection: "column",
              alignItems: "center",
              height: "100%",
            }}
          >
            <CardContent>
              <Typography variant="h6" component="div">
                Number of Pass Data: {passData.length}
              </Typography>
            </CardContent>
          </Card>
        </Grid>
        <Grid item xs={12} sm={6} md={4} lg={3}>
          <Card
            sx={{
              backgroundColor: "#FFFFFF",
              boxShadow: "1px 1px 10px 10px #e8e8e8",
              display: "flex",
              flexDirection: "column",
              alignItems: "center",
              height: "100%",
            }}
          >
            <CardContent>
              <Typography variant="h6" component="div">
                Number of Fail Data: {failData.length}
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
            height: 600,
            width: "95%",
            display: "flex",
            alignItems: "center",
          }}
        >
          <DataGrid
            rows={filteredRows.length > 0 ? filteredRows : rows}
            columns={columns}
            getRowId={(row) => row.id}
            pageSize={10}
            rowsPerPageOptions={[5, 10, 20]}
            components={{
              Toolbar: (props) => (
                <div
                  style={{
                    display: "flex",
                    flexDirection: "row",
                    alignItems: "center",
                    padding: "8px",
                    marginRight: "10px",
                  }}
                >
                  <GridToolbar {...props} />
                  <div style={{ marginRight: "10px" }}>
                    {" "}
                    {/* Adjust the margin as needed */}
                    <BasicDateRangePicker
                      label="Starting Date"
                      onChange={handleStartingDateChange}
                    />
                  </div>

                  <div style={{ marginRight: "10px" }}>
                    {" "}
                    {/* Adjust the margin as needed */}
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
              ),
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
