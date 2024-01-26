import 'package:flutter/material.dart';

class RMTrackingPage extends StatefulWidget {
  @override
  _RMTrackingPageState createState() => _RMTrackingPageState();
}

class _RMTrackingPageState extends State<RMTrackingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Production Order'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: RMTrackingPage(),
  ));
}
