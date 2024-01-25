import 'package:flutter/material.dart';

class PoSettingPage extends StatefulWidget {
  @override
  _PoSettingPageState createState() => _PoSettingPageState();
}

class _PoSettingPageState extends State<PoSettingPage> {
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
    );
  }
}
