import 'package:flutter/material.dart';
import 'package:rvi_analyzer/views/configure/configure_left_panel.dart';
import 'package:rvi_analyzer/views/configure/qr_scanner.dart'; // Assuming you have a QRScanner widget
import 'package:rvi_analyzer/views/configure/mode_setting.dart';

void main() {
  runApp(MaterialApp(
    home: RMTrackingPage(),
  ));
}

class RMTrackingPage extends StatefulWidget {
  @override
  _RMTrackingPageState createState() => _RMTrackingPageState();
}

class _RMTrackingPageState extends State<RMTrackingPage> {
  // Define variables to hold the values
  String rmValue = ''; // Set a default value
  String plantValue = '';
  String customerValue = '';
  String styleValue = '';
  String customerPoNumber = '';
  String soNumber = '';
  String productionOrder = 'Production Order 1';
  String uid = '';
  bool settingsSaved = false; // Add a variable for settingsSaved

  // Function to update values based on the selected Production Order
  void updateValues(String productionOrder) {
    setState(() {
      // assign values
      switch (productionOrder) {
        case 'Production Order 1':
          plantValue = 'plant1';
          customerValue = 'customer1';
          styleValue = 'style1';
          rmValue = 'RM 1';
          customerPoNumber = 'Customer PO 01';
          soNumber = 'SO 01';
          break;
        case 'Production Order 2':
          plantValue = 'plant2';
          customerValue = 'customer2';
          styleValue = 'style2';
          rmValue = 'RM 2';
          customerPoNumber = 'Customer PO 02';
          soNumber = 'SO 02';
          break;
        case 'Production Order 3':
          plantValue = 'plant3';
          customerValue = 'customer3';
          styleValue = 'style3';
          rmValue = 'RM 3';
          customerPoNumber = 'Customer PO 03';
          soNumber = 'SO 03';
          break;
        // Add more cases if needed
        default:
          // Default values or error handling
          rmValue = '';
          plantValue = '';
          customerValue = '';
          styleValue = '';
          customerPoNumber = '';
          soNumber = '';
      }
    });
  }

  // Placeholder function for QR code update
  void setQRCode(String? qrCode) {
    // Implement the logic to handle the scanned QR code
  }

  // Placeholder function for validation
  bool validateInput() {
    return true; // Implement your validation logic
  }

  // Placeholder function for saving to local storage
  Future<void> saveToLocalStorage() async {
    // Implement the logic to save to local storage
    // Example: SharedPreferences, database, etc.
  }

  void showSuccessDialog() {
    // Implement the logic to show the success dialog
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Setting',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.cyan, // Set background color to blue
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display assigned values in a fixed-size box at the top of the page
              Container(
                width: double.infinity, // Set to take up the full width
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey), // Border color ash
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white, // Box background color white
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Customer PO Number: $customerPoNumber'),
                    Text('RM: $rmValue'),
                    Text('Plant: $plantValue'),
                    Text('Customer: $customerValue'),
                    Text('Style: $styleValue'),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // DropdownButton to select Production Order
              Container(
                width: 250.0,
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(
                    color: Color.fromARGB(255, 158, 158, 158),
                  ),
                  color: Colors.grey[300], // Set the background color
                ),
                child: DropdownButton<String>(
                  value: productionOrder,
                  icon: Icon(Icons.arrow_drop_down),
                  style: TextStyle(color: Colors.black),
                  underline: SizedBox(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        productionOrder = newValue;
                        // Call the function to update values based on the selected Production Order
                        updateValues(productionOrder);
                      });
                    }
                  },
                  items: <String>[
                    'Production Order 1',
                    'Production Order 2',
                    'Production Order 3'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 20),
              // Text box for entering UID
              Container(
                width: 250.0,
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      uid = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'UID', // Changed label text
                    fillColor: Colors.grey[300], // Set the background color
                    filled: true,
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // QR Scan button
              Container(
                width: 120.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: Colors.blue, // Set the background color
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            QRScanner(updateQRCode: setQRCode),
                      ),
                    );
                  },
                  child: Text(
                    'QR Scan',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Save/Next and Scan/Enter ID Buttons in a Row (Switched positions)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (!settingsSaved) {
                        // Save button logic
                        if (validateInput()) {
                          await saveToLocalStorage();
                          setState(() {
                            settingsSaved = true;
                          });
                          showSuccessDialog(); // Show success message
                        } else {
                          // Show error message for empty fields
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Error"),
                                content: Text(
                                    "Please select a Production Order from the list or Enter UID"),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("OK"),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      } else {
                        // Next button logic
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ModeSettingsPage(),
                          ),
                        );
                      }
                    },
                    child: Text(settingsSaved ? "Next" : "Save"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
