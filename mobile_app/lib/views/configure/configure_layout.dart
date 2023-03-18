import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:rvi_analyzer/views/common/drop_down.dart';
import 'package:rvi_analyzer/views/configure/configure_left_panel.dart';

class ConfigureLayout extends StatefulWidget {
  final ScanResult sc;
  const ConfigureLayout({Key? key, required this.sc}) : super(key: key);

  @override
  State<ConfigureLayout> createState() => _ConfigureLayoutState();
}

class _ConfigureLayoutState extends State<ConfigureLayout> {
  int selectedModeId = -1;

  void setDropDownIndex(DropDownItem dropDownItem) {
    setState(() {
      selectedModeId = dropDownItem.index;
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
                          : SizedBox(
                              width: width < 600 ? width : (width / 2) - 32,
                              child: SizedBox(
                                height: height - 65,
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(10.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 5,
                                          offset: const Offset(0,
                                              0.5), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: const SizedBox.shrink()),
                              ),
                            ),
                    ],
                  ),
                )
              : Container()),
    );
  }
}
