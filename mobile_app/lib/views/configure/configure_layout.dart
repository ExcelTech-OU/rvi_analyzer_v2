import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:rvi_analyzer/views/common/drop_down.dart';
import 'package:rvi_analyzer/views/configure/configure_left_panel.dart';
import 'package:rvi_analyzer/views/configure/configure_right_panel_type_01.dart';
import 'package:rvi_analyzer/views/configure/configure_right_panel_type_02.dart';

class ConfigureLayout extends StatefulWidget {
  final ScanResult sc;
  const ConfigureLayout({Key? key, required this.sc}) : super(key: key);

  @override
  State<ConfigureLayout> createState() => _ConfigureLayoutState();
}

class _ConfigureLayoutState extends State<ConfigureLayout> {
  int selectedModeId = -1;
  Widget secondWidget = const SizedBox.shrink();
  final _formKey = GlobalKey<FormState>();
  bool started = false;

  final customerNameController = TextEditingController();
  final batchNoController = TextEditingController();
  final operatorIdController = TextEditingController();
  final sessionIdController = TextEditingController();
  final testIdController = TextEditingController();
  final dateController = TextEditingController();

  void setDropDownIndex(DropDownItem dropDownItem) {
    setState(() {
      selectedModeId = dropDownItem.index;
      if (dropDownItem.index == 0) {
        secondWidget = ConfigureRightPanelType01(
            updateStarted: updateStarted,
            updateTestId: updateTestID,
            sc: widget.sc,
            keyForm: _formKey,
            batchNoController: batchNoController,
            customerNameController: customerNameController,
            dateController: dateController,
            operatorIdController: operatorIdController,
            sessionIdController: sessionIdController,
            testIdController: testIdController);
      } else if (dropDownItem.index == 1) {
        secondWidget = const ConfigureRightPanelType02();
      }
    });
  }

  void updateStarted() {
    setState(() {
      started = !started;
    });
  }

  void updateTestID() {
    DateTime now = DateTime.now();
    int milliseconds = now.millisecondsSinceEpoch;

    setState(() {
      testIdController.text = milliseconds.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
                            keyForm: _formKey,
                            started: started,
                            batchNoController: batchNoController,
                            customerNameController: customerNameController,
                            dateController: dateController,
                            operatorIdController: operatorIdController,
                            sessionIdController: sessionIdController,
                            testIdController: testIdController),
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
                            keyForm: _formKey,
                            started: started,
                            batchNoController: batchNoController,
                            customerNameController: customerNameController,
                            dateController: dateController,
                            operatorIdController: operatorIdController,
                            sessionIdController: sessionIdController,
                            testIdController: testIdController),
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
