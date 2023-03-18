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

  void setDropDownIndex(DropDownItem dropDownItem) {
    setState(() {
      selectedModeId = dropDownItem.index;
      if (dropDownItem.index == 0) {
        secondWidget = ConfigureRightPanelType01(sc: widget.sc);
      } else if (dropDownItem.index == 1) {
        secondWidget = const ConfigureRightPanelType02();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: isLandscape
              ? Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Row(
                    children: [
                      ConfigureLeftPanel(
                          sc: widget.sc,
                          defaultIndex: selectedModeId,
                          updateIndex: setDropDownIndex),
                      const Spacer(),
                      selectedModeId == -1
                          ? const SizedBox.shrink()
                          : AnimatedSwitcher(
                              duration: const Duration(milliseconds: 500),
                              transitionBuilder:
                                  (Widget child, Animation<double> animation) {
                                return ScaleTransition(
                                    scale: animation, child: child);
                              },
                              child: secondWidget),
                    ],
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
                            updateIndex: setDropDownIndex),
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
