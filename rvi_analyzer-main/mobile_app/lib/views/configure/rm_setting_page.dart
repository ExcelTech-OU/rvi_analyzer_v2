import 'package:flutter/material.dart';
import 'package:rvi_analyzer/views/configure/customer_po_setting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RmSettingPage extends StatefulWidget {
  const RmSettingPage({Key? key}) : super(key: key);

  @override
  State<RmSettingPage> createState() => _RmSettingPageState();
}

class _RmSettingPageState extends State<RmSettingPage> {
  String? selectedPlant;
  String? selectedCustomer;
  String? selectedStyle;
  String? inputValue;
  bool settingsSaved = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Setting',
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildLabelWithDropdown(
                      "Plant",
                      ["Plant 1", "Plant 2", "Plant 3"],
                      selectedPlant,
                      (String? newValue) {
                        setState(() {
                          selectedPlant = newValue;
                        });
                        print('Selected $newValue for Plant');
                      },
                    ),
                    buildLabelWithDropdown(
                      "Customer",
                      ["Customer A", "Customer B", "Customer C"],
                      selectedCustomer,
                      (String? newValue) {
                        setState(() {
                          selectedCustomer = newValue;
                        });
                        print('Selected $newValue for Customer');
                      },
                    ),
                    buildLabelWithDropdown(
                      "Style",
                      ["Style X", "Style Y", "Style Z"],
                      selectedStyle,
                      (String? newValue) {
                        setState(() {
                          selectedStyle = newValue;
                        });
                        print('Selected $newValue for Style');
                      },
                    ),
                    buildLabelWithTextInput("RM"),
                  ],
                ),
              ),
              Positioned(
                bottom: 16.0,
                right: 16.0,
                child: ElevatedButton(
                  onPressed: () async {
                    if (validateInput()) {
                      if (settingsSaved) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PoSettingPage(),
                          ),
                        );
                      } else {
                        await saveToLocalStorage();
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Saved"),
                              content: Text("Saved successfully."),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    setState(() {
                                      settingsSaved = true;
                                    });
                                  },
                                  child: Text("OK"),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    } else {
                      // Show error message for empty RM field
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Error"),
                            content: const Text("RM field cannot be empty."),
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

  bool validateInput() {
    return inputValue != null && inputValue!.isNotEmpty;
  }

  Future<void> saveToLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedPlant', selectedPlant ?? '');
    prefs.setString('selectedCustomer', selectedCustomer ?? '');
    prefs.setString('selectedStyle', selectedStyle ?? '');
    prefs.setString('inputValue', inputValue ?? '');
  }

  Widget buildLabelWithDropdown(
    String label,
    List<String> options,
    String? selectedOption,
    Function(String?) onChanged,
  ) {
    return Card(
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
            Text(
              label,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
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
              child: Row(
                children: [
                  DropdownButton<String>(
                    value: selectedOption,
                    icon: const Icon(Icons.arrow_drop_down),
                    style: const TextStyle(color: Colors.black),
                    underline: const SizedBox(),
                    onChanged: (String? newValue) => onChanged(newValue),
                    items: options.map<DropdownMenuItem<String>>(
                      (String option) {
                        return DropdownMenuItem<String>(
                          value: option,
                          child: Text(option),
                        );
                      },
                    ).toList(),
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
    return Card(
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
            Text(
              label,
              style: const TextStyle(
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
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      inputValue = value;
                    });
                    print('Entered $value for $label');
                  },
                  decoration: const InputDecoration(
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
  runApp(const MaterialApp(
    home: RmSettingPage(),
  ));
}
