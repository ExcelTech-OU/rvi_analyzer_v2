import 'package:hive/hive.dart';
import 'package:rvi_analyzer/repository/adapter/common_adapter.dart';
import 'package:rvi_analyzer/repository/entity/common_entity.dart';
import 'package:rvi_analyzer/repository/entity/mode_one_entity.dart';

class ModeOneAdapter extends TypeAdapter<ModeOne> {
  @override
  final typeId = 2;

  @override
  ModeOne read(BinaryReader reader) {
    final createdBy = reader.readString();
    final defaultConfigurations = reader
        .read(DefaultConfigurationAdapter().typeId) as DefaultConfiguration;
    final sessionConfigurationModeOne =
        reader.read(SessionConfigurationModeOneAdapter().typeId)
            as SessionConfigurationModeOne;
    final results =
        reader.readList(reader.readByteList().length).cast<SessionResult>();
    final status = reader.readString();

    return ModeOne(
      createdBy: createdBy,
      defaultConfigurations: defaultConfigurations,
      sessionConfigurationModeOne: sessionConfigurationModeOne,
      results: results,
      status: status,
    );
  }

  @override
  void write(BinaryWriter writer, ModeOne obj) {
    writer.writeString(obj.createdBy);
    writer.write(obj.defaultConfigurations);
    writer.write(obj.sessionConfigurationModeOne);
    writer.writeList(obj.results);
    writer.writeString(obj.status);
  }
}

class SessionConfigurationModeOneAdapter
    extends TypeAdapter<SessionConfigurationModeOne> {
  @override
  final typeId = 3;

  @override
  SessionConfigurationModeOne read(BinaryReader reader) {
    return SessionConfigurationModeOne(
      voltage: reader.readString(),
      maxCurrent: reader.readString(),
      passMinCurrent: reader.readString(),
      passMaxCurrent: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, SessionConfigurationModeOne obj) {
    writer.writeString(obj.voltage);
    writer.writeString(obj.maxCurrent);
    writer.writeString(obj.passMinCurrent);
    writer.writeString(obj.passMaxCurrent);
  }
}
