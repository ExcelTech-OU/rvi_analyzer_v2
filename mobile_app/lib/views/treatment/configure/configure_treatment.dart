import 'package:rvi_analyzer/common/custom_slider_theme/slider_gradiant_theme.dart';
import 'package:rvi_analyzer/common/custom_slider_theme/slider_thumb_theme.dart';
import 'package:rvi_analyzer/common/key_box.dart';
import 'package:rvi_analyzer/domain/profile.dart';
import 'package:rvi_analyzer/providers/device_state_provider.dart';
import 'package:rvi_analyzer/service/flutter_blue_service_impl.dart';
import 'package:rvi_analyzer/service/treatment_profile_service.dart';
import 'package:rvi_analyzer/views/common/drop_down.dart';
import 'package:rvi_analyzer/views/treatment/configure/save_profile_confirmation.dart';
import 'package:rvi_analyzer/views/treatment/configure/tem_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../domain/after_start_data.dart';
import '../../../domain/configure_data.dart';
import '../../../service/common_service.dart';

class ConfigureDashboard extends StatefulWidget {
  final ScanResult scanResult;
  const ConfigureDashboard(this.scanResult, {Key? key}) : super(key: key);

  @override
  State<ConfigureDashboard> createState() =>
      _ConfigureDashboardState(scanResult);
}

class _ConfigureDashboardState extends State<ConfigureDashboard> {
  final ScanResult scanResult;
  _ConfigureDashboardState(this.scanResult);

  //Params of configure pop-up
  late TreatmentConfig config;

  Blue blue = Blue();

  //tracking values for two popups
  bool isUserSelected = true;
  bool isTreatmentConfigured = false;

  bool profileTile01Selected = false;
  bool profileTile02Selected = false;
  bool profileTile03Selected = false;
  bool profileTile04Selected = false;

  bool ledTileSelected = true;
  int selectedProfileId = -1;
  int selectedTemId = -1;

  //params for select user
  String username = "Select User";

  double timeLevel = 1;
  double painLevel = 2;

  List<String> treatmentPositions = <String>[
    'Profile 01',
    'Profile 02',
    'Profile 03'
  ];

  Map<String, Profile> profiles = {};

  List<DropDownItem> items = [];

  @override
  void initState() {
    super.initState();
    isUserSelected = true;
    isTreatmentConfigured = false;

    if (treatmentPositions != null) {
      for (var item in treatmentPositions) {
        items.add(DropDownItem(item, null, treatmentPositions.indexOf(item)));
      }
    }

    config = TreatmentConfig(
        treatmentPosition: "One",
        temp: "Low",
        time: "",
        ledState: false,
        painLevel: 0,
        protocolId: 0,
        temId: 0,
        batteryLevel: 0);

    //Load profile data initial
    getInitialProfileData().then((value) => profiles = value);
  }

  void setConfigureTreatmentValues(TreatmentConfig config) {
    setState(() {
      this.config = config;
      isTreatmentConfigured = true;
    });
  }

  void setUserName(String username) {
    setState(() {
      this.username = username;
      isUserSelected = true;
    });
  }

  TreatmentConfig getConfig() {
    const List<String> tempPositions = <String>['LOW', 'MEDIUM', 'HIGH'];

    return config = TreatmentConfig(
        treatmentPosition: treatmentPositions[selectedProfileId],
        temp: tempPositions[selectedTemId],
        time: (timeLevel).toInt().toString(),
        ledState: ledTileSelected,
        painLevel: painLevel.toInt(),
        protocolId: selectedProfileId,
        temId: selectedTemId,
        batteryLevel: 0);
  }

  void checkAllSetup() {
    if (selectedProfileId != -1 && selectedTemId != -1) {
      setState(() {
        isTreatmentConfigured = true;
      });
    } else {
      setState(() {
        isTreatmentConfigured = false;
      });
    }
  }

  LinearGradient gradientForPainLevel = const LinearGradient(colors: <Color>[
    Color.fromARGB(255, 30, 150, 0),
    Color.fromARGB(255, 60, 160, 0),
    Color.fromARGB(255, 89, 174, 0),
    Color.fromARGB(255, 120, 180, 0),
    Color.fromARGB(255, 145, 197, 0),
    Color.fromARGB(255, 170, 210, 0),
    Color.fromARGB(255, 201, 220, 0),
    Color.fromARGB(255, 225, 220, 0),
    Color.fromARGB(255, 255, 242, 0),
    Color.fromARGB(255, 255, 210, 0),
    Color.fromARGB(255, 255, 190, 0),
    Color.fromARGB(255, 255, 178, 0),
    Color.fromARGB(255, 255, 160, 0),
    Color.fromARGB(255, 255, 156, 0),
    Color.fromARGB(255, 255, 130, 0),
    Color.fromARGB(255, 255, 118, 0),
    Color.fromARGB(255, 255, 90, 0),
    Color.fromARGB(255, 255, 64, 0),
    Color.fromARGB(255, 255, 30, 0),
    Color.fromARGB(255, 255, 0, 0)
  ]);

