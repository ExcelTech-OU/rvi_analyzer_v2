import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class ConnectedDevicesInfo extends HiveObject {
  @HiveField(0)
  String username;

  @HiveField(1)
  List<String> devicesMacs;

  ConnectedDevicesInfo(this.username, this.devicesMacs);
}
