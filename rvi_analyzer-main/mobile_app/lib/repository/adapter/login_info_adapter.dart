import 'package:hive/hive.dart';
import 'package:rvi_analyzer/repository/entity/login_info.dart';

class LoginInfoAdapter extends TypeAdapter<LoginInfo> {
  @override
  LoginInfo read(BinaryReader reader) {
    final username = reader.readString();
    final jwt = reader.readString();
    return LoginInfo(username, jwt);
  }

  @override
  void write(BinaryWriter writer, LoginInfo obj) {
    writer.writeString(obj.username);
    writer.writeString(obj.jwt);
  }

  @override
  final typeId = 0;
}
