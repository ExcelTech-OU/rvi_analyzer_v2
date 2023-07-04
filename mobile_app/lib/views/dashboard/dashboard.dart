import 'dart:async';

import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:rvi_analyzer/common/key_box.dart';
import 'package:rvi_analyzer/providers/bluetooth_status_provider.dart';
import 'package:rvi_analyzer/providers/connected_devices_provider.dart';
import 'package:rvi_analyzer/providers/device_state_provider.dart';
import 'package:rvi_analyzer/service/flutter_blue_service_impl.dart';
import 'package:rvi_analyzer/views/common/bluetooth_device_disconnected_popup.dart';
import 'package:rvi_analyzer/views/common/bluetooth_disconnected_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rvi_analyzer/views/dashboard/connect_device_dashboard/device_card.dart';
import 'package:rvi_analyzer/views/history/history_summary.dart';
import 'package:rvi_analyzer/views/history/modes/mode_one_view.dart';

class DashboardPage extends ConsumerStatefulWidget {
  int initialIndex = 0;
  DashboardPage({Key? key, required this.initialIndex}) : super(key: key);

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  bool blueToothDisconnectPopup = false;
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  Blue blue = Blue();
  void _doSomething() async {
    ref.watch(deviceManagementState).clearAvailableDeviceList();
    blue.scanDevices().then((value) => {
          ref.read(deviceManagementState).addAvailableDevice(value),
          _btnController.reset()
        });
  }

