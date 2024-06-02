import {
    Box,
    Button,
    Card,
    CardActionArea,
    CardContent,
    Container,
    Divider,
    Grid,
    Pagination,
    Typography,
    IconButton
  } from "@mui/material";
  import { GridColDef } from "@mui/x-data-grid";
  import GridOnIcon from "@mui/icons-material/GridOn";
  import * as React from "react";
  import Paper from "@mui/material/Paper";
  import Table from "@mui/material/Table";
  import TableBody from "@mui/material/TableBody";
  import TableCell, { tableCellClasses } from "@mui/material/TableCell";
  import TableContainer from "@mui/material/TableContainer";
  import TableHead from "@mui/material/TableHead";
  import TableRow from "@mui/material/TableRow";
  import { styled } from "@mui/material";
import { Download } from "@mui/icons-material";
import DeleteIcon from '@mui/icons-material/Delete';

import { useState, useEffect } from "react";
import { AnyObject } from "yup/lib/types";
import { List } from "reselect/es/types";

import AddIcon from "@mui/icons-material/Add";

import { ShippingDetail, useGetShippingDetailsQuery, useUpdateShippingDetailsMutation } from "../../../services/shippingDetails_service";
import { AddShippingDetailModel } from "./add-shipping-detail-list";


export const StyledTableCell = styled(TableCell)(({ theme }) => ({
    [`&.${tableCellClasses.head}`]: {
      backgroundColor: "#9e9e9e",
      color: theme.palette.common.white,
    },
    [`&.${tableCellClasses.body}`]: {
      fontSize: 14,
    },
    position: 'relative',
    '&:hover .delete-button': {
      visibility: 'visible',
    },
  }));
  
  export const StyledTableRow = styled(TableRow)(({ theme }) => ({
    "&:nth-of-type(odd)": {
      backgroundColor: theme.palette.action.hover,
    },
    // hide last border
    "&:last-child td, &:last-child th": {
      border: 0,
    },

  }));


  const DeleteButton = styled(IconButton)({
    visibility: 'hidden',
    position: 'absolute',
    top: '50%',
    right: '-20px',
    transform: 'translateY(-50%)',
  });

  const columns: GridColDef[] = [
    {
      field: "destination",
      headerName: "Destination",
      width: 150,
    },
    {
        field: "shipping_Id",
        headerName: "Shipping Id",
        width: 150,
    },
    {
      field: "customer_PO",
      headerName: "Customer PO",
      width: 150,
    },    
  ];
