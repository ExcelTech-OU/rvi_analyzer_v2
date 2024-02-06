import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rvi_analyzer/views/service_locator.dart';

class SettingsVal {
  final double zoomVal;
  final bool flashVal;
  final double scaleVal;

  SettingsVal(
      {required this.flashVal, required this.scaleVal, required this.zoomVal});
}

Future<SettingsVal> getZoomVal(
    String zoomKey, String scaleKey, String flashKey) async {
  bool flashVal = bool.parse(
      await sl.get<FlutterSecureStorage>().read(key: flashKey) ?? "false");
  double zoolLevel = double.parse(
      await sl.get<FlutterSecureStorage>().read(key: zoomKey) ?? "0.0");
  double scanAreaVal = double.parse(
      await sl.get<FlutterSecureStorage>().read(key: scaleKey) ?? "0.0");
  return SettingsVal(
      flashVal: flashVal, scaleVal: scanAreaVal, zoomVal: zoolLevel);
}
