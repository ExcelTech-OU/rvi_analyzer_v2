import 'package:hive/hive.dart';
import 'package:rvi_analyzer/repository/adapter/common_adapter.dart';
import 'package:rvi_analyzer/repository/entity/common_entity.dart';
import 'package:rvi_analyzer/repository/entity/mode_four_entity.dart';

class ModeFourAdapter extends TypeAdapter<ModeFour> {
  @override
  final int typeId = 11;

  @override
  ModeFour read(BinaryReader reader) {
    return ModeFour(
      createdBy: reader.readString(),
      defaultConfigurations: reader.read(DefaultConfigurationAdapter().typeId)
          as DefaultConfiguration,
      sessionConfigurationModeFour:
          reader.read(SessionConfigurationModeFourAdapter().typeId)
              as SessionConfigurationModeFour,
      results: reader.read(SessionResultAdapter().typeId) as SessionResult,
      status: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, ModeFour obj) {
    writer.writeString(obj.createdBy);
    writer.write(obj.defaultConfigurations);
    writer.write(obj.sessionConfigurationModeFour);
    writer.write(obj.results);
    writer.writeString(obj.status);
  }
}

class SessionConfigurationModeFourAdapter
    extends TypeAdapter<SessionConfigurationModeFour> {
  @override
  final int typeId = 12;

  @override
  SessionConfigurationModeFour read(BinaryReader reader) {
    return SessionConfigurationModeFour(
      startingCurrent: reader.readString(),
      desiredCurrent: reader.readString(),
      maxVoltage: reader.readString(),
      currentResolution: reader.readString(),
      chargeInTime: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, SessionConfigurationModeFour obj) {
    writer.writeString(obj.startingCurrent);
    writer.writeString(obj.desiredCurrent);
    writer.writeString(obj.maxVoltage);
    writer.writeString(obj.currentResolution);
    writer.writeString(obj.chargeInTime);
  }
}
