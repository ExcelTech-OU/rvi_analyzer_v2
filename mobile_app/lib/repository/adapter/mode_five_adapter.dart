import 'package:hive/hive.dart';
import 'package:rvi_analyzer/repository/adapter/common_adapter.dart';
import 'package:rvi_analyzer/repository/entity/common_entity.dart';
import 'package:rvi_analyzer/repository/entity/mode_five_entity.dart';

class ModeFiveAdapter extends TypeAdapter<ModeFive> {
  @override
  final int typeId = 13;

  @override
  ModeFive read(BinaryReader reader) {
    return ModeFive(
      createdBy: reader.readString(),
      defaultConfigurations: reader.read(DefaultConfigurationAdapter().typeId)
          as DefaultConfiguration,
      sessionConfigurationModeFive:
          reader.read(SessionConfigurationModeFiveAdapter().typeId)
              as SessionConfigurationModeFive,
      results: reader.read(SessionResultAdapter().typeId) as SessionResult,
      status: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, ModeFive obj) {
    writer.writeString(obj.createdBy);
    writer.write(obj.defaultConfigurations);
    writer.write(obj.sessionConfigurationModeFive);
    writer.write(obj.results);
    writer.writeString(obj.status);
  }
}

class SessionConfigurationModeFiveAdapter
    extends TypeAdapter<SessionConfigurationModeFive> {
  @override
  final int typeId = 14;

  @override
  SessionConfigurationModeFive read(BinaryReader reader) {
    return SessionConfigurationModeFive(
      fixedVoltage: reader.readString(),
      maxCurrent: reader.readString(),
      timeDuration: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, SessionConfigurationModeFive obj) {
    writer.writeString(obj.fixedVoltage);
    writer.writeString(obj.maxCurrent);
    writer.writeString(obj.timeDuration);
  }
}
