import 'package:flutter/material.dart';

class CustomDropDwnData {
  final List<String> inputs;
  final void Function(String?) updateSelectedIndex;

  CustomDropDwnData({required this.inputs, required this.updateSelectedIndex});
}

class CustomDropDwn extends StatefulWidget {
  final CustomDropDwnData data;
  CustomDropDwn({Key? key, required this.data}) : super(key: key);

  @override
  State<CustomDropDwn> createState() => _CustomDropDwnState();
}

class _CustomDropDwnState extends State<CustomDropDwn> {
  late String _currentSelectedValue;

  @override
  void initState() {
    super.initState();
    _currentSelectedValue = widget.data.inputs.first;
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: InputDecoration(
              errorStyle:
                  const TextStyle(color: Colors.redAccent, fontSize: 16.0),
              hintText: 'Please select expense',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
          isEmpty: _currentSelectedValue == '',
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
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
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
