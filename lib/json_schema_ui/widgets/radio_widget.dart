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

    String type = widgetData.schema['type'];

    List items = [];
    List names = [];

    if (type == 'boolean') {
      items.addAll([true, false]);
      if (widgetData.schema['enumNames'] == null) {
        names.addAll(['Yes', 'No']);
      }
    } else {
      items.addAll(widgetData.schema['enum']);
      if (widgetData.schema['enumNames'] != null) {
        names.addAll(widgetData.schema['enumNames']);
      }
    }

    return WidgetUI(
      title: title,
      description: description,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) => RadioListTile(
            title: Text(names.length > index ? names[index] ?? items[index].toString() : items[index].toString()),
            value: items[index],
            groupValue: widgetData.value,
            contentPadding: EdgeInsets.zero,
            onChanged: (dynamic newValue) =>
                widgetData.onChange(context, widgetData.path, newValue)),
      ),
    );
  }
}