  LinearGradient gradientForTime = const LinearGradient(colors: <Color>[
    Color.fromARGB(255, 30, 150, 0),
    Color.fromARGB(255, 30, 150, 0)
  ]);

  Icon getFaceIcon(int index) {
    if (0 <= index && index < 4) {
      return Icon(Icons.sentiment_very_satisfied,
          color: gradientForPainLevel.colors[index]);
    } else if (4 <= index && index < 8) {
      return Icon(
        Icons.sentiment_satisfied,
        color: gradientForPainLevel.colors[index],
      );
    } else if (8 <= index && index < 12) {
      return Icon(Icons.sentiment_neutral,
          color: gradientForPainLevel.colors[index]);
    } else if (12 <= index && index < 16) {
      return Icon(Icons.sentiment_dissatisfied,
          color: gradientForPainLevel.colors[index]);
    } else {
      return Icon(Icons.sentiment_very_dissatisfied,
          color: gradientForPainLevel.colors[index - 1]);
    }
  }

  String getProfileKey() {
    if (selectedProfileId == 0) {
      return profile01K;
    } else if (selectedProfileId == 1) {
      return profile02K;
    } else {
      return profile03K;
    }
  }

  void setTempButtonStatus(int id) {
    setState(() {
      selectedTemId = id;
    });

    checkAllSetup();
  }

