import 'package:flutter/material.dart';

import '../../../../json_schema_ui/models/widget_data.dart';
import 'widget_ui.dart';

class RadioWidget extends StatelessWidget {
  const RadioWidget({Key? key, required this.widgetData}) : super(key: key);

  final WidgetData widgetData;

  @override
  Widget build(BuildContext context) {
    String title = widgetData.schema['title'] ?? '';
    String description = widgetData.schema['description'] ?? '';

    List items = widgetData.schema['enum'] ?? [];
    List names = widgetData.schema['enumNames'] ?? [];

    return WidgetUI(
      title: title,
      description: description,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) => RadioListTile(
            title: Text(names.length > index ? names[index] ?? items[index].toString() : items[index].toString()),
            value: items[index].toString(),
            groupValue: widgetData.value.toString(),
            onChanged: (dynamic newValue) =>
                widgetData.onChange(context, widgetData.path, newValue)),
      ),
    );
  }
}
