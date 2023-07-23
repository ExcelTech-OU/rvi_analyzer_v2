import 'package:hive/hive.dart';
import 'package:rvi_analyzer/repository/entity/common_entity.dart';
import 'package:rvi_analyzer/repository/entity/mode_six_entity.dart';

class ModeSixAdapter extends TypeAdapter<ModeSix> {
  @override
  final int typeId = 15;

  @override
  ModeSix read(BinaryReader reader) {
    final createdBy = reader.readString();
    final defaultConfigurations = DefaultConfiguration(
      customerName: reader.readString(),
      operatorId: reader.readString(),
      batchNo: reader.readString(),
      serialNo: reader.readString(),
      sessionId: reader.readString(),
    );
    final sessionConfigurationModeSix = SessionConfigurationModeSix(
      fixedCurrent: reader.readString(),
      maxVoltage: reader.readString(),
      timeDuration: reader.readString(),
    );

    final results = List<SessionResult>.generate(1, (_) => reader.read());

    final status = reader.readString();

    return ModeSix(
      createdBy: createdBy,
      defaultConfigurations: defaultConfigurations,
      sessionConfigurationModeSix: sessionConfigurationModeSix,
      results: results.first,
      status: status,
    );
  }

  @override
  void write(BinaryWriter writer, ModeSix obj) {
    writer.writeString(obj.createdBy);

    writer.writeString(obj.defaultConfigurations.customerName);
    writer.writeString(obj.defaultConfigurations.operatorId);
    writer.writeString(obj.defaultConfigurations.batchNo);
    writer.writeString(obj.defaultConfigurations.serialNo);
    writer.writeString(obj.defaultConfigurations.sessionId);

    writer.writeString(obj.sessionConfigurationModeSix.fixedCurrent);
    writer.writeString(obj.sessionConfigurationModeSix.maxVoltage);
    writer.writeString(obj.sessionConfigurationModeSix.timeDuration);
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
