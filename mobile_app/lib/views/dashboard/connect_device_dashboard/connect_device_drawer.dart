import 'package:flutter/material.dart';

import 'package:rvi_analyzer/views/dashboard/device_list_popup.dart';
import 'package:rvi_analyzer/views/settings/connected_devices.dart';

class ConnectDeviceDrawer extends StatelessWidget {
  const ConnectDeviceDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DeviceListPopup deviceList = DeviceListPopup();
    return Column(
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(color: Color.fromARGB(255, 0, 0, 0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    'Settings',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 25.0),
                  ),
                ],
              )
            ],
          ),
        ),
        ListTile(
          leading: const Icon(Icons.add),
          title: const Text('Add new device', style: TextStyle(fontSize: 18)),
          onTap: () {
            Navigator.of(context).pop();
            deviceList.showMyDialog(context);
          },
        ),
        const Divider(height: 3.0),
        ListTile(
          leading: const Icon(Icons.connect_without_contact),
          title:
              const Text('Connected devices', style: TextStyle(fontSize: 18)),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ConnectedDevices()));
          },
        ),
        const Divider(height: 3.0),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Account settings', style: TextStyle(fontSize: 18)),
          onTap: () {
            Navigator.of(context).pop();
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => const AccountSettings()));
          },
        ),
      ],
    );
  }
}
