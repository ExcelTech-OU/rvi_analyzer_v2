import 'package:hive/hive.dart';
import 'package:rvi_analyzer/repository/entity/login_info.dart';

class LoginInfoAdapter extends TypeAdapter<LoginInfo> {
  @override
  LoginInfo read(BinaryReader reader) {
    final username = reader.readString();
    final jwt = reader.readString();
    final group = reader.readString();
    return LoginInfo(username, jwt, group);
  }

  @override
  void write(BinaryWriter writer, LoginInfo obj) {
    writer.writeString(obj.username);
    writer.writeString(obj.jwt);
    writer.writeString(obj.group);
  }

  @override
  final typeId = 0;
}
