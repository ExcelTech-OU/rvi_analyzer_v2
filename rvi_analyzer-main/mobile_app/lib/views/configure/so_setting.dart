import 'package:flutter/material.dart';
import 'package:rvi_analyzer/views/configure/production_order.dart';

void main() {
  runApp(MaterialApp(
    home: SOSettingPage(),
  ));
}

class SOSettingPage extends StatefulWidget {
  @override
  _SOSettingPageState createState() => _SOSettingPageState();
}

class _SOSettingPageState extends State<SOSettingPage> {
  // Define variables to hold the values
  String rmValue = ''; // Set a default value
  String plantValue = '';
  String customerValue = '';
  String styleValue = '';
  String customerPoNumber = 'Customer PO 1';
  String soNumber = ''; // Corrected variable name
  bool settingsSaved = false; // Add a variable for settingsSaved

  // Function to update values based on the selected RM
  void updateValues(String soNumber) {
    setState(() {
      // assign values
      switch (soNumber) {
        case 'Customer PO 1':
          plantValue = 'plant1';
          customerValue = 'customer1';
          styleValue = 'style1';
          rmValue = 'RM 1';
          break;
        case 'Customer PO 2':
          plantValue = 'plant2';
          customerValue = 'customer2';
          styleValue = 'style2';
          rmValue = 'RM 2';
          break;
        case 'Customer PO 3':
          plantValue = 'plant3';
          customerValue = 'customer3';
          styleValue = 'style3';
          rmValue = 'RM 3';
          break;
        // Add more cases if needed
        default:
          // Default values or error handling
          plantValue = '';
          customerValue = '';
          styleValue = '';
          rmValue = '';
      }
    });
  }

  // Function to validate input
  bool validateInput() {
    return customerPoNumber.isNotEmpty &&
        customerPoNumber.isNotEmpty &&
        plantValue.isNotEmpty &&
        customerValue.isNotEmpty &&
        styleValue.isNotEmpty;
  }

  // Function to save to local storage
  Future<void> saveToLocalStorage() async {
    // Add logic to save to local storage
    // Example: SharedPreferences, database, etc.
    // For simplicity, let's print a message
    print('Saved to local storage');
  }

  void showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Success"),
          content: Text("Settings saved successfully."),
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
                    Text('RM: $rmValue'),
                    Text('Plant: $plantValue'),
                    Text('Customer: $customerValue'),
                    Text('Style: $styleValue'),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // DropdownButton to select RM
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
                  value: customerPoNumber,
                  icon: Icon(Icons.arrow_drop_down),
                  style: TextStyle(color: Colors.black),
                  underline: SizedBox(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        customerPoNumber = newValue;
                        // Call the function to update values based on the selected RM
                        updateValues(customerPoNumber);
                      });
                    }
                  },
                  items: <String>[
                    'Customer PO 1',
                    'Customer PO 2',
                    'Customer PO 3'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 20),
              // Text box for entering Customer PO number
              Container(
                width: 250.0,
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      soNumber = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'SO NO', // Changed label text
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
              // Save/Next Button
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
                                "Please Select PO Number value from the list"),
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
                        builder: (context) => ProductionOrderPage(),
                      ),
                    );
                  }
                },
                child: Text(settingsSaved ? "Next" : "Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
