import 'package:flutter/material.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

class CheckBoxWithLabelData {
  final String headingText;
  final String linkText;
  final String? Function(bool?) validatorFun;
  final void Function(bool?)? additionalFun;

  CheckBoxWithLabelData(
      {required this.headingText,
      required this.linkText,
      required this.validatorFun,
      this.additionalFun});
}

class CheckBoxWithLabel extends StatefulWidget {
  final CheckBoxWithLabelData data;
  const CheckBoxWithLabel({Key? key, required this.data}) : super(key: key);

  @override
  State<CheckBoxWithLabel> createState() => _CheckBoxWithLabelState();
}

class _CheckBoxWithLabelState extends State<CheckBoxWithLabel> {
  bool selectValue = false;
  bool initialLoad = true;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return FormField<bool>(
      autovalidateMode: AutovalidateMode.always,
      builder: (state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                RoundCheckBox(
                  checkedColor: Colors.cyan,
                  isChecked: selectValue,
                  onTap: (selected) {
                    setState(() {
                      selectValue = selected ?? false;
                      initialLoad = false;
                    });
                    widget.data.additionalFun!(selected);
                  },
                  size: 25,
                  checkedWidget: const Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                  animationDuration: const Duration(
                    milliseconds: 50,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  widget.data.headingText,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _scaleDialog(isLandscape ? (width / 2) - 20 : 20, 10);
                  },
                  child: Text(
                    widget.data.linkText,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.cyan,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 30,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    state.errorText ?? '',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.red[400],
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        );
      },
      validator: (select) {
        return !initialLoad ? widget.data.validatorFun(selectValue) : null;
      },
    );
  }

  void _scaleDialog(double left, double right) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "",
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        var curve = Curves.easeInOut.transform(a1.value);
        return Transform.scale(
          scale: curve,
          child: AlertDialog(
            insetPadding: EdgeInsets.fromLTRB(left, 0, right, 0),
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            elevation: 40,
            title: Text(widget.data.linkText,
                style: const TextStyle(color: Colors.black, fontSize: 15)),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  ListBody(
                    children: const <Widget>[
                      Text(
                          'These clauses address what behavior is unacceptable on your website. They are an opportunity to set out the rules that you expect users to abide by, and what the consequences will be if the user violates these rules.It\'s helpful to set out specific examples of behavior that violates your site rules.The Oath Terms of Service sets out the behavior that it deems unacceptable. It uses broad language such as "Make available any content...that is otherwise objectionable" to avoid restricting content violations to, for example, sexually explicit or vulgar content:',
                          style: TextStyle(
                              fontSize: 13,
                              color: Color.fromARGB(255, 148, 163, 184))),
                      Text('Would you like to approve of this message?',
                          style: TextStyle(
                              fontSize: 13,
                              color: Color.fromARGB(255, 148, 163, 184))),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 400),
    );
  }
}
