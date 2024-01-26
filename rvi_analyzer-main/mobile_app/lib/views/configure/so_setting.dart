import 'package:flutter/material.dart';

class SoSettingPage extends StatefulWidget {
  @override
  _SoSettingPageState createState() => _SoSettingPageState();
}

class _SoSettingPageState extends State<SoSettingPage> {
  // Define variables to hold the values
  String rmValue = '';
  String plantValue = '';
  String customerValue = '';
  String styleValue = '';
  String CustomerPOValue = 'Customer PO 1'; // Set an initial value

  // Function to update values based on the selected RM
  void updateValues(String soNumber) {
    setState(() {
      // assign values
      switch (soNumber) {
        case 'Customer PO 1':
          plantValue = 'plant1';
          customerValue = 'customer1';
          styleValue = 'style1';
          rmValue = '01';
          break;
        case 'Customer PO 2':
          plantValue = 'plant2';
          customerValue = 'customer2';
          styleValue = 'style2';
          rmValue = '02';
          break;
        case 'Customer PO 3':
          plantValue = 'plant3';
          customerValue = 'customer3';
          styleValue = 'style3';
          rmValue = '03'; // Change to a unique value for SO Number 3
          break;
        // Add more cases if needed
        default:
          // Default values or error handling
          rmValue = '';
          plantValue = '';
          customerValue = '';
          styleValue = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display the selected values in a fixed-size box
              Container(
                width: 300, // Set the width as per your requirement
                height: 150, // Set the height as per your requirement
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    Text('RM: $rmValue'),
                    Text('Plant: $plantValue'),
                    Text('Customer: $customerValue'),
                    Text('Style: $styleValue'),
                  ],
                ),
              ),
              SizedBox(height: 30),
              // DropdownButton to select Po
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: DropdownButton<String>(
                  value: CustomerPOValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      CustomerPOValue = newValue!;
                      // Call the function to update values based on the selected RM
                      updateValues(CustomerPOValue);
                    });
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
            ],
          ),
        ),
        backgroundColor: Colors.cyan,
      ),
    );
  }
}

void main() {
  runApp(SoSettingPage());
}
