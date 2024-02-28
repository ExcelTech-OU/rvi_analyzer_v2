import 'dart:collection';

import 'package:flutter_blue/flutter_blue.dart';

class DeviceListDropAndPopUpData {
  final String title;
  final HashMap<String, ScanResult> items;
  final void Function(ScanResult) updateConnectDevices;
  final void Function() popupClose;
  final void Function(List<ScanResult>) forceClose;
  final int defaultIndex;

  DeviceListDropAndPopUpData(this.title, this.items, this.updateConnectDevices,
      this.defaultIndex, this.popupClose, this.forceClose);
}
