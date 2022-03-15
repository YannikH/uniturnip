import 'package:flutter/material.dart';
import '../../../../json_schema_ui/models/widget_data.dart';

class CheckboxWidget extends StatelessWidget {
  const CheckboxWidget({Key? key, required this.widgetData}) : super(key: key);

  final WidgetData widgetData;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      autofocus: widgetData.autofocus,  //true
      title: Text(widgetData.schema['title']),
      value: true == widgetData.value,
      onChanged: (dynamic newValue) {
        widgetData.onChange(context, widgetData.path, newValue);
      },
    );
  }
}
