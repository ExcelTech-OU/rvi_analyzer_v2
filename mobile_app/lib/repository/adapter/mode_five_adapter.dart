import 'package:hive/hive.dart';
import 'package:rvi_analyzer/repository/entity/common_entity.dart';
import 'package:rvi_analyzer/repository/entity/mode_five_entity.dart';

class ModeFiveAdapter extends TypeAdapter<ModeFive> {
  @override
  final int typeId = 13;

  @override
  ModeFive read(BinaryReader reader) {
    final createdBy = reader.readString();
    final defaultConfigurations = DefaultConfiguration(
      customerName: reader.readString(),
      operatorId: reader.readString(),
      batchNo: reader.readString(),
      serialNo: reader.readString(),
      sessionId: reader.readString(),
    );
    final sessionConfigurationModeFive = SessionConfigurationModeFive(
      fixedVoltage: reader.readString(),
      maxCurrent: reader.readString(),
      timeDuration: reader.readString(),
    );

    final results = List<SessionResult>.generate(1, (_) => reader.read());

    final status = reader.readString();

    return ModeFive(
      createdBy: createdBy,
      defaultConfigurations: defaultConfigurations,
      sessionConfigurationModeFive: sessionConfigurationModeFive,
      results: results.first,
      status: status,
    );
  }

  @override
  void write(BinaryWriter writer, ModeFive obj) {
    writer.writeString(obj.createdBy);

    writer.writeString(obj.defaultConfigurations.customerName);
    writer.writeString(obj.defaultConfigurations.operatorId);
    writer.writeString(obj.defaultConfigurations.batchNo);
    writer.writeString(obj.defaultConfigurations.serialNo);
    writer.writeString(obj.defaultConfigurations.sessionId);

    writer.writeString(obj.sessionConfigurationModeFive.fixedVoltage);
    writer.writeString(obj.sessionConfigurationModeFive.maxCurrent);
    writer.writeString(obj.sessionConfigurationModeFive.timeDuration);

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
