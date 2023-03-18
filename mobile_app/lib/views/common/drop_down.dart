import 'package:flutter/material.dart';

class DropDownCustom extends StatefulWidget {
  final DropDownData dropDownData;
  const DropDownCustom(this.dropDownData, {Key? key}) : super(key: key);

  @override
  State<DropDownCustom> createState() => _DropDownCustomState(dropDownData);
}

class _DropDownCustomState extends State<DropDownCustom> {
  late DropDownData dropDownData;
  int selectedIndex = -1;
  _DropDownCustomState(this.dropDownData) {
    selectedIndex = dropDownData.defaultIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: const Color.fromARGB(255, 30, 41, 59),
        child: SafeArea(
          top: false,
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 2, 20, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: [
                    Expanded(flex: 6, child: Container()),
                    const Expanded(
                      flex: 2,
                      child: Divider(
                        color: Color.fromARGB(255, 220, 220, 220),
                        thickness: 4,
                      ),
                    ),
                    Expanded(flex: 6, child: Container()),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      dropDownData.title,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ListView.builder(
                    itemCount: dropDownData.items.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide(
                                color: selectedIndex == index
                                    ? const Color.fromARGB(255, 34, 197, 94)
                                    : Colors.grey),
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 2,
                                child: selectedIndex == index
                                    ? const Icon(
                                        Icons.account_circle,
                                        color: Colors.green,
                                        size: 30,
                                      )
                                    : const Icon(
                                        Icons.account_circle,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                              ),
                              const Expanded(flex: 1, child: SizedBox.shrink()),
                              Expanded(
                                flex: 12,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(dropDownData.items[index].title,
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 255, 254, 254))),
                                    dropDownData.items[index].subTitle != null
                                        ? Text(
                                            dropDownData.items[index].subTitle!,
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255)))
                                        : Container(),
                                  ],
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: selectedIndex == index
                                      ? const Icon(
                                          Icons.check_circle_sharp,
                                          color: Colors.lightGreen,
                                        )
                                      : const Icon(
                                          Icons.circle_outlined,
                                          color: Colors.grey,
                                        )),
                            ],
                          ),
                          tileColor: const Color.fromARGB(255, 30, 41, 59),
                          onTap: () => {
                            setState(() {
                              selectedIndex = index;
                            }),
                            dropDownData.updateConnectDevices(
                                dropDownData.items[index]),
                            Navigator.pop(context, 'OK')
                          },
                        ),
                      );
                    }),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ));
  }
}

Widget getItem(BuildContext context, DropDownItem item,
    void Function(DropDownItem) updateConnectDevices) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
    child: ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(color: Color.fromARGB(255, 34, 197, 94)),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 5,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(item.title,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 255, 254, 254))),
                item.subTitle != null
                    ? Text(item.subTitle!,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)))
                    : Container(),
              ],
            ),
          ),
          Expanded(flex: 8, child: Container()),
          const Expanded(
            flex: 2,
            child: Icon(
              Icons.check_circle_sharp,
              color: Colors.lightGreen,
            ),
          ),
        ],
      ),
      tileColor: const Color.fromARGB(255, 30, 41, 59),
      onTap: () => {
        // setState(() {
        //   selectedIndex = index;
        // }),
        updateConnectDevices(item)
      },
    ),
  );
}

class DropDownData {
  final String title;
  final List<DropDownItem> items;
  final void Function(DropDownItem) updateConnectDevices;
  final int defaultIndex;

  DropDownData(
      this.title, this.items, this.updateConnectDevices, this.defaultIndex);
}

class DropDownItem {
  final String title;
  final String? subTitle;
  final int index;

  DropDownItem(this.title, this.subTitle, this.index);
}
