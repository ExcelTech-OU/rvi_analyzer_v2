import 'package:flutter/material.dart';
import 'package:rvi_analyzer/views/configure/rm_setting_page.dart';

class ModeSettingsPage extends StatelessWidget {
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
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromARGB(
              255, 157, 195, 226), // Set the background color to blue
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Set mainAxisSize to min
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Label row 1
                  buildLabelRow(context, "RM"),

                  // Label row 2
                  buildLabelRow(context, "Customer PO"),

                  // Label row 3
                  buildLabelRow(context, "SO Number"),

                  // Label row 4
                  buildLabelRow(context, "Production Order"),

                  SizedBox(
                    height: 16.0,
                  ), // Add some space between the rectangles and the "Next" button

                  // Next button
                  ElevatedButton(
                    onPressed: () {
                      // Add your logic here when the "Next" button is pressed
                      print('Next button pressed');
                    },
                    child: Text('Next'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Variable to track if the first "Add" button is pressed
  bool isFirstAddButtonPressed = false;

  Widget buildLabelRow(BuildContext context, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 200.0, // Set the width of each rectangle
          height: 50.0, // Set the height of each rectangle
          margin: EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.white, // Set the rectangle background color
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(width: 8.0), // Add space between rectangle and button
        ElevatedButton(
          onPressed: () {
            // Add your logic here when the "Add" button is pressed
            // You can access the label value and perform any necessary actions
            print('Adding $label');

            // Navigate to another page only when the first "Add" button is pressed
            if (label == "RM" && !isFirstAddButtonPressed) {
              isFirstAddButtonPressed =
                  true; // Set the flag to true after navigation
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => RmSettingPage()),
              );
            }
          },
          child: Text('Add'),
        ),
      ],
    );
  }

  Widget buildTextFieldRow(String textFieldLabel, String addButtonLabel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 200.0, // Adjust the width as needed
          margin: EdgeInsets.all(8.0),
          child: TextField(
            maxLines: 1, // Set maxLines to 1 to limit the length (width)
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: textFieldLabel,
            ),
          ),
        ),
      ],
    );
  }
}