  Future<String?> getJwt() async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: jwtK);
  }

  @override
  void initState() {
    super.initState();
    ref.read(deviceBluetoothState).activeNotifyStreamListener();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    ref.listen<BluetoothStatus>(deviceBluetoothState, ((previous, next) {
      getJwt().then((value) => {
            if (value != null)
              {
                if (next.state == 'off')
                  {
                    BluetoothDisconnectionState.closeDialog = false,
                    BluetoothDisconnectionState.showAlertDialog(ref),
                    setState(() {
                      blueToothDisconnectPopup = true;
                    })
                  }
                else
                  {
                    BluetoothDisconnectionState.closeDialog = true,
                    setState(() {
                      blueToothDisconnectPopup = false;
                    })
                  }
              }
          });
    }));

    for (var element in deviceConnectionStatusMap.entries) {
      ref.listen<BluetoothDeviceStatus>(element.value, ((previous, next) {
        if (next.state == 'disconnected' && !blueToothDisconnectPopup) {
          getJwt().then((value) => {
                if (value != null)
                  {
                    BluetoothDeviceDisconnectedPopup.showAlertDialog(
                        ref, ref.read(element.value.notifier).scanResult!)
                  }
              });
        }
      }));
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: isLandscape
              ? Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Row(
                    children: [
                      SizedBox(
                        width: width < 600 ? width : (width / 2) - 32,
                        child: SizedBox(
                          height: height - 65,
                          child: Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(250, 8, 41, 59),
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 5,
                                    offset: const Offset(
                                        0, 0.5), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(30.0),
                                child: Image(
                                    image:
                                        AssetImage('assets/images/logo.png')),
                              )),
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: width < 600 ? width : (width / 2) - 32,
                        child: SizedBox(
                          height: height - 65,
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 5,
                                    offset: const Offset(
                                        0, 0.5), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: height - 130,
                                    child: Scrollbar(
                                        child: ListView.builder(
                                            itemCount: 1,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Align(
                                                  alignment:
                                                      FractionalOffset.center,
                                                  child: (ref
                                                              .watch(
                                                                  deviceManagementState)
                                                              .availableDeviceList
                                                              .isEmpty &&
                                                          ref
                                                              .watch(
                                                                  deviceManagementState)
                                                              .connectedBlueDeviceList
                                                              .isEmpty)
                                                      ? SizedBox(
                                                          width: width,
                                                          height: height - 150,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                "You didn't setup any device yet",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                          .grey[
                                                                      600],
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 16,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      : SafeArea(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              ref
                                                                      .watch(
                                                                          deviceManagementState)
                                                                      .connectedBlueDeviceList
                                                                      .isEmpty
                                                                  ? const SizedBox
                                                                      .shrink()
                                                                  : Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        const Text(
                                                                          "Connected Devices",
                                                                          style: TextStyle(
                                                                              color: Colors.grey,
                                                                              fontSize: 18,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        for (var i in ref
                                                                            .watch(deviceManagementState)
                                                                            .connectedBlueDeviceList
                                                                            .values)
                                                                          DeviceCardHomePage(
                                                                            scanResult:
                                                                                i,
                                                                          ),
                                                                        Row(
                                                                          children: const [
                                                                            Expanded(
                                                                              flex: 2,
                                                                              child: Divider(
                                                                                color: Color.fromARGB(255, 220, 220, 220),
                                                                                thickness: 2,
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                      ],
                                                                    ),
                                                              for (var i in ref
                                                                  .watch(
                                                                      deviceManagementState)
                                                                  .availableDeviceList
                                                                  .values)
                                                                DeviceCardHomePage(
                                                                  scanResult: i,
                                                                ),
                                                            ],
                                                          ),
                                                        ));
                                            })),
                                  ),
                                  const Spacer(),
                                  SizedBox(
                                    width: (width / 2) - 30,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: (width / 2) - 105,
                                          child: RoundedLoadingButton(
                                            // color:
                                            //     Color.fromARGB(250, 8, 41, 59),
                                            height: 55,
                                            width: (width / 2) - 80,
                                            borderRadius: 8,
                                            loaderStrokeWidth: 4,
                                            controller: _btnController,
                                            onPressed: _doSomething,
                                            child: const Text('Scan',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 25)),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        SizedBox(
                                          height: 52,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ModeOneView(
                                                            username:
                                                                "rukM@gmail.com",
                                                          )));
                                            },
                                            child: const Icon(
                                              Icons.settings,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )),
                        ),
                      ),
                    ],
                  ))
              : Center(
                  child: SizedBox(
                    width: width,
                    child: Container(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: height - 65,
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 5,
                                        offset: const Offset(0,
                                            0.5), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Scrollbar(
                                          child: Align(
                                              alignment:
                                                  FractionalOffset.center,
                                              child: (ref
                                                          .watch(
                                                              deviceManagementState)
                                                          .availableDeviceList
                                                          .isEmpty &&
                                                      ref
                                                          .watch(
                                                              deviceManagementState)
                                                          .connectedBlueDeviceList
                                                          .isEmpty)
                                                  ? SizedBox(
                                                      width: width,
                                                      height: height - 150,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            "You didn't setup any device yet",
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .grey[600],
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  : SafeArea(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          ref
                                                                  .watch(
                                                                      deviceManagementState)
                                                                  .connectedBlueDeviceList
                                                                  .isEmpty
                                                              ? const SizedBox
                                                                  .shrink()
                                                              : Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    const Text(
                                                                      "Connected Devices",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .grey,
                                                                          fontSize:
                                                                              18,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    for (var i in ref
                                                                        .watch(
                                                                            deviceManagementState)
                                                                        .connectedBlueDeviceList
                                                                        .values)
                                                                      DeviceCardHomePage(
                                                                        scanResult:
                                                                            i,
                                                                      ),
                                                                    Row(
                                                                      children: const [
                                                                        Expanded(
                                                                          flex:
                                                                              2,
                                                                          child:
                                                                              Divider(
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                220,
                                                                                220,
                                                                                220),
                                                                            thickness:
                                                                                2,
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                  ],
                                                                ),
                                                          for (var i in ref
                                                              .watch(
                                                                  deviceManagementState)
                                                              .availableDeviceList
                                                              .values)
                                                            DeviceCardHomePage(
                                                              scanResult: i,
                                                            ),
                                                        ],
                                                      ),
                                                    ))),
                                      const Spacer(),
                                      RoundedLoadingButton(
                                        height: 55,
                                        width: (width) - 10,
                                        borderRadius: 12,
                                        loaderStrokeWidth: 4,
                                        controller: _btnController,
                                        onPressed: _doSomething,
                                        child: const Text('Scan',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25)),
                                      )
                                    ],
                                  )),
                            ),
                          ],
                        )),
                  ),
                )),
    );
  }
}
