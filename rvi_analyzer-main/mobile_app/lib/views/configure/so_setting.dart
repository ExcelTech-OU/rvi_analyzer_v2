import 'package:flutter/material.dart';
import 'package:rvi_analyzer/views/configure/production_order.dart';

void main() {
  runApp(const MaterialApp(
    home: SOSettingPage(),
  ));
}

class SOSettingPage extends StatefulWidget {
  const SOSettingPage({Key? key}) : super(key: key);

  @override
  State<SOSettingPage> createState() => _SOSettingPageState();
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
          title: const Text("Success"),
          content: const Text("Settings saved successfully."),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'SO Settings',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Display assigned values in a fixed-size box at the top of the page
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('RM: '),
                                Text(
                                  rmValue,
                                  style: const TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Plant: '),
                                Text(
                                  plantValue,
                                  style: const TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Customer: '),
                                Text(
                                  customerValue,
                                  style: const TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Style: '),
                                Text(
                                  styleValue,
                                  style: const TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // DropdownButton to select RM
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
                            const Text(
                              'Customer PO',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              height: 40.0,
                              width: 200.0,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 158, 158, 158),
                                ),
                              ),
                              child: DropdownButton<String>(
                                value: customerPoNumber,
                                icon: const Icon(Icons.arrow_drop_down),
                                style: const TextStyle(color: Colors.black),
                                underline: const SizedBox(),
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
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Text box for entering Customer PO number
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
                              "SO No",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Expanded(
                              child: Container(
                                height: 40.0,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 158, 158, 158),
                                  ),
                                ),
                                child: TextFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      soNumber = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
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
                                  "Please Select PO Number value from the list"),
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
                          builder: (context) => ProductionOrderPage(),
                        ),
                      );
                    }
                  },
                  child: Text(settingsSaved ? "Next" : "Save"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
