import 'package:flutter/material.dart';
import '../models/widget_data.dart';

// TODO: Implement CheckboxWidget
class CheckboxWidget extends StatelessWidget {
  CheckboxWidget({Key? key, required this.widgetData}) : super(key: key);

  final WidgetData widgetData;
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      autofocus: widgetData.autofocus,  //true
      title: Text(widgetData.schema['title']),
      value: widgetData.value != value,
      onChanged: (dynamic val) {
        value = val;
        widgetData.onChange(context, widgetData.path, val);
      },
    );
  }
}
