import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:rvi_analyzer/common/device_status_data.dart';
import 'package:rvi_analyzer/providers/device_state_provider.dart';

class DeviceStatusText extends StatelessWidget {
  final ScanResult scanResult;
  const DeviceStatusText(
    this.scanResult, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return Text(
            getStatusText(ref
                .watch(ref
                    .watch(deviceDataMap[scanResult.device.id.id]!)
                    .streamData)
                .state),
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11,
                color: getStatusColor(ref
                    .watch(ref
                        .watch(deviceDataMap[scanResult.device.id.id]!)
                        .streamData)
                    .state)));
      },
    );
  }
}
