import 'package:rvi_analyzer/domain/configure_data.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class RunningTreatmentData {
  String userName;
  TreatmentConfig config;
  ScanResult scanResult;
  RunningTreatmentData(
      {required this.userName, required this.config, required this.scanResult});
}
