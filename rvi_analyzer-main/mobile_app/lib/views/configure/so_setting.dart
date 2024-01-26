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
  String soNumberValue = '';

  // Function to update values based on the selected RM
  void updateValues(String soNumber) {
    setState(() {
      // assign values
      switch (soNumber) {
        case 'SO Number 1':
          plantValue = 'plant1';
          customerValue = 'customer1';
          styleValue = 'style1';
          rmValue = '01';
          break;
        case 'SO  Number2':
          plantValue = 'plant2';
          customerValue = 'customer2';
          styleValue = 'style2';
          rmValue = '02';
          break;
        case 'SO Number 3':
          plantValue = 'plant3';
          customerValue = 'customer3';
          styleValue = 'style3';
          rmValue = '02';
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the selected values in a box
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
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
            SizedBox(height: 20),
            // DropdownButton to select Po
            DropdownButton<String>(
              value: rmValue,
              onChanged: (String? newValue) {
                setState(() {
                  soNumberValue = newValue!;
                  // Call the function to update values based on the selected RM
                  updateValues(soNumberValue);
                });
              },
              items: <String>['SO Number 1', 'SO Number 2', 'SO Number 3']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SoSettingPage(),
  ));
}
