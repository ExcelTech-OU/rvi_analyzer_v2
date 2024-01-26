import 'package:flutter/material.dart';

class ProductionOrderPage extends StatefulWidget {
  @override
  _ProductionOrderPageState createState() => _ProductionOrderPageState();
}

class _ProductionOrderPageState extends State<ProductionOrderPage> {
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
    home: ProductionOrderPage(),
  ));
}
