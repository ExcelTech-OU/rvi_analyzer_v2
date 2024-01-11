import 'package:rvi_analyzer/providers/connected_devices_provider.dart';
import 'package:rvi_analyzer/providers/device_state_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeviceAdditionalSettings extends StatefulWidget {
  final ScanResult scanResult;
  final void Function() resetScanResult;

  const DeviceAdditionalSettings(
      {Key? key, required this.scanResult, required this.resetScanResult})
      : super(key: key);
  @override
  State<DeviceAdditionalSettings> createState() =>
      _DeviceAdditionalSettingsState();
}

class _DeviceAdditionalSettingsState extends State<DeviceAdditionalSettings> {
  bool isDisconnectPressed = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Additional Device Settings',
          style: TextStyle(
              fontSize: 14, color: Color.fromARGB(255, 148, 163, 184)),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 60,
                child: CupertinoButton.filled(
                  disabledColor: Colors.grey,
                  onPressed: () {},
                  child: const Text('Send Device Data',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 253, 253))),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 60,
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.green)),
                    child: CupertinoButton(
                      disabledColor: Colors.grey,
                      onPressed: () {},
                      child: const Text('Calibrate Device',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.green)),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 60,
                child: InkWell(
                  onTap: () {},
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: Colors.green)),
                      child: Consumer(builder: ((context, ref, child) {
                        return CupertinoButton(
                          disabledColor: Colors.grey,
                          onPressed: () {
                            setState(() {
                              isDisconnectPressed = true;
                            });
                            ref
                                .read(deviceManagementState)
                                .disconnectDevice(widget.scanResult)
                                .then((value) => {
                                      ref
                                          .read(deviceDataMap[widget
                                                  .scanResult.device.id.id]!
                                              .notifier)
                                          .isConnected = false,
                                      if (deviceConnectionStatusMap.containsKey(
                                          widget.scanResult.device.id.id))
                                        {
                                          ref
                                              .read(deviceConnectionStatusMap[
                                                      widget.scanResult.device
                                                          .name]!
                                                  .notifier)
                                              .alreadyListening = false,
                                          ref
                                              .read(deviceConnectionStatusMap[
                                                      widget.scanResult.device
                                                          .name]!
                                                  .notifier)
                                              .cancelSubscription(),
                                          deviceConnectionStatusMap.remove(
                                              widget.scanResult.device.id.id),
                                        },
                                      ref
                                          .read(ref
                                              .read(deviceDataMap[widget
                                                  .scanResult.device.id.id]!)
                                              .streamData
                                              .notifier)
                                          .subscription
                                          .cancel(),
                                      setState(() {
                                        isDisconnectPressed = false;
                                      }),
                                      widget.resetScanResult()
                                    });
                          },
                          child: isDisconnectPressed
                              ? const CupertinoActivityIndicator(
                                  color: Color.fromARGB(255, 189, 189, 189),
                                )
                              : const Text('Disconnect Device',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green)),
                        );
                      }))),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
