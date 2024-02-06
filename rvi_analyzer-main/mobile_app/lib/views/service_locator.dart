import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:rvi_analyzer/service/common_service.dart';

// ambient variable to access the service locator
GetIt sl = GetIt.instance;

void setup() {
  sl.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());
  sl.registerSingleton<CommonService>(CommonService());
}
