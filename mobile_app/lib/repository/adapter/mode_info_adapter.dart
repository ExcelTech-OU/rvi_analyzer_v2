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
    final modeOnes = reader.readList().cast<ModeOne>();
    // final modeTwos = reader.readList().cast<ModeTwo>();
    // final modeThrees = reader.readList().cast<ModeThree>();
    // final modeFours = reader.readList().cast<ModeFour>();
    // final modeFives = reader.readList().cast<ModeFive>();
    // final modeSixs = reader.readList().cast<ModeSix>();

    return ModeInfo(username, modeOnes, [], [], [], [], []);
  }

  @override
  void write(BinaryWriter writer, ModeInfo obj) {
    writer.writeString(obj.username);
    writer.writeList(obj.modeOnes);
    // writer.writeList(obj.modeTwos, writeLength: true);
    // writer.writeList(obj.modeThrees, writeLength: true);
    // writer.writeList(obj.modeFours, writeLength: true);
    // writer.writeList(obj.modeFives, writeLength: true);
    // writer.writeList(obj.modeSixs, writeLength: true);
  }
}
