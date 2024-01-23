import 'package:flutter/material.dart';

class RmSettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            ' Setting',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Label 1 with Dropdown
                    buildLabelWithDropdown(
                      "Plant",
                      ["Plant 1", "Plant 2", "Plant 3"],
                    ),

                    // Label 2 with Dropdown
                    buildLabelWithDropdown(
                      "Customer",
                      ["Customer A", "Customer B", "Customer C"],
                    ),

                    // Label 3 with Dropdown
                    buildLabelWithDropdown(
                      "Style",
                      ["Style X", "Style Y", "Style Z"],
                    ),

                    // Label 4 with Text Input
                    buildLabelWithTextInput("RM"),
                  ],
                ),
              ),
              Positioned(
                bottom: 16.0,
                right: 16.0,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle save button click
                    print("Save button clicked");
                  },
                  child: Text("Save"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLabelWithDropdown(String label, List<String> options) {
    String? selectedOption; // Track the selected option

    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        width: 400.00,
        padding: EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        // Set a fixed height for the container
        height: 60.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 8.0),
            Container(
              height: 40.0, // Set a fixed height for the dropdown container
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                border:
                    Border.all(color: const Color.fromARGB(255, 158, 158, 158)),
              ),
              child: Row(
                children: [
                  DropdownButton<String>(
                    value: selectedOption,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 24.0,
                    elevation: 16,
                    style: TextStyle(color: Colors.black),
                    underline: SizedBox(),
                    onChanged: (String? newValue) {
                      selectedOption = newValue;
                      print('Selected $newValue for $label');
                    },
                    items:
                        options.map<DropdownMenuItem<String>>((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                  ),
                  SizedBox(width: 8.0),
                  if (selectedOption != null)
                    Text(
                      selectedOption!,
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLabelWithTextInput(String label) {
    String? inputValue; // Track the entered value

    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        width: 400.00,
        padding: EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        // Set a fixed height for the container
        height: 60.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 200.0),
            Expanded(
              child: Container(
                height: 40.0, // Set a fixed height for the text input container
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: Color.fromARGB(255, 158, 158, 158)),
                ),
                child: TextField(
                  onChanged: (value) {
                    inputValue = value;
                    print('Entered $value for $label');
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: RmSettingPage(),
  ));
}
