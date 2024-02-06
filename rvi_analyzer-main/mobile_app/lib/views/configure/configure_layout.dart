import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rvi_analyzer/providers/device_state_provider.dart';
import 'package:rvi_analyzer/views/common/drop_down.dart';
import 'package:rvi_analyzer/views/configure/configure_left_panel.dart';
import 'package:rvi_analyzer/views/configure/configure_right_panel_type_01.dart';
import 'package:rvi_analyzer/views/configure/configure_right_panel_type_02.dart';
import 'package:rvi_analyzer/views/configure/configure_right_panel_type_03.dart';
import 'package:rvi_analyzer/views/configure/configure_right_panel_type_04.dart';
import 'package:rvi_analyzer/views/configure/configure_right_panel_type_05.dart';
import 'package:rvi_analyzer/views/configure/configure_right_panel_type_06.dart';

class ConfigureLayout extends ConsumerStatefulWidget {
  final ScanResult sc;
  const ConfigureLayout({Key? key, required this.sc}) : super(key: key);

  @override
  ConsumerState<ConfigureLayout> createState() => _ConfigureLayoutState();
}

class _ConfigureLayoutState extends ConsumerState<ConfigureLayout> {
  int selectedModeId = -1;
  Widget secondWidget = const SizedBox.shrink();
  final _formKey = GlobalKey<FormState>();

  void setDropDownIndex(DropDownItem dropDownItem) {
    setState(() {
      selectedModeId = dropDownItem.index;
      if (dropDownItem.index == 0) {
        updateDisabledParams();

        secondWidget = ConfigureRightPanelType01(
            updateTestId: updateTestID, sc: widget.sc, keyForm: _formKey);
      } else if (dropDownItem.index == 1) {
        updateDisabledParams();
        secondWidget = ConfigureRightPanelType02(
            updateTestId: updateTestID, sc: widget.sc, keyForm: _formKey);
      } else if (dropDownItem.index == 2) {
        updateDisabledParams();
        secondWidget = ConfigureRightPanelType03(
            updateTestId: updateTestID, sc: widget.sc, keyForm: _formKey);
      } else if (dropDownItem.index == 3) {
        updateDisabledParams();
        secondWidget = ConfigureRightPanelType04(
            updateTestId: updateTestID, sc: widget.sc, keyForm: _formKey);
      } else if (dropDownItem.index == 4) {
        updateDisabledParams();
        secondWidget = ConfigureRightPanelType05(
            updateTestId: updateTestID, sc: widget.sc, keyForm: _formKey);
      } else if (dropDownItem.index == 5) {
        updateDisabledParams();
        secondWidget = ConfigureRightPanelType06(
            updateTestId: updateTestID, sc: widget.sc, keyForm: _formKey);
      }
    });

    // ref.read(deviceDataMap[widget.sc.device.id.id]!).dropDownIndex =
    //     dropDownItem.index;
  }

  void updateSecondWidget(int index) {
    if (index == 0) {
      secondWidget = ConfigureRightPanelType01(
          updateTestId: updateTestID, sc: widget.sc, keyForm: _formKey);
    } else if (index == 1) {
      secondWidget = ConfigureRightPanelType02(
          updateTestId: updateTestID, sc: widget.sc, keyForm: _formKey);
    } else if (index == 2) {
      secondWidget = ConfigureRightPanelType03(
          updateTestId: updateTestID, sc: widget.sc, keyForm: _formKey);
    } else if (index == 3) {
      secondWidget = ConfigureRightPanelType04(
          updateTestId: updateTestID, sc: widget.sc, keyForm: _formKey);
    } else if (index == 4) {
      secondWidget = ConfigureRightPanelType05(
          updateTestId: updateTestID, sc: widget.sc, keyForm: _formKey);
    } else if (index == 5) {
      secondWidget = ConfigureRightPanelType06(
          updateTestId: updateTestID, sc: widget.sc, keyForm: _formKey);
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   if (ref.read(deviceDataMap[widget.sc.device.id.id]!).dropDownIndex != -1) {
  //     updateSecondWidget(
  //         ref.read(deviceDataMap[widget.sc.device.id.id]!).dropDownIndex);
  //   }
  // }

  void updateDisabledParams() {
    DateTime now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String date = formatter.format(now);
    ref.watch(deviceDataMap[widget.sc.device.id.id]!).dateController.text =
        date;

    int milliseconds = now.millisecondsSinceEpoch;
    ref.watch(deviceDataMap[widget.sc.device.id.id]!).testIdController.text =
        milliseconds.toString();
    ref.watch(deviceDataMap[widget.sc.device.id.id]!).sessionIdController.text =
        "S_$milliseconds";
  }

  void updateTestID() {
    DateTime now = DateTime.now();
    int milliseconds = now.millisecondsSinceEpoch;

    ref.watch(deviceDataMap[widget.sc.device.id.id]!).testIdController.text =
        milliseconds.toString();
  }

  @override
  Widget build(BuildContext context) {
    var isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
          child: isLandscape
              ? SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ConfigureLeftPanel(
                            sc: widget.sc,
                            defaultIndex: selectedModeId,
                            updateIndex: setDropDownIndex,
                            keyForm: _formKey),
                        const Spacer(),
                        selectedModeId == -1
                            ? const SizedBox.shrink()
                            : AnimatedSwitcher(
                                duration: const Duration(milliseconds: 500),
                                transitionBuilder: (Widget child,
                                    Animation<double> animation) {
                                  return ScaleTransition(
                                      scale: animation, child: child);
                                },
                                child: secondWidget),
                      ],
                    ),
                  ),
                )
              : SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: Column(
                      children: [
                        ConfigureLeftPanel(
                            sc: widget.sc,
                            defaultIndex: selectedModeId,
                            updateIndex: setDropDownIndex,
                            keyForm: _formKey),
                        const SizedBox(height: 15),
                        selectedModeId == -1
                            ? const SizedBox.shrink()
                            : AnimatedSwitcher(
                                duration: const Duration(milliseconds: 500),
                                transitionBuilder: (Widget child,
                                    Animation<double> animation) {
                                  return ScaleTransition(
                                      scale: animation, child: child);
                                },
                                child: secondWidget),
                      ],
                    ),
                  ),
                )),
    );
  }
}
