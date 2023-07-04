import 'package:hive/hive.dart';
import 'package:rvi_analyzer/repository/adapter/common_adapter.dart';
import 'package:rvi_analyzer/repository/entity/common_entity.dart';
import 'package:rvi_analyzer/repository/entity/mode_three_entity.dart';

class ModeThreeAdapter extends TypeAdapter<ModeThree> {
  @override
  final int typeId = 9;

  @override
  ModeThree read(BinaryReader reader) {
    return ModeThree(
      createdBy: reader.readString(),
      defaultConfigurations: reader.read(DefaultConfigurationAdapter().typeId)
          as DefaultConfiguration,
      sessionConfigurationModeThree:
          reader.read(SessionConfigurationModeThreeAdapter().typeId)
              as SessionConfigurationModeThree,
      results: reader.read(SessionResultAdapter().typeId) as SessionResult,
      status: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, ModeThree obj) {
    writer.writeString(obj.createdBy);
    writer.write(obj.defaultConfigurations);
    writer.write(obj.sessionConfigurationModeThree);
    writer.write(obj.results);
    writer.writeString(obj.status);
  }
}

class SessionConfigurationModeThreeAdapter
    extends TypeAdapter<SessionConfigurationModeThree> {
  @override
  final int typeId = 10;

  @override
  SessionConfigurationModeThree read(BinaryReader reader) {
    return SessionConfigurationModeThree(
      startingVoltage: reader.readString(),
      desiredVoltage: reader.readString(),
      maxCurrent: reader.readString(),
      voltageResolution: reader.readString(),
      chargeInTime: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, SessionConfigurationModeThree obj) {
    writer.writeString(obj.startingVoltage);
    writer.writeString(obj.desiredVoltage);
    writer.writeString(obj.maxCurrent);
    writer.writeString(obj.voltageResolution);
    writer.writeString(obj.chargeInTime);
  }
}
