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

    String type = widgetData.schema['type'];

    List items = [null];
    List names = [""];

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
      child: DropdownButtonFormField(
        autofocus: widgetData.autofocus,
        hint: const Text('Select item'),
        value: widgetData.value,
        decoration: const InputDecoration(border: OutlineInputBorder()),
        onChanged: (dynamic newValue) {
          widgetData.onChange(context, widgetData.path, newValue);
        },
        items: items.mapIndexed<DropdownMenuItem>((index, item) {
          return DropdownMenuItem(
            alignment: AlignmentDirectional.centerStart,
            enabled: !widgetData.disabled,
            value: item,
            child: Text(names.asMap().containsKey(index)
                ? names[index]
                : item.toString()),
          );
        }).toList(),
      ),
    );
  }
}
