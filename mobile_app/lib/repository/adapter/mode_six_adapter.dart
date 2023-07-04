import 'package:hive/hive.dart';
import 'package:rvi_analyzer/repository/adapter/common_adapter.dart';
import 'package:rvi_analyzer/repository/entity/common_entity.dart';
import 'package:rvi_analyzer/repository/entity/mode_six_entity.dart';

class ModeSixAdapter extends TypeAdapter<ModeSix> {
  @override
  final int typeId = 15;

  @override
  ModeSix read(BinaryReader reader) {
    return ModeSix(
      createdBy: reader.readString(),
      defaultConfigurations: reader.read(DefaultConfigurationAdapter().typeId)
          as DefaultConfiguration,
      sessionConfigurationModeSix:
          reader.read(SessionConfigurationModeSixAdapter().typeId)
              as SessionConfigurationModeSix,
      results: reader.read(SessionResultAdapter().typeId) as SessionResult,
      status: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, ModeSix obj) {
    writer.writeString(obj.createdBy);
    writer.write(obj.defaultConfigurations);
    writer.write(obj.sessionConfigurationModeSix);
    writer.write(obj.results);
    writer.writeString(obj.status);
  }
}

class SessionConfigurationModeSixAdapter
    extends TypeAdapter<SessionConfigurationModeSix> {
  @override
  final int typeId = 16;

  @override
  SessionConfigurationModeSix read(BinaryReader reader) {
    return SessionConfigurationModeSix(
      fixedCurrent: reader.readString(),
      maxVoltage: reader.readString(),
      timeDuration: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, SessionConfigurationModeSix obj) {
    writer.writeString(obj.fixedCurrent);
    writer.writeString(obj.maxVoltage);
    writer.writeString(obj.timeDuration);
  }
}
