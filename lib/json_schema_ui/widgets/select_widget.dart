import 'package:flutter/material.dart';
import '../../../../json_schema_ui/models/widget_data.dart';
import 'widget_ui.dart';

class SelectWidget extends StatelessWidget {
  const SelectWidget({Key? key, required this.widgetData}) : super(key: key);

  final WidgetData widgetData;

  @override
  Widget build(BuildContext context) {
    String title = widgetData.schema['title'] ?? '';
    String description = widgetData.schema['description'] ?? '';
    List items = widgetData.schema['enum'] ?? [];

    return WidgetUI(
      title: title,
      description: description,
      child: DropdownButtonFormField(
        autofocus: widgetData.autofocus,
        hint: const Text('Select item'),
        value: widgetData.value,
        decoration: const InputDecoration(border: OutlineInputBorder()),
        onChanged: (newValue) {
          widgetData.onChange(context, widgetData.path, newValue);
        },
        items: items
            .map<DropdownMenuItem<String>>((value) => DropdownMenuItem<String>(
                  alignment: AlignmentDirectional.centerStart,
                  enabled: !widgetData.disabled,
                  value: value,
                  child: Text(value),
                ))
            .toList(),
      ),
    );
  }
}
