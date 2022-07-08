import 'package:flutter/material.dart';
import 'package:uniturnip/json_schema_ui/models/widget_data.dart';

class CheckboxWidget extends StatelessWidget {
  final WidgetData widgetData;

  const CheckboxWidget({Key? key, required this.widgetData}) : super(key: key);

  void _onChange(bool? value) {
    widgetData.onChange(widgetData.path, value);
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
        contentPadding: EdgeInsets.zero,
        controlAffinity: ListTileControlAffinity.leading,
        autofocus: widgetData.autofocus,
        value: true == widgetData.value,
        onChanged: widgetData.disabled ? null : _onChange,
        title: Text(widgetData.title),
        subtitle: widgetData.required && widgetData.value == null
            ? Text('Required', style: TextStyle(color: Theme.of(context).errorColor))
            : null);
  }
}
