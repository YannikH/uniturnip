import 'package:flutter/material.dart';
import 'package:uniturnip/json_schema_ui/models/widget_data.dart';
import 'package:uniturnip/json_schema_ui/widgets/widget_ui.dart';

class RadioWidget extends StatelessWidget {
  const RadioWidget({Key? key, required this.widgetData}) : super(key: key);

  final WidgetData widgetData;

  String _getName(List items, List names, int index) {
    if (index < names.length && names[index] != null) {
      return names[index].toString();
    } else {
      return items[index].toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final String title = widgetData.title;
    final String description = widgetData.description;
    final String type = widgetData.type;

    final List items = [];
    final List names = [];

    if (type == 'boolean') {
      items.addAll([true, false]);
      if (!widgetData.schema.containsKey('enumNames')) {
        names.addAll(['Yes', 'No']);
      }
    } else {
      items.addAll(widgetData.schema['enum']);
      if (widgetData.schema.containsKey('enumNames')) {
        names.addAll(widgetData.schema['enumNames']);
      }
    }

    return WidgetUI(
      title: title,
      description: description,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int index = 0; index < items.length; index++)
            RadioListTile(
              title: Text(_getName(items, names, index)),
              value: items[index],
              groupValue: widgetData.value,
              contentPadding: EdgeInsets.zero,
              onChanged: (dynamic newValue) {
                widgetData.onChange(context, widgetData.path, newValue);
              },
            ),
          if (widgetData.value == null)
            Text('Required', style: TextStyle(color: Theme.of(context).errorColor)),
        ],
      ),
    );
  }
}
