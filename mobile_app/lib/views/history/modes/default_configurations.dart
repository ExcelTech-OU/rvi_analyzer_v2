import 'package:flutter/material.dart';
import 'package:rvi_analyzer/repository/entity/common_entity.dart';

class DefaultConfView extends StatelessWidget {
  final DefaultConfiguration config;

  const DefaultConfView({Key? key, required this.config}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Default Configurations',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        const SizedBox(height: 8.0),
        Row(
          children: [
            const Text(
              'Session Id : ',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              config.sessionId,
              style: const TextStyle(fontSize: 14.0, color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Row(
          children: [
            const Text(
              'Serial No : ',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              config.serialNo,
              style: const TextStyle(fontSize: 14.0, color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Row(
          children: [
            const Text(
              'Batch No : ',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              config.batchNo,
              style: const TextStyle(fontSize: 14.0, color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Row(
          children: [
            const Text(
              'Customer Name : ',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              config.customerName,
              style: const TextStyle(fontSize: 14.0, color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Row(
          children: [
            const Text(
              'Operator Id : ',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              config.operatorId,
              style: const TextStyle(fontSize: 14.0, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}
