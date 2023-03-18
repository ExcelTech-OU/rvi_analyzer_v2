import 'package:flutter/material.dart';

class TemCardData {
  final int id;
  final Color selectColor;
  final String title;
  final int selectedId;
  final String? subTitle;
  final void Function(int) updateSelectedState;
  final bool enabled;

  TemCardData(
      {required this.id,
      required this.selectColor,
      required this.title,
      required this.selectedId,
      required this.updateSelectedState,
      this.subTitle,
      this.enabled = true});
}

class TemCard extends StatefulWidget {
  final TemCardData data;
  const TemCard({Key? key, required this.data}) : super(key: key);

  @override
  State<TemCard> createState() => _TemCardState();
}

class _TemCardState extends State<TemCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 30, 41, 59),
          borderRadius: BorderRadius.circular(10.0),
          border: widget.data.id == widget.data.selectedId
              ? Border.all(color: widget.data.selectColor)
              : Border.all(color: Color.fromARGB(132, 76, 75, 75))),
      child: ListTile(
        contentPadding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
        onTap: widget.data.enabled
            ? () {
                //Removed dis select feature of Tem
                // widget.data.id == widget.data.selectedId
                //     ? widget.data.updateSelectedState(-1)
                //     :
                widget.data.updateSelectedState(widget.data.id);
              }
            : null,
        shape: RoundedRectangleBorder(
            side: widget.data.id == widget.data.selectedId
                ? BorderSide(color: widget.data.selectColor)
                : const BorderSide(color: Color.fromARGB(132, 76, 75, 75)),
            borderRadius: BorderRadius.circular(15)),
        tileColor: const Color.fromARGB(132, 76, 75, 75),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  widget.data.id == widget.data.selectedId
                      ? Icon(
                          Icons.check_circle_sharp,
                          color: widget.data.selectColor,
                        )
                      : const Icon(
                          Icons.circle_outlined,
                          color: Color.fromARGB(80, 158, 158, 158),
                        ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(flex: 1, child: Container()),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.data.title,
                          style: TextStyle(
                              color: widget.data.id == widget.data.selectedId
                                  ? widget.data.selectColor
                                  : const Color.fromARGB(255, 255, 255, 255))),
                      widget.data.subTitle != null
                          ? Text(widget.data.subTitle!,
                              style: TextStyle(
                                  color:
                                      widget.data.id == widget.data.selectedId
                                          ? widget.data.selectColor
                                          : const Color.fromARGB(
                                              255, 255, 255, 255)))
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
                Expanded(flex: 1, child: Container()),
              ],
            ),
            Row(
              children: const [
                SizedBox(
                  height: 15,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
