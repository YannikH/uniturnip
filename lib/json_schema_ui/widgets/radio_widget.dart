import 'package:flutter/material.dart';
import 'package:uniturnip/json_schema_ui/models/widget_data.dart';
import 'package:uniturnip/json_schema_ui/widgets/widget_ui.dart';

class RadioWidget extends StatelessWidget {
  const RadioWidget({Key? key, required this.widgetData}) : super(key: key);

  final WidgetData widgetData;

  @override
  Widget build(BuildContext context) {
    String title = widgetData.title;
    String description = widgetData.description;
    String type = widgetData.type;

    List items = [];
    List names = [];

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
              title: Text(names[index] ?? items[index].toString()),
              value: items[index],
              groupValue: widgetData.value,
              contentPadding: EdgeInsets.zero,
              onChanged: (dynamic newValue) {
                widgetData.onChange(context, widgetData.path, newValue);
              },
            ),
          if (widgetData.value == null)
            Text(
              'Required',
              style: TextStyle(
                color: Theme.of(context).errorColor,
              ),
            ),
        ],
      ),
    );
  }
}
