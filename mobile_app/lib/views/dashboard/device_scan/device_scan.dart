import 'package:rvi_analyzer/domain/device_list_drop_and_popup_data.dart';
import 'package:rvi_analyzer/views/dashboard/dashboard.dart';
import 'package:rvi_analyzer/views/dashboard/device_scan/pop_up_device_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:rvi_analyzer/providers/connected_devices_provider.dart';
import 'package:rvi_analyzer/service/flutter_blue_service_impl.dart';
import 'package:rvi_analyzer/views/common/sprite_painter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class DeviceScanPage extends ConsumerStatefulWidget {
  DeviceScanPage({Key? key}) : super(key: key);

  @override
  ConsumerState<DeviceScanPage> createState() => _DeviceScanPageState();
}

class _DeviceScanPageState extends ConsumerState<DeviceScanPage>
    with TickerProviderStateMixin {
  bool scanning = true;
  Blue blue = Blue();
  bool forceClose = false;
  bool isFunCalled = false;
  DeviceListPopUpV2 deviceListPopUpV2 = DeviceListPopUpV2();

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
    );
    _controller
      ..stop()
      ..reset()
      ..repeat(period: const Duration(milliseconds: 700));
    blue.scanDevices().then(
        (value) => {ref.read(deviceManagementState).addAvailableDevice(value)});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _stopAnimation() {
    _controller..stop();
  }

  void _startAnimation() {
    _controller
      ..stop()
      ..reset()
      ..repeat(period: const Duration(milliseconds: 700));
  }

  void setDropDownIndex(ScanResult scanResult) {}

  void updatePopupClose() {
    setState(() {
      scanning = false;
    });
  }

  void updateForceClose(List<ScanResult> scanList) {
    setState(() {
      forceClose = true;
    });
    for (var element in scanList) {
      ref.read(deviceManagementState).updateAvailable(element);
    }
    Navigator.pop(context);
    PersistentNavBarNavigator.pushNewScreen(
      context,
      screen: DashboardPage(
        initialIndex: 1,
      ),
      withNavBar: false,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<ConnectedDevicesProvider>(deviceManagementState,
        ((previous, next) {
      if (next.availableDeviceList.isNotEmpty) {
        if (!forceClose) {
          deviceListPopUpV2.showMyDialog(
              context,
              DeviceListDropAndPopUpData(
                  "Available Devices",
                  next.availableDeviceList,
                  setDropDownIndex,
                  1,
                  updatePopupClose,
                  updateForceClose));

          // showCupertinoModalBottomSheet(
          //   expand: false,
          //   context: context,
          //   isDismissible: false,
          //   barrierColor: const Color.fromARGB(178, 0, 0, 0),
          //   builder: (context) => DropDownCustomDeviceList(
          //       DropDownCustomDeviceListData(
          //           "Available Devices",
          //           next.availableDeviceList,
          //           setDropDownIndex,
          //           1,
          //           updatePopupClose,
          //           updateForceClose)),
          // );
        }
        _stopAnimation();
      }
    }));
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(14.0),
                child: Text(
                  'Bluetooth Scan',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255)),
                ),
              ),
              scanning
                  ? Column(
                      children: [
                        const SizedBox(
                          height: 150,
                        ),
                        SizedBox(
                            height: 150,
                            width: width - 10,
                            child: Center(
                                child: Stack(
                              children: [
                                Center(
                                  child: CustomPaint(
                                    painter: SpritePainter(_controller),
                                    child: SizedBox(
                                      width: width - 10,
                                    ),
                                  ),
                                ),
                                const Center(
                                  child: Icon(
                                    Icons.bluetooth,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ))),
                      ],
                    )
                  : SizedBox(
                      height: height - 150,
                      width: width - 10,
                      child: InkWell(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "You didn't connected any device",
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
                              "Tap here to Scan Again",
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            scanning = !scanning;
                          });
                          _startAnimation();
                          blue.scanDevices().then((value) => {
                                ref
                                    .read(deviceManagementState)
                                    .addAvailableDevice(value)
                              });
                        },
                      ),
                    ),
              scanning
                  ? const Padding(
                      padding: EdgeInsets.only(top: 150),
                      child: Center(
                        child: Text(
                          'Scanning for devices..',
                          // ignore: unnecessary_const
                          style: TextStyle(
                              fontSize: 12,
                              color: Color.fromARGB(255, 148, 163, 184)),
                        ),
                      ))
                  : const SizedBox.shrink(),
              scanning ? const SizedBox.shrink() : const SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}
