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

    final modeThreesLength = reader.readInt();
    final modeThrees =
        List<ModeThree>.generate(modeThreesLength, (_) => reader.read());

    final modeFoursLength = reader.readInt();
    final modeFours =
        List<ModeFour>.generate(modeFoursLength, (_) => reader.read());

    final modeFivesLength = reader.readInt();
    final modeFives =
        List<ModeFive>.generate(modeFivesLength, (_) => reader.read());

    final modeSixsLength = reader.readInt();
    final modeSixs =
        List<ModeSix>.generate(modeSixsLength, (_) => reader.read());

    return ModeInfo(username, modeOnes, modeTwos, modeThrees, modeFours,
        modeFives, modeSixs);
  }

  @override
  void write(BinaryWriter writer, ModeInfo obj) {
    writer.writeString(obj.username);

    writer.writeInt(obj.modeOnes.length);
    obj.modeOnes.forEach(writer.write);

    writer.writeInt(obj.modeTwos.length);
    obj.modeTwos.forEach(writer.write);

    writer.writeInt(obj.modeThrees.length);
    obj.modeThrees.forEach(writer.write);

    writer.writeInt(obj.modeFours.length);
    obj.modeFours.forEach(writer.write);

    writer.writeInt(obj.modeFives.length);
    obj.modeFives.forEach(writer.write);

    writer.writeInt(obj.modeSixs.length);
    obj.modeSixs.forEach(writer.write);
  }
}
