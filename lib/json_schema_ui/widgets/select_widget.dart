import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

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
    // TODO: Implement enumNames
    List names = widgetData.schema['enumNames'] ?? [];

    return WidgetUI(
      title: title,
      description: description,
      child: DropdownButtonFormField(
        autofocus: widgetData.autofocus,
        hint: const Text('Select item'),
        value: widgetData.value.toString(),
        decoration: const InputDecoration(border: OutlineInputBorder()),
        onChanged: (dynamic newValue) {
          widgetData.onChange(context, widgetData.path, newValue);
        },
        items: items
            .mapIndexed<DropdownMenuItem>((index, item) {
              return DropdownMenuItem(
                  alignment: AlignmentDirectional.centerStart,
                  enabled: !widgetData.disabled,
                  value: item.toString(),
                  child: Text(item.toString()),
                );
            })
            .toList(),
      ),
    );
  }
}
