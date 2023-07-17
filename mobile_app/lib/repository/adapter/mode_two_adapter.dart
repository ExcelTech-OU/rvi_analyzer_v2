import 'package:hive/hive.dart';
import 'package:rvi_analyzer/repository/adapter/common_adapter.dart';
import 'package:rvi_analyzer/repository/entity/common_entity.dart';
import 'package:rvi_analyzer/repository/entity/mode_two_entity.dart';

class ModeTwoAdapter extends TypeAdapter<ModeTwo> {
  @override
  final int typeId = 7;

  @override
  ModeTwo read(BinaryReader reader) {
    return ModeTwo(
      createdBy: reader.readString(),
      defaultConfigurations: reader.read(DefaultConfigurationAdapter().typeId)
          as DefaultConfiguration,
      sessionConfigurationModeTwo:
          reader.read(SessionConfigurationModeTwoAdapter().typeId)
              as SessionConfigurationModeTwo,
      results:
          reader.readList(reader.readByteList().length).cast<SessionResult>(),
      status: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, ModeTwo obj) {
    writer.writeString(obj.createdBy);
    writer.write(obj.defaultConfigurations);
    writer.write(obj.sessionConfigurationModeTwo);
    writer.writeList(obj.results, writeLength: true);
    writer.writeString(obj.status);
  }
}

class SessionConfigurationModeTwoAdapter
    extends TypeAdapter<SessionConfigurationModeTwo> {
  @override
  final int typeId = 8;

  @override
  SessionConfigurationModeTwo read(BinaryReader reader) {
    return SessionConfigurationModeTwo(
      current: reader.readString(),
      maxVoltage: reader.readString(),
      passMinVoltage: reader.readString(),
      passMaxVoltage: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, SessionConfigurationModeTwo obj) {
    writer.writeString(obj.current);
    writer.writeString(obj.maxVoltage);
    writer.writeString(obj.passMinVoltage);
    writer.writeString(obj.passMaxVoltage);
  }
}
