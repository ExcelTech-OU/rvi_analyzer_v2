import 'package:flutter/material.dart';
import 'package:rvi_analyzer/views/configure/so_setting.dart';

class PoSettingPage extends StatefulWidget {
  @override
  _PoSettingPageState createState() => _PoSettingPageState();
}

class _PoSettingPageState extends State<PoSettingPage> {
  // Define variables to hold the values
  String rmValue = 'RM 1'; // Set a default value
  String plantValue = '';
  String customerValue = '';
  String styleValue = '';
  String customerPoNumber = ''; // Corrected variable name
  bool settingsSaved = false; // Add a variable for settingsSaved

  // Function to update values based on the selected RM
  void updateValues(String rm) {
    setState(() {
      // assign values
      switch (rm) {
        case 'RM 1':
          plantValue = 'plant1';
          customerValue = 'customer1';
          styleValue = 'style1';
          break;
        case 'RM 2':
          plantValue = 'plant2';
          customerValue = 'customer2';
          styleValue = 'style2';
          break;
        case 'RM 3':
          plantValue = 'plant3';
          customerValue = 'customer3';
          styleValue = 'style3';
          break;
        // Add more cases if needed
        default:
          // Default values or error handling
          plantValue = '';
          customerValue = '';
          styleValue = '';
      }
    });
  }

  // Function to validate input
  bool validateInput() {
    return customerPoNumber.isNotEmpty;
  }

  // Function to save to local storage
  Future<void> saveToLocalStorage() async {
    // Add logic to save to local storage
    // Example: SharedPreferences, database, etc.
    // For simplicity, let's print a message
    print('Saved to local storage');
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
      body: Padding(
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
                value: rmValue,
                icon: Icon(Icons.arrow_drop_down),
                style: TextStyle(color: Colors.black),
                underline: SizedBox(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      rmValue = newValue;
                      // Call the function to update values based on the selected RM
                      updateValues(rmValue);
                    });
                  }
                },
                items: <String>['RM 1', 'RM 2', 'RM 3']
                    .map<DropdownMenuItem<String>>((String value) {
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
                    customerPoNumber = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Customer PO', // Changed label text
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
                  } else {
                    // Show error message for empty Customer PO number field
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Error"),
                          content: Text("Customer PO field cannot be empty."),
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
                      builder: (context) => SoSettingPage(),
                    ),
                  );
                }
              },
              child: Text(settingsSaved ? "Next" : "Save"),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: PoSettingPage(),
  ));
}