export default function ShippingDetailList() {
    // const [data, setData] = React.useState<any[]>([]);
    // const [isLoading, setIsLoading] = React.useState(false);
    const [selectedRows, setSelectedRows] = React.useState<number[]>([]);
    const [poList, setPOList] = useState<any>([]);
    // const paginatedModes = modesList.slice(startIndex, endIndex);
    const [shippingDetails, setShippingDetails] = useState<ShippingDetail[]>([]);
    const [destination, setDestination] = useState<ShippingDetail[]>([]);
    const [shipping_Id, setShipping_Id] = useState<ShippingDetail[]>([]);
    const [customer_PO, setCustomer_PO] = useState<ShippingDetail[]>([]);

    const [open, setOpen] = useState(false);
    const [label, setLabel] = useState<string>("");

    const [openSuccess, setOpenSuccess] = React.useState(false);
    const [openFail, setOpenFail] = React.useState(false);
    const [message, setMessage] = useState("");


    const { data, error, isLoading } = useGetShippingDetailsQuery("");

    useEffect(() => {
      if (data && Array.isArray(data)) {
        setShippingDetails(data);
      }

      extractColumns();
      
      
    }, [data]);

    useEffect(() => {
      extractColumns();    
    }, [shippingDetails]);
    //////////////////////////////////
    const extractColumns = () => {
      const destinationsSet = new Set();
      const destinations: ShippingDetail[] = [];

      const shippingIdsSet = new Set();
      const shippingIds: ShippingDetail[] = [];

      const customerPOsSet = new Set();
      const customerPOs: ShippingDetail[] = [];
    
      shippingDetails.forEach((session: ShippingDetail) => {
        if (session && session.destination) {
          const destination = session.destination;
          if (!destinationsSet.has(destination)) {
            destinationsSet.add(destination);
            destinations.push({
              id:session.id,
              destination: session.destination,
              shipping_Id: session.shipping_Id,
              customer_PO: session.customer_PO
            });
          }
        }
        if (session && session.shipping_Id) {
          const shippingId = session.shipping_Id;
          if (!shippingIdsSet.has(shippingId)) {
            shippingIdsSet.add(shippingId);
            shippingIds.push({
              id:session.id,
              destination: session.destination,
              shipping_Id: session.shipping_Id,
              customer_PO: session.customer_PO
            });
          }
        }
        if (session && session.customer_PO) {
          const customerPO = session.customer_PO;
          if (!customerPOsSet.has(customerPO)) {
            customerPOsSet.add(customerPO);
            customerPOs.push({
              id:session.id,
              destination: session.destination,
              shipping_Id: session.shipping_Id,
              customer_PO: session.customer_PO
            });
          }
        }
      });
      setDestination(destinations);
      setShipping_Id(shippingIds);
      setCustomer_PO(customerPOs);
;
    };
    /////////////////////////////////

    const array = ['destinations', 'shipping_Id', 'customer_PO']

    const [values, setValues] = useState({
        field1: "",
        field2: "",
        field3: "",
        field4: "",
      });

      const [updateShippinDetails] = useUpdateShippingDetailsMutation()


      const handleDelete = (box: ShippingDetail, label1:string) => {
        if (label1 = "destination"){
          updateShippinDetails({
            id: box.id,
            destination: "",
            shipping_Id: box.shipping_Id,
            customer_PO: box.customer_PO
          })
          }
        if (label1 = "shipping_Id"){
          updateShippinDetails({
            id: box.id,
            destination: box.destination,
            shipping_Id: "",
            customer_PO: box.customer_PO
          })
        }
        if (label1 = "customer_PO"){
          updateShippinDetails({
            id: box.id,
            destination: box.destination,
            shipping_Id: box.shipping_Id,
            customer_PO: ""
          })
        }
         
        }
       


    function addDataDropDown(label: any): any {
        setLabel(label);
        setOpen(true);
      }

      // function getSelectedList(): any {
      //   return (
      //     paginatedModes.filter((item, index) => selectedRows.includes(index)) || []
      //   );
      // }
      // const [getAll] = useGetShippingDetailsQuery();

    // function getSelectedList(): any {
    //     console.log(selectedRows);
        
    //     return (
    //       shippingDetails.filter((item, index) => selectedRows.includes(item.corBox_QR)) || []
    //     );
    //   }

      const handleRowClick = (id: number) => {
        if (selectedRows.includes(id)) {
          setSelectedRows(selectedRows.filter((rowId) => rowId !== id));
        } else {
          setSelectedRows([...selectedRows, id]);
        }
      };

      const handleInputChange = (field: string, value: string) => {
        setValues((prevValues) => ({
          ...prevValues,
          [field]: value,
        }));
        
      };

      if (isLoading) {
        return <div>Loading...</div>;
      }
  return (
    <div>
      
      {/* <h1>Packaging Boxes</h1>
      <table>
        <thead>
          <tr>
            <th>Element Number</th>
            <th>Battery01 Serial</th>
            <th>Battery02 Serial</th>
            <th>DeviceL Mac</th>
            <th>DeviceR Mac</th>
            <th>packed Date</th>
            <th>Packed By</th>

          </tr>
        </thead>
        <tbody>
          {data.map((box) => (
            <tr key={box.element_number}>
              <td>{box.element_number}</td>
              <td>{box.battery01_Serial}</td>
              <td>{box.battery02_Serial}</td>
              <td>{box.deviceL_Mac}</td>
              <td>{box.deviceR_Mac}</td>
              <td>{box.packed_Date}</td>
              <td>{box.packed_By}</td>
            </tr>
          ))}
        </tbody> 
        </table>*/}
        <Box
      component="main"
      sx={{
        flexGrow: 1,
      }}
    >
      <Container maxWidth={false}>
        <>
          <Box m="0px 0 0 0" sx={{}}>
            <Card
              sx={{
                maxWidth: 1600,
                maxHeight: "150vh",
                backgroundColor: "#FFFFFF",
                boxShadow: "1px 1px 10px 10px #e8e8e8",
              }}
            >
              <CardActionArea>
                <CardContent sx={{}}>
                  <Grid
                    container
                    spacing={{ xs: 1, md: 1 }}
                    columns={{ xs: 4, sm: 8, md: 12 }}
                  >
                    <Grid item xs={4} sm={6} md={6}>
                      <Typography
                        gutterBottom
                        variant="h5"
                        component="div"
                        color="grey"
                      >
                        Shipping Details
                      </Typography>
                    </Grid>
                    <Grid item xs={4} sm={2} md={6}>
                      <Box display="flex" justifyContent="flex-end">
                        <Button
                            variant="contained"
                            startIcon={<AddIcon />}
                            sx={{
                                mr: 2,
                              padding: 1,
                              backgroundColor: "#00e676",
                              "&:hover": { backgroundColor: "#00a152" },
                            }}
                            onClick={() => addDataDropDown("destination")}
                          >
                            ADD DESTINATION
                        </Button>
                        <Button
                            variant="contained"
                            startIcon={<AddIcon />}
                            sx={{
                                mr: 2,
                              padding: 1,
                              backgroundColor: "#00e676",
                              "&:hover": { backgroundColor: "#00a152" },
                            }}
                            onClick={() => addDataDropDown("shipping_Id")}
                          >
                            ADD SHIPPING ID
                        </Button>
                        <Button
                            variant="contained"
                            startIcon={<AddIcon />}
                            sx={{
                                mr: 2,
                              padding: 1,
                              backgroundColor: "#00e676",
                              "&:hover": { backgroundColor: "#00a152" },
                            }}
                            onClick={() => addDataDropDown("customer_PO")}
                          >
                            ADD CUSTOMER PO
                        </Button>
                      </Box>
                    </Grid>
                    
                  </Grid>
                  <Divider
                    sx={{
                      borderColor: "grey",
                      mb: 1.5,
                      borderStyle: "dashed",
                    }}
                  />
                  <div
                    style={{
                      display: "flex",
                      alignItems: "center",
                      marginBottom: "20px",
                      width: "100%",
                      overflowX: "auto",
                      flexDirection: "row",
                    }}
                  >
                   {/* <MyComponentCorrugatedBox
                      initialValues={values}
                      onInputChange={handleInputChange}
                      orders={poList}
                    /> */}

                    
                  </div>

                  <Divider
                    sx={{
                      borderColor: "grey",
                      my: 1.5,
                      borderStyle: "dashed",
                    }}
                  />
                  <Paper sx={{ width: "100%", overflow: "hidden" }}>
                    <TableContainer sx={{ maxHeight: 440 }}>
                      <Table stickyHeader aria-label="sticky table">
                        <TableHead sx={{ backgroundColor: "#9e9e9e" }}>
                          <StyledTableRow>
                            {columns.map((column) => (
                              <StyledTableCell
                                key={column.headerName}
                                align={column.align}
                                style={{ maxWidth: column.width }}
                              >
                                {column.headerName}
                              </StyledTableCell>
                            ))}
                          </StyledTableRow>
                        </TableHead>
                        <TableBody>  
                          <StyledTableRow
                            hover
                            role="checkbox"
                            tabIndex={-1}
                            // key={box.shipping_Id}
                            // onClick={() => handleRowClick(box.shipping_Id)}
                            // selected={selectedRows.includes(box.shipping_Id)}
                          >  
                          <StyledTableCell style={{ verticalAlign: 'top' }}>    
                            {destination
                            .map((box) => {
                              return(
                                <StyledTableRow>
                                    <StyledTableCell align={"left"}>
                                    {box.destination}
                                    <DeleteButton className="delete-button" 
                                     onClick={() => {
                                      updateShippinDetails({
                                        id: box.id,
                                        destination: "",
                                        shipping_Id: box.shipping_Id,
                                        customer_PO: box.customer_PO
                                      })
                                      // .unwrap()
                                      //       .then((payload) => {                                                    
                                      //         if (
                                      //           payload.message == "User Delete successfully!"
                                      //         ) {
                                      //           setOpenSuccess(true)
                                      //           setMessage(payload.message)
                                      //         }
                                      //       })
                                      //       .catch((error) => {
                                      //         setOpenFail(true)
                                      //         setMessage(error)
                                      //       });
                                    }}
                                >
                                      <DeleteIcon />
                                    </DeleteButton>
                                    </StyledTableCell>
                                  </StyledTableRow>
                                    )
                                    })}
                                    
                          </StyledTableCell>
                          <StyledTableCell style={{ verticalAlign: 'top' }}>         
                            {shipping_Id
                            .map((box) => {
                              return(
                              <StyledTableRow>
                                    <StyledTableCell align={"left"}>
                                    {box.shipping_Id}
                                    <DeleteButton className="delete-button" 
                                     onClick={() => {
                                      updateShippinDetails({
                                        id: box.id,
                                        destination: box.destination,
                                        shipping_Id: "",
                                        customer_PO: box.customer_PO
                                      })
                                          }}
                                      >
                                      <DeleteIcon />
                                    </DeleteButton>
                                    </StyledTableCell>
                              </StyledTableRow>
                              )
                                    })}
                          </StyledTableCell>
                          <StyledTableCell style={{ verticalAlign: 'top' }}>
                            {customer_PO
                            .map((box) => {
                              return(
                                <StyledTableRow>
                                    <StyledTableCell align={"left"}>
                                    {box.customer_PO}
                                    <DeleteButton className="delete-button" 
                                     onClick={() => {
                                      updateShippinDetails({
                                        id: box.id,
                                        destination: box.destination,
                                        shipping_Id: box.shipping_Id,
                                        customer_PO: ""
                                      })
                                          }}
                                      >
                                      <DeleteIcon />
                                    </DeleteButton>
                                    </StyledTableCell>
                                </StyledTableRow>
                                    )
                                  })}
                          </StyledTableCell>
                          </StyledTableRow> 
                        </TableBody>
                      </Table>
                    </TableContainer>
                  </Paper>
                  {/* <Box display="flex" justifyContent="flex-end">
                    <Pagination
                      count={Math.ceil(modesList.length / rowsPerPage)}
                      sx={{ mt: 2 }}
                      variant="outlined"
                      shape="rounded"
                      page={page}
                      onChange={handleChange}
                    />
                  </Box> */}
                </CardContent>
              </CardActionArea>
            </Card>
          </Box>
        </>
      </Container>
      <AddShippingDetailModel label={label} open={open} changeOpenStatus={setOpen} />
    </Box>
      
    </div>
  )
}
