import 'package:hive/hive.dart';
import 'package:rvi_analyzer/repository/entity/connected_devices_info.dart';

class ConnectedDevicesInfoAdapter extends TypeAdapter<ConnectedDevicesInfo> {
  @override
  ConnectedDevicesInfo read(BinaryReader reader) {
    final username = reader.readString();
    final devicesNames = reader.readStringList();
    return ConnectedDevicesInfo(username, devicesNames);
  }

  @override
  void write(BinaryWriter writer, ConnectedDevicesInfo obj) {
    writer.writeString(obj.username);
    writer.writeStringList(obj.devicesMacs);
  }

  @override
  final typeId = 1;
}
