import 'package:hive/hive.dart';
import 'package:rvi_analyzer/repository/entity/common_entity.dart';
import 'package:rvi_analyzer/repository/entity/mode_four_entity.dart';

class ModeFourAdapter extends TypeAdapter<ModeFour> {
  @override
  final int typeId = 11;

  @override
  ModeFour read(BinaryReader reader) {
    final createdBy = reader.readString();
    final defaultConfigurations = DefaultConfiguration(
      customerName: reader.readString(),
      operatorId: reader.readString(),
      batchNo: reader.readString(),
      serialNo: reader.readString(),
      sessionId: reader.readString(),
    );
    final sessionConfigurationModeFour = SessionConfigurationModeFour(
      startingCurrent: reader.readString(),
      desiredCurrent: reader.readString(),
      maxVoltage: reader.readString(),
      currentResolution: reader.readString(),
      chargeInTime: reader.readString(),
    );

    final results = List<SessionResult>.generate(1, (_) => reader.read());

    final status = reader.readString();

    return ModeFour(
      createdBy: createdBy,
      defaultConfigurations: defaultConfigurations,
      sessionConfigurationModeFour: sessionConfigurationModeFour,
      results: results.first,
      status: status,
    );
  }

  @override
  void write(BinaryWriter writer, ModeFour obj) {
    writer.writeString(obj.createdBy);

    writer.writeString(obj.defaultConfigurations.customerName);
    writer.writeString(obj.defaultConfigurations.operatorId);
    writer.writeString(obj.defaultConfigurations.batchNo);
    writer.writeString(obj.defaultConfigurations.serialNo);
    writer.writeString(obj.defaultConfigurations.sessionId);

    writer.writeString(obj.sessionConfigurationModeFour.startingCurrent);
    writer.writeString(obj.sessionConfigurationModeFour.desiredCurrent);
    writer.writeString(obj.sessionConfigurationModeFour.maxVoltage);
    writer.writeString(obj.sessionConfigurationModeFour.currentResolution);
    writer.writeString(obj.sessionConfigurationModeFour.chargeInTime);

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