  void setDropDownIndex(DropDownItem dropDownItem) {
    Profile? profile;
    if (dropDownItem.index == 0) {
      profile = profiles[profile01K]!;
    } else if (dropDownItem.index == 1) {
      profile = profiles[profile02K]!;
    } else {
      profile = profiles[profile03K]!;
    }
    setState(() {
      selectedProfileId = dropDownItem.index;
      selectedTemId = profile!.temId;
      timeLevel = profile.treatmentTime.toDouble();
      painLevel = profile.painLevel.toDouble();
    });

    checkAllSetup();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 2, 2, 2),
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: CupertinoScaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12.0, 0),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    scanResult.device.name,
                    style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text(
                    'Treatment profile',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                  const SizedBox(
                    height: 2.0,
                  ),
                  const Text(
                    'Select one of 3 options',
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 65,
                          child: CupertinoButton(
                            color: Colors.green,
                            padding: const EdgeInsets.all(0),
                            onPressed: () {
                              showCupertinoModalBottomSheet(
                                expand: false,
                                context: context,
                                barrierColor:
                                    const Color.fromARGB(178, 0, 0, 0),
                                builder: (context) => DropDownCustom(
                                    DropDownData("Select profile", items,
                                        setDropDownIndex, selectedProfileId)),
                              );
                            },
                            child: Text(
                              selectedProfileId != -1
                                  ? treatmentPositions[selectedProfileId]
                                  : 'Select Profile',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  const Divider(
                    color: Color.fromARGB(255, 97, 97, 97),
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    'Device temperature',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            TemCard(
                              data: TemCardData(
                                id: 0,
                                selectColor: Colors.green,
                                selectedId: selectedTemId,
                                title: "Low",
                                updateSelectedState: setTempButtonStatus,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            TemCard(
                              data: TemCardData(
                                id: 1,
                                selectColor: Colors.orange,
                                selectedId: selectedTemId,
                                title: "Medium",
                                updateSelectedState: setTempButtonStatus,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            TemCard(
                              data: TemCardData(
                                id: 2,
                                selectColor:
                                    const Color.fromARGB(255, 228, 59, 56),
                                selectedId: selectedTemId,
                                title: "High",
                                updateSelectedState: setTempButtonStatus,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  const Divider(
                    color: Color.fromARGB(255, 97, 97, 97),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // color: const Color.fromARGB(255, 30, 41, 59),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 30, 41, 59),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: ListTile(
                                contentPadding:
                                    const EdgeInsets.fromLTRB(0, 12, 0, 0),
                                shape: RoundedRectangleBorder(
                                    side: const BorderSide(color: Colors.green),
                                    borderRadius: BorderRadius.circular(15)),
                                tileColor:
                                    const Color.fromARGB(132, 76, 75, 75),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const Expanded(
                                            flex: 1, child: SizedBox()),
                                        const Expanded(
                                          flex: 6,
                                          child: Text(
                                            "Treatment time",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255)),
                                          ),
                                        ),
                                        const Expanded(
                                            flex: 5, child: SizedBox()),
                                        Expanded(
                                          flex: 3,
                                          child: Text(
                                            "${(timeLevel).toInt()}min",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255)),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SliderTheme(
                                        data: SliderThemeData(
                                            trackShape:
                                                GradientRectSliderTrackShape(
                                                    gradient: gradientForTime,
                                                    darkenInactive: true),
                                            thumbShape: CustomSliderThumbRect(
                                                gradient: gradientForTime,
                                                thumbRadius: 30,
                                                min: 0,
                                                max: 1,
                                                thumbHeight: 45),
                                            inactiveTickMarkColor:
                                                Colors.transparent,
                                            activeTickMarkColor:
                                                Colors.transparent),
                                        child: Slider(
                                          min: 0,
                                          max: 10,
                                          divisions: 10,
                                          value: timeLevel,
                                          onChanged: (double value) {
                                            setState(() {
                                              timeLevel = value;
                                            });
                                          },
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  const Divider(
                    color: Color.fromARGB(255, 97, 97, 97),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 30, 41, 59),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: ListTile(
                                contentPadding:
                                    const EdgeInsets.fromLTRB(0, 12, 0, 0),
                                shape: RoundedRectangleBorder(
                                    side: const BorderSide(color: Colors.green),
                                    borderRadius: BorderRadius.circular(15)),
                                tileColor:
                                    const Color.fromARGB(132, 76, 75, 75),
                                title: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          18.0, 0, 18, 0),
                                      child: Row(
                                        children: [
                                          const Text(
                                            "Current Pain level",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255)),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          getFaceIcon(painLevel.toInt()),
                                          const Spacer(),
                                          Text(
                                            painLevel.toInt().toString(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SliderTheme(
                                        data: SliderThemeData(
                                            trackShape:
                                                GradientRectSliderTrackShape(
                                                    gradient:
                                                        gradientForPainLevel,
                                                    darkenInactive: true),
                                            thumbShape: CustomSliderThumbRect(
                                                gradient: gradientForPainLevel,
                                                thumbRadius: 30,
                                                min: 0,
                                                max: 19,
                                                thumbHeight: 45),
                                            inactiveTickMarkColor:
                                                Colors.transparent,
                                            activeTickMarkColor:
                                                Colors.transparent),
                                        child: Slider(
                                          min: 0,
                                          max: 20,
                                          divisions: 20,
                                          value: painLevel,
                                          onChanged: (double value) {
                                            setState(() {
                                              painLevel = value;
                                            });
                                          },
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 2),
          child: Consumer(builder: ((context, ref, child) {
            return Container(
              color: const Color.fromARGB(255, 30, 41, 59),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 65,
                      child: CupertinoButton.filled(
                        disabledColor: Colors.grey,
                        onPressed: isTreatmentConfigured
                            ? () {
                                // blue
                                //     .run(scanResult.device, getConfig())
                                //     .then((value) => {
                                //           if (value)
                                //             {
                                //               ref
                                //                   .read(ref
                                //                       .read(deviceDataMap[
                                //                           scanResult
                                //                               .device.name]!)
                                //                       .streamData)
                                //                   .resetData(),
                                //               ref
                                //                   .read(deviceDataMap[
                                //                       scanResult.device.name]!)
                                //                   .setTreatmentConfig(config),
                                //               // Navigator.pushReplacement(
                                //               //     context,
                                //               //     MaterialPageRoute(
                                //               //         builder: (context) =>
                                //               //             TreatmentRunning(
                                //               //                 RunningTreatmentData(
                                //               //                     userName:
                                //               //                         username,
                                //               //                     config:
                                //               //                         config,
                                //               //                     scanResult:
                                //               //                         scanResult)))),
                                //             }
                                //           else
                                //             {
                                //               showErrorDialog(context,
                                //                   "Something went wrong. Please try again")
                                //             }
                                //         })
                                //     .onError((error, stackTrace) => {});
                              }
                            : null,
                        child: const Text('Start',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: Color.fromARGB(255, 255, 253, 253))),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 65,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green, width: 2),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: CupertinoButton(
                          color: const Color.fromARGB(255, 30, 41, 59),
                          padding: const EdgeInsets.all(0),
                          disabledColor: Colors.grey,
                          onPressed: () {
                            Profile profile = Profile(
                                temId: selectedTemId,
                                treatmentTime: timeLevel.toInt(),
                                painLevel: painLevel.toInt());
                            String key = getProfileKey();
                            showConfirmationDialog(
                                context,
                                "Update ${treatmentPositions[selectedProfileId]}",
                                key,
                                profile);
                            setState(() {
                              profiles.remove(key);
                              profiles.putIfAbsent(key, () => profile);
                            });
                          },
                          child: const Text('Save Profile',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }))),
    );
  }
}
