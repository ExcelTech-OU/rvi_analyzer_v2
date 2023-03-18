import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class DeviceListTile extends StatefulWidget {
  final ScanResult scanResult;
  final void Function(ScanResult, bool) updateDeviceToList;
  const DeviceListTile(
      {Key? key, required this.scanResult, required this.updateDeviceToList})
      : super(key: key);

  @override
  State<DeviceListTile> createState() =>
      _DeviceListTileState(scanResult, updateDeviceToList);
}

class _DeviceListTileState extends State<DeviceListTile> {
  ScanResult scanResult;
  void Function(ScanResult, bool) updateDeviceToList;

  _DeviceListTileState(this.scanResult, this.updateDeviceToList);

  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
            color: isSelected
                ? const Color.fromARGB(255, 34, 197, 94)
                : Colors.white),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              flex: 3,
              child: Image(
                image: isSelected
                    ? const AssetImage(
                        'assets/images/device_icon_connected.png')
                    : const AssetImage(
                        'assets/images/device_icon_disconnected.png'),
                width: 60,
                height: 55,
              )),
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Expanded(
            flex: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(scanResult.device.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Color.fromARGB(255, 255, 254, 254))),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: isSelected
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                    child: const Icon(
                      Icons.check_circle_sharp,
                      color: Colors.lightGreen,
                      size: 28,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                    child: const Icon(
                      Icons.circle_outlined,
                      size: 28,
                      color: Color.fromARGB(190, 101, 101, 101),
                    ),
                  ),
          ),
        ],
      ),
      tileColor: const Color.fromARGB(255, 30, 41, 59),
      onTap: () => {
        setState(() {
          isSelected = !isSelected;
        }),
        updateDeviceToList(scanResult, isSelected),
      },
    );
  }
}
