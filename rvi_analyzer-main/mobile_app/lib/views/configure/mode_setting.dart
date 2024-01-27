import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rvi_analyzer/views/configure/customer_po_setting.dart';
import 'package:rvi_analyzer/views/configure/production_order.dart';
import 'package:rvi_analyzer/views/configure/rm_setting_page.dart';
import 'package:rvi_analyzer/views/configure/customer_po_setting.dart';
import 'package:rvi_analyzer/views/configure/so_setting.dart';

class ModeSettingsPage extends StatelessWidget {
  // Variable to track if the first "Add" button is pressed
  bool isFirstAddButtonPressed = false;
  bool isSecondAddButtonPressed = false;
  bool isThirdAddButtonPressed = false;
  bool isFourthAddButtonPreseed = false;

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
      body: SingleChildScrollView(
        child: Container(
          color: Colors.cyan,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

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
            if (kDebugMode) {
              print('Adding $label');
            }

            // Navigate to another page only when the first "Add" button is pressed
            if (label == "RM" && !isFirstAddButtonPressed) {
              isFirstAddButtonPressed = true;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => RmSettingPage()),
              );
            } else if (label == "Customer PO" && !isSecondAddButtonPressed) {
              isSecondAddButtonPressed = true;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => PoSettingPage()),
              );
            } else if (label == "SO Number" && !isThirdAddButtonPressed) {
              isThirdAddButtonPressed = true;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SOSettingPage()),
              );
            } else if (label == "Production Order" &&
                !isFourthAddButtonPreseed) {
              isFourthAddButtonPreseed = true;
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductionOrderPage()));
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
