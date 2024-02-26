import 'package:flutter/material.dart';
import 'package:rvi_analyzer/views/configure/configure_left_panel.dart';
import 'package:rvi_analyzer/views/configure/qr_scanner.dart'; // Assuming you have a QRScanner widget
import 'package:rvi_analyzer/views/configure/mode_setting.dart';

void main() {
  runApp(const MaterialApp(
    home: RMTrackingPage(),
  ));
}

class RMTrackingPage extends StatefulWidget {
  const RMTrackingPage({Key? key}) : super(key: key);

  @override
  State<RMTrackingPage> createState() => _RMTrackingPageState();
}

class _RMTrackingPageState extends State<RMTrackingPage> {
  String rmValue = '';
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
        title: const Center(
          child: Text(
            'RM Tracking',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(
                context); // Use Navigator.pop instead of Navigator.pushReplacement
          },
        ),
      ),
      // backgroundColor: Colors.cyan,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Display assigned values
                  Card(
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Container(
                      // height: 40.0,
                      width: 400.0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [const Text('Customer PO Number: '),Text(customerPoNumber,style: const TextStyle(color: Colors.grey),)],),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [const Text('RM: '),Text(rmValue,style: const TextStyle(color: Colors.grey),)],),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [const Text('Plant: '),Text(plantValue,style: const TextStyle(color: Colors.grey),)],),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [const Text('Customer: '),Text(customerValue,style: const TextStyle(color: Colors.grey),)],),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [const Text('Style: '),Text(styleValue,style: const TextStyle(color: Colors.grey),)],),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  // DropdownButton to select Production Order
                  Card(
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Container(
                      width: 400.0,
                      height: 60,
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('PO',style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),),
                          const SizedBox(width: 8.0),
                          Container(
                            height: 40.0,
                            width: 250.0,
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(
                                color: const Color.fromARGB(255, 158, 158, 158),
                              ),
                            ),
                            child: DropdownButton<String>(
                            value: productionOrder,
                            icon: const Icon(Icons.arrow_drop_down),
                              style: const TextStyle(color: Colors.black),
                            underline: const SizedBox(),
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
                          ),],
                      )
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Text box for entering UID
                  Card(
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Container(
                      width: 400.0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      height: 60.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "UID",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8.0),
                        Expanded(
                          child: Container(
                            height: 40.0,
                            padding: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(
                                color: const Color.fromARGB(255, 158, 158, 158),
                              ),
                            ),
                            child: TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  uid = value;
                                });
                              },
                            ),
                          ),
                        ),],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // QR Scan button
                  Container(
                    width: 120.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: Colors.blue,
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
                      child: const Text(
                        'QR Scan',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
              Positioned(
                  bottom: 16.0,
                  right: 16.0,
              child: ElevatedButton(
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
                            title: const Text("Error"),
                            content: const Text(
                                "Please select a Production Order from the list or Enter UID"),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("OK"),
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
              ),),
            ],
          ),
        ),
      ),
    );
  }
}
