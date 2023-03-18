import 'package:rvi_analyzer/views/dashboard/device_scan/device_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:rvi_analyzer/views/dashboard/device_list_popup.dart';
import 'package:rvi_analyzer/views/dashboard/connect_device_dashboard/device_card.dart';
import 'package:rvi_analyzer/providers/connected_devices_provider.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class AddDeviceDashBoardPage extends ConsumerStatefulWidget {
  const AddDeviceDashBoardPage({Key? key}) : super(key: key);

  @override
  ConsumerState<AddDeviceDashBoardPage> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends ConsumerState<AddDeviceDashBoardPage> {
  DeviceListPopup deviceList = DeviceListPopup();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 2, 2, 2),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Expanded(
                  flex: 1,
                  child: Text(
                    'Connected Devices',
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Expanded(
                  flex: 1,
                  child: Text(
                    'Please select device to continue',
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ),
                Expanded(
                  flex: 12,
                  child: Consumer(builder: ((context, ref, child) {
                    return Align(
                        alignment: FractionalOffset.center,
                        child: (ref
                                .watch(deviceManagementState)
                                .connectedBlueDeviceList
                                .isEmpty)
                            ? InkWell(
                                child: Container(
                                  width: width,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        "You didn't setup any device yet",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Tap here to Scan",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  PersistentNavBarNavigator.pushNewScreen(
                                    context,
                                    screen: DeviceScanPage(),
                                    withNavBar: false,
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.cupertino,
                                  );
                                },
                              )
                            : SafeArea(
                                child: Column(
                                  children: <Widget>[
                                    for (var i in ref
                                        .watch(deviceManagementState)
                                        .connectedBlueDeviceList
                                        .values)
                                      DeviceCardHomePage(
                                        scanResult: i,
                                      ),
                                  ],
                                ),
                              ));
                  })),
                ),
                Expanded(flex: 1, child: Container())
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: ref
              .watch(deviceManagementState)
              .connectedBlueDeviceList
              .isEmpty
          ? const SizedBox.shrink()
          : Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 15, 12),
              child: FloatingActionButton(
                onPressed: () {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: DeviceScanPage(),
                    withNavBar: false,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                  // deviceList.showMyDialog(context);
                },
                backgroundColor: Colors.green,
                child: const Icon(Icons.add),
              ),
            ),
    );
  }
}
