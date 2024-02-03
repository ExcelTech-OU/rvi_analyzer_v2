import 'package:flutter/material.dart';
import 'package:rvi_analyzer/views/configure/qr_scanner.dart';

void main() {
  runApp(MaterialApp(
    home: TestingPage(),
  ));
}

class TestingPage extends StatefulWidget {
  @override
  _TestingPageState createState() => _TestingPageState();
}

class _TestingPageState extends State<TestingPage> {
  String selectedValue1 = '';
  String selectedValue2 = '';
  String selectedValueProduction = '';
  String qrCode = '';
  String parameterMode01Value = '';
  String parameterMode02Value = '';
  String parameterMode03Value = '';
  String parameterMode04Value = '';
  String plantValue = '';
  String customerValue = '';
  String styleValue = '';
  String rm = "";
  String customerpo = "";
  String sono = "";

  void setQRCode(String? code) {
    if (code != null) {
      setState(() {
        qrCode = code;
      });
    }
  }

  void onSaveButtonPressed() {
    print('Save button pressed!');
    print('Parameter Mode 01: $parameterMode01Value');
    print('Parameter Mode 02: $parameterMode02Value');
    print('Parameter Mode 03: $parameterMode03Value');
    print('Parameter Mode 04: $parameterMode04Value');
    // Add any additional save logic you need
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Testing',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black54,
                        width: 2.0,
                      ),
                    ),
                    child: SizedBox(
                      width: 325.0,
                      height: 200.0,
                      child: Center(
                        child: Text(
                          'Customer: $customerValue\nPlant: $plantValue\nStyle: $styleValue\nRM: $rm\nCustomer PO: $customerpo\nSO NO: $sono ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black54,
                        width: 2.0,
                      ),
                    ),
                    child: SizedBox(
                      width: 200.0,
                      height: 25.0,
                      child: Center(
                        child: Text(
                          'Text ',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black54,
                        width: 2.0,
                      ),
                    ),
                    width: 120.0,
                    height: 40.0,
                    child: DropdownButton<String>(
                      value: selectedValue1,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            selectedValue1 = newValue;
                          });
                        }
                      },
                      items: <String>[
                        '',
                        'Option 1',
                        'Option 2',
                        'Option 3',
                        'Option 4',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black54,
                        width: 2.0,
                      ),
                    ),
                    child: SizedBox(
                      width: 200.0,
                      height: 25.0,
                      child: Center(
                        child: Text(
                          'Production Order',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black54,
                        width: 2.0,
                      ),
                    ),
                    width: 120.0,
                    height: 40.0,
                    child: DropdownButton<String>(
                      value: selectedValue2,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            selectedValue2 = newValue;
                          });
                        }
                      },
                      items: <String>[
                        '',
                        'Option 1',
                        'Option 2',
                        'Option 3',
                        'Option 4',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black54,
                        width: 2.0,
                      ),
                    ),
                    child: SizedBox(
                      width: 200.0,
                      height: 25.0,
                      child: Center(
                        child: Text(
                          'Production ID',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Container(
                    width: 120.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: Colors.cyan,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QRScanner(
                              updateQRCode: setQRCode,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        'QR Scan',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black54,
                        width: 2.0,
                      ),
                    ),
                    child: SizedBox(
                      width: 200.0,
                      height: 25.0,
                      child: Center(
                        child: Text(
                          'Parameter Mode 01',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Container(
                    width: 120.0,
                    height: 40.0,
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          parameterMode01Value = value;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Value',
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
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black54,
                        width: 2.0,
                      ),
                    ),
                    child: SizedBox(
                      width: 200.0,
                      height: 25.0,
                      child: Center(
                        child: Text(
                          'Parameter Mode 02',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Container(
                    width: 120.0,
                    height: 40.0,
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          parameterMode02Value = value;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Value',
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
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black54,
                        width: 2.0,
                      ),
                    ),
                    child: SizedBox(
                      width: 200.0,
                      height: 25.0,
                      child: Center(
                        child: Text(
                          'Parameter Mode 03',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Container(
                    width: 120.0,
                    height: 40.0,
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          parameterMode03Value = value;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Value',
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
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black54,
                        width: 2.0,
                      ),
                    ),
                    child: SizedBox(
                      width: 200.0,
                      height: 25.0,
                      child: Center(
                        child: Text(
                          'Parameter Mode 04',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Container(
                    width: 120.0,
                    height: 40.0,
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          parameterMode04Value = value;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Value',
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
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black54,
                        width: 2.0,
                      ),
                    ),
                    child: SizedBox(
                      width: 200.0,
                      height: 25.0,
                      child: Center(
                        child: Text(
                          'Save',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Container(
                    width: 120.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: TextButton(
                      onPressed: onSaveButtonPressed,
                      child: Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
