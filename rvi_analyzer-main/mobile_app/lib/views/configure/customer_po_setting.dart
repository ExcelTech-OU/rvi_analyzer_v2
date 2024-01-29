import 'package:flutter/material.dart';
import 'package:rvi_analyzer/service/rmservice.dart';
import 'package:rvi_analyzer/views/configure/so_setting.dart';

class PoSettingPage extends StatefulWidget {
  @override
  _PoSettingPageState createState() => _PoSettingPageState();
}

class _PoSettingPageState extends State<PoSettingPage> {
  String rmValue = 'RM 1';
  String plantValue = '';
  String customerValue = '';
  String styleValue = '';
  String customerPoNumber = '';
  bool settingsSaved = false;

  // Function to update values based on the selected RM
  void updateValues(String rm) {
    setState(() {
      Map<String, String> rmValues =
          RMService.getRMValues(rm) as Map<String, String>;
      plantValue = rmValues['plant'] ?? '';
      customerValue = rmValues['customer'] ?? '';
      styleValue = rmValues['style'] ?? '';
    });
  }

  bool validateInput() {
    return customerPoNumber.isNotEmpty &&
        plantValue.isNotEmpty &&
        customerValue.isNotEmpty &&
        styleValue.isNotEmpty;
  }

  Future<void> saveToLocalStorage() async {
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
      backgroundColor: Colors.cyan,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
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
            Container(
              width: 250.0,
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(
                  color: Color.fromARGB(255, 158, 158, 158),
                ),
                color: Colors.grey[300],
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
            Container(
              width: 250.0,
              child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    customerPoNumber = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Customer PO',
                  fillColor: Colors.grey[300],
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
            ElevatedButton(
              onPressed: () async {
                if (!settingsSaved) {
                  if (validateInput()) {
                    await saveToLocalStorage();
                    setState(() {
                      settingsSaved = true;
                    });
                    showSuccessDialog();
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Error"),
                          content: Text("Please Select RM value from the list"),
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
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SOSettingPage(),
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
