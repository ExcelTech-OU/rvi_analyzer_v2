import 'package:rvi_analyzer/providers/connected_devices_provider.dart';
import 'package:rvi_analyzer/views/settings/device_settings/device_aditional_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeviceSettings extends StatefulWidget {
  DeviceSettings({Key? key}) : super(key: key);

  @override
  State<DeviceSettings> createState() => _DeviceSettingsState();
}

class _DeviceSettingsState extends State<DeviceSettings> {
  ScanResult? currentScanResult;

  void resetScanResult() {
    setState(() {
      currentScanResult = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Device Setting',
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 0, 12, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Connected Devices',
                  style: TextStyle(
                      fontSize: 14, color: Color.fromARGB(255, 148, 163, 184)),
                ),
                Consumer(
                  builder: (context, ref, child) {
                    return ListBody(
                      children: [
                        Column(
                          children: <Widget>[
                            for (ScanResult device in ref
                                .watch(deviceManagementState)
                                .connectedBlueDeviceList
                                .values)
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: ListTile(
                                  onTap: () {
                                    setState(() {
                                      currentScanResult = device;
                                    });
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  tileColor:
                                      const Color.fromARGB(132, 76, 75, 75),
                                  title: Text(device.device.name,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255))),
                                ),
                              ),
                          ],
                        )
                      ],
                    );
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                currentScanResult != null
                    ? DeviceAdditionalSettings(
                        scanResult: currentScanResult!,
                        resetScanResult: resetScanResult,
                      )
                    : const SizedBox.shrink()
              ],
            )),
      ),
      bottomNavigationBar: currentScanResult != null
          ? Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                height: 60,
                child: CupertinoButton.filled(
                  disabledColor: Colors.grey,
                  onPressed: () {},
                  child: const Text('Save Changes',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 253, 253))),
                ),
              ))
          : const SizedBox.shrink(),
    );
  }
}
