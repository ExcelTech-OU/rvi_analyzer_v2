import 'package:flutter/material.dart';
import 'package:rvi_analyzer/views/common/form_eliments/dropdown.dart';

class CustomDropDwn2 extends StatefulWidget {
  final CustomDropDwnData data;
  CustomDropDwn2({Key? key, required this.data}) : super(key: key);

  @override
  State<CustomDropDwn2> createState() => _CustomDropDwn2State();
}

class _CustomDropDwn2State extends State<CustomDropDwn2> {
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
                widget.data.updateSelectedIndex(
                    widget.data.inputs.indexOf(newValue!).toString());
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
