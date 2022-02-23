import 'package:flutter/material.dart';
import '../models/widget_data.dart';

// TODO: Implement CheckboxWidget
class CheckboxWidget extends StatefulWidget {
  const CheckboxWidget({Key? key, required this.widgetData}) : super(key: key);

  final WidgetData widgetData;

  @override
  State<CheckboxWidget> createState() => _CheckboxWidgetState();

}

class _CheckboxWidgetState extends State<CheckboxWidget> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      autofocus: widget.widgetData.autofocus,  //true
      title: Text(widget.widgetData.schema['title']),
      value: value,
      onChanged: (dynamic val) {
        setState(() {
          value = val;
          widget.widgetData.onChange(context, widget.widgetData.path, val);
        });
      },
    );
  }
}
