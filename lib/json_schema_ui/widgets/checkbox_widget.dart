import 'package:flutter/material.dart';
import '../../../../json_schema_ui/models/widget_data.dart';

class CheckboxWidget extends StatelessWidget {
  const CheckboxWidget({Key? key, required this.widgetData}) : super(key: key);

  final WidgetData widgetData;

  @override
  Widget build(BuildContext context) {
    String title = widgetData.schema['title'] ?? '';
    String description = widgetData.schema['description'] ?? '';

    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      autofocus: widgetData.autofocus,  //true
      title: Text(title),
      value: true == widgetData.value,
      onChanged: (dynamic newValue) {
        widgetData.onChange(context, widgetData.path, newValue);
      },
    );
  }
}
