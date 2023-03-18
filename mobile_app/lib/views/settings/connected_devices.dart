import 'package:rvi_analyzer/providers/connected_devices_provider.dart';
import 'package:rvi_analyzer/providers/device_state_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConnectedDevices extends StatefulWidget {
  const ConnectedDevices({Key? key}) : super(key: key);

  @override
  State<ConnectedDevices> createState() => _ConnectedDevicesState();
}

class _ConnectedDevicesState extends State<ConnectedDevices> {
  _ConnectedDevicesState();

  bool isDisconnectPressed = false;

  Widget getCard(ScanResult scanResult) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 30, 41, 59),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
          child: Column(
            children: [
              const Divider(height: 10.0),
              Row(
                children: [
                  Expanded(
                      flex: 3,
                      child: Text(scanResult.device.name,
                          style: const TextStyle(
                              fontSize: 15, color: Colors.grey))),
                  Expanded(
                      flex: 2,
                      child: Consumer(builder: ((context, ref, child) {
                        return CupertinoButton(
                          color: Colors.red,
                          padding: const EdgeInsets.all(10),
                          onPressed: () {
                            setState(() {
                              isDisconnectPressed = true;
                            });
                            ref
                                .read(deviceManagementState)
                                .disconnectDevice(scanResult)
                                .then((value) => {
                                      ref
                                          .read(deviceDataMap[
                                                  scanResult.device.name]!
                                              .notifier)
                                          .isConnected = false,
                                      ref
                                          .read(ref
                                              .read(deviceDataMap[
                                                  scanResult.device.name]!)
                                              .streamData
                                              .notifier)
                                          .subscription
                                          .cancel(),
                                      setState(() {
                                        isDisconnectPressed = false;
                                      })
                                    });
                          },
                          child: isDisconnectPressed
                              ? const CupertinoActivityIndicator(
                                  color: Color.fromARGB(255, 189, 189, 189),
                                )
                              : const Text('Disconnect',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white)),
                        );
                      })))
                ],
              ),
              const Divider(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: ((context, ref, child) {
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 2, 2, 2),
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('Connected devices',
              style: TextStyle(color: Colors.white)),
        ),
        body: SingleChildScrollView(
          child: ListBody(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    for (ScanResult device in ref
                        .watch(deviceManagementState)
                        .connectedBlueDeviceList
                        .values)
                      getCard(device),
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8, 8, 12),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 50,
                  child: CupertinoButton(
                    color: Colors.red,
                    onPressed: ref
                            .watch(deviceManagementState)
                            .connectedBlueDeviceList
                            .isEmpty
                        ? null
                        : () => {
                              ref
                                  .read(deviceManagementState)
                                  .removeAllConnectDevices()
                            },
                    child: const Text('Disconnect All',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }));
  }
}
