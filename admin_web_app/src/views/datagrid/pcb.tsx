import React, { useState, useEffect } from 'react';
import axios from 'axios';
import {
  Button,
  Dialog,
  Box,
  Card,
  Grid,
} from '@mui/material';
import { DataGrid, GridToolbar } from '@mui/x-data-grid';
import { collection, getDocs } from 'firebase/firestore';
import TableSearchForm from '../components/table_search_form';
import { db } from './firebase_config';
import BasicDateRangePicker from './date_range_picker';

interface Row {
  id: string;
  LED_C: string;
  HNLV: number;
  HLV: number;
  MAC_adress: string;
  time: string;
  date: string;
  LED_V: number;
  HLC: number;
}

interface YourDocumentData {
  time: {
    seconds: number;
    nanoseconds: number;
  };
  HNLV: number;
  HLV: number;
  LED_V: number;
  HLC: number;
  id: string;
  LED_C: string;
  MAC_adress: string;
}

interface DatasetTableProps {
  collection1: string;
  collection2: string;
}

const DatasetTable: React.FC<DatasetTableProps> = ({ collection1, collection2 }) => {
  const [rows, setRows] = useState<Row[]>([]);
  const [filteredRows, setFilteredRows] = useState<Row[]>([]);
  const [editOpen, setEditOpen] = useState(false);
  const [selectedColumn, setSelectedColumn] = useState('');
  const [date, setDate] = React.useState<Date | null>(null);
  const [filterType, setFilterType] = React.useState('CREATED_BY');
  const [filterValue, setFilterValue] = React.useState('');
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
        date: dateValue
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
        date: dateValue
      };
    });

    const combinedRows = [...updatedRows1, ...updatedRows2];

    const uniqueMACs = new Set<string>();

    const uniqueRows = combinedRows.filter((row) => {
      if (!uniqueMACs.has(row.MAC_adress)) {
        uniqueMACs.add(row.MAC_adress);
        return true;
      }
      return false;
    });


    const sortedRows = uniqueRows.sort((a, b) => new Date(a.time).getTime() - new Date(b.time).getTime());
    setRows(sortedRows);
    setFilteredRows(sortedRows);
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

  const setSearchParams = (date: Date | null, filterType: string, filterValue: string) => {
    setFilterType(filterType);
    setFilterValue(filterValue);
    setDate(date);
    setPage(1);
  };


  
  const handleFilter = (): void => {
    const searchTerm = filterValue.toLowerCase();
    const filteredData = rows.filter((row) => {
      const isDateInRange =
        (!startingDate || new Date(row.date) >= new Date(startingDate)) &&
        (!finishingDate || new Date(row.date) <= new Date(finishingDate));

        
      return (
        (!searchTerm ) && isDateInRange
      );
    });
    console.log(filteredData);
    
    setFilteredRows(filteredData);
  };
  

  const handleColumnChange = (event: React.ChangeEvent<{ value: unknown }>): void => {
    setSelectedColumn(event.target.value as string);
  };

  const columns = [
    { field: 'id', headerName: 'id', flex:1, headerClassName: 'customDataGridHeader' },
    { field: 'LED_C', headerName: 'LED_C', flex:1, headerClassName: 'customDataGridHeader' },
    { field: 'HNLV', headerName: 'HNLV', flex:1, headerClassName: 'customDataGridHeader' },
    { field: 'HLV', headerName: 'HLV', flex:1, headerClassName: 'customDataGridHeader' },
    { field: 'MAC_adress', headerName: 'MAC_adress', flex:1, headerClassName: 'customDataGridHeader' },
    { field: 'date', headerName: 'date', flex:1, headerClassName: 'customDataGridHeader' },
    { field: 'time', headerName: 'time', flex:1, headerClassName: 'customDataGridHeader' },
    { field: 'LED_V', headerName: 'LED_V', flex:1, headerClassName: 'customDataGridHeader' },
    { field: 'HLC', headerName: 'HLC', flex:1, headerClassName: 'customDataGridHeader' },
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

  return (
    <div>
      <Card sx={{ maxWidth: 1600, backgroundColor: "#FFFFFF", boxShadow: "1px 1px 10px 10px #e8e8e8", display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'flex-start', padding: '20px' }}>
  <style>{`
    .customDataGridHeader {
      background-color: #9e9e9e;
      color: white;
    }
  `}</style>

  <div style={{ width: '100%', display: 'flex', justifyContent: 'right', marginBottom: '20px' }}>
    <div style={{ marginRight: '10px' }}>
      <BasicDateRangePicker label="Starting Date" onChange={handleStartingDateChange} />
    </div>

    <div style={{ marginRight: '10px' }}>
      <BasicDateRangePicker label="Finishing Date" onChange={handleFinishingDateChange} />
    </div>

    <Button onClick={handleFilter} variant="contained" className='customDataGridHeader'>
      Filter
    </Button>
  </div>
  <div style={{ height: 600, width: '95%', display: 'flex', alignItems: 'center', justifyContent: 'flex-end' }}>
    <DataGrid
      rows={filteredRows.length > 0 ? filteredRows : []} 
      columns={columns}
      getRowId={(row) => row.id}
      pageSize={10}
      rowsPerPageOptions={[5, 10, 20]}
      components={{
        Toolbar: GridToolbar
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

export default DatasetTable;
