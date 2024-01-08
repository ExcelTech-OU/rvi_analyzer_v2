import 'package:rvi_analyzer/domain/configure_data.dart';
import 'package:flutter_blue/flutter_blue.dart';

class RunningTreatmentData {
  String userName;
  TreatmentConfig config;
  ScanResult scanResult;
  RunningTreatmentData(
      {required this.userName, required this.config, required this.scanResult});
}
