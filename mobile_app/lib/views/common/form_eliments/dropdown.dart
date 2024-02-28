import 'package:flutter/material.dart';

class CustomDropDwnData {
  final List<String> inputs;
  final void Function(String?) updateSelectedIndex;
  String? hindText = "Please select one";
  List<String>? customData = [];

  CustomDropDwnData(
      {required this.inputs,
      required this.updateSelectedIndex,
      this.hindText,
      this.customData});
}

class CustomDropDwn extends StatefulWidget {
  final CustomDropDwnData data;
  const CustomDropDwn({Key? key, required this.data}) : super(key: key);

  @override
  State<CustomDropDwn> createState() => _CustomDropDwnState();
}

class _CustomDropDwnState extends State<CustomDropDwn> {
  String? _currentSelectedValue = null;

  @override
  void initState() {
    super.initState();
    if (widget.data.inputs.isNotEmpty) {
      _currentSelectedValue = widget.data.inputs.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data.inputs.isEmpty) {
      setState(() {
        _currentSelectedValue = null;
      });
    }
    return FormField<String>(
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: InputDecoration(
              errorStyle:
                  const TextStyle(color: Colors.redAccent, fontSize: 16.0),
              hintText: widget.data.hindText,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
          isEmpty: _currentSelectedValue == null,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              dropdownColor: Colors.grey[400],
              value: _currentSelectedValue,
              isDense: true,
              onChanged: (String? newValue) {
                setState(() {
                  _currentSelectedValue = newValue!;
                });
                widget.data.updateSelectedIndex(newValue);
              },
              items: widget.data.inputs.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Row(
                    children: [
                      Text(value,
                          style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold)),
                      widget.data.customData != null
                          ? Text(
                              ": (${widget.data.customData![widget.data.inputs.indexOf(value)]})",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold))
                          : Text(""),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
