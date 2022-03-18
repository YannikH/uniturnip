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
    print("ENUM ${widgetData.schema['enum']}");
    
    String type = widgetData.schema['type'];

    List items = [""];
    List names = [""];
    
    if (type == 'boolean') {
      items.addAll(['true', 'false']);
      names.addAll(['Yes', 'No']);
    } else {
      items.addAll(widgetData.schema['enum']);
      names.addAll(widgetData.schema['enumNames']);
    }
    String value = widgetData.value != null ? widgetData.value.toString() : "";

    return WidgetUI(
      title: title,
      description: description,
      child: DropdownButtonFormField(
        autofocus: widgetData.autofocus,
        hint: const Text('Select item'),
        value: value,
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
                  child: Text( names.asMap().containsKey(index) ? names[index] : item.toString()),
                );
            })
            .toList(),
      ),
    );
  }
}
