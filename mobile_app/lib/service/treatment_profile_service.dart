import 'package:rvi_analyzer/common/key_box.dart';
import 'package:rvi_analyzer/domain/profile.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<Map<String, Profile>> getInitialProfileData() async {
  const storage = FlutterSecureStorage();
  Map<String, Profile> profiles = {};
  String? profile01 = await storage.read(key: profile01K);
  String? profile02 = await storage.read(key: profile02K);
  String? profile03 = await storage.read(key: profile03K);
  if (profile01 == null) {
    storage.write(
        key: profile01K,
        value: serializeProfile(
            Profile(temId: 0, treatmentTime: 1, painLevel: 2)));
    profiles.putIfAbsent(profile01K, () => deSerializeProfile("0:1:2"));
  } else {
    profiles.putIfAbsent(profile01K, () => deSerializeProfile(profile01));
  }
  if (profile02 == null) {
    storage.write(
        key: profile02K,
        value: serializeProfile(
            Profile(temId: 1, treatmentTime: 1, painLevel: 2)));
    profiles.putIfAbsent(profile02K, () => deSerializeProfile("1:1:2"));
  } else {
    profiles.putIfAbsent(profile02K, () => deSerializeProfile(profile02));
  }
  if (profile03 == null) {
    storage.write(
        key: profile03K,
        value: serializeProfile(
            Profile(temId: 2, treatmentTime: 1, painLevel: 2)));
    profiles.putIfAbsent(profile03K, () => deSerializeProfile("2:1:2"));
  } else {
    profiles.putIfAbsent(profile03K, () => deSerializeProfile(profile03));
  }

  return profiles;
}

Future<void> saveProfile(Profile profile, String key) async {
  const storage = FlutterSecureStorage();
  storage.write(key: key, value: serializeProfile(profile));
}

String serializeProfile(Profile profile) {
  return "${profile.temId}:${profile.treatmentTime}:${profile.painLevel}";
}

Profile deSerializeProfile(String profileString) {
  List<String> values = profileString.split(":");
  return Profile(
      temId: int.parse(values[0]),
      treatmentTime: int.parse(values[1]),
      painLevel: int.parse(values[2]));
}
