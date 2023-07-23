import 'package:hive/hive.dart';
import 'package:rvi_analyzer/repository/entity/mode_five_entity.dart';
import 'package:rvi_analyzer/repository/entity/mode_four_entity.dart';
import 'package:rvi_analyzer/repository/entity/mode_info.dart';
import 'package:rvi_analyzer/repository/entity/mode_one_entity.dart';
import 'package:rvi_analyzer/repository/entity/mode_six_entity.dart';
import 'package:rvi_analyzer/repository/entity/mode_three_entity.dart';
import 'package:rvi_analyzer/repository/entity/mode_two_entity.dart';

@HiveType(typeId: 17)
class ModeInfoAdapter extends TypeAdapter<ModeInfo> {
  @override
  final int typeId = 17;

  @override
  ModeInfo read(BinaryReader reader) {
    final username = reader.readString();

    final modeOnesLength = reader.readInt();
    final modeOnes =
        List<ModeOne>.generate(modeOnesLength, (_) => reader.read());

    final modeTwosLength = reader.readInt();
    final modeTwos =
        List<ModeTwo>.generate(modeTwosLength, (_) => reader.read());

    return ModeInfo(username, modeOnes, modeTwos, [], [], [], []);
  }

  @override
  void write(BinaryWriter writer, ModeInfo obj) {
    writer.writeString(obj.username);

    writer.writeInt(obj.modeOnes.length);
    obj.modeOnes.forEach(writer.write);

    writer.writeInt(obj.modeTwos.length);
    obj.modeTwos.forEach(writer.write);
  }
}
