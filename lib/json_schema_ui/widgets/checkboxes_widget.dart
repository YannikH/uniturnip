import 'package:flutter/material.dart';
import 'package:uniturnip/json_schema_ui/models/widget_data.dart';
import 'package:uniturnip/json_schema_ui/widgets/widget_ui.dart';

class CheckboxesWidget extends StatelessWidget {
  final WidgetData widgetData;

  const CheckboxesWidget({Key? key, required this.widgetData}) : super(key: key);

  void _onChange(bool? value) {
    widgetData.onChange(widgetData.path, value);
  }

  @override
  Widget build(BuildContext context) {
    List items = widgetData.schema['enum'] ?? [];
    List? value = widgetData.value;

    return WidgetUI(
      title: widgetData.title,
      description: widgetData.description,
      required: widgetData.required,
      child: Column(
        children: [
          for (var item in items)
            CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              autofocus: widgetData.autofocus,
              title: Text(item),
              value: value?.contains(item),
              onChanged: widgetData.disabled ? null : _onChange,
            ),
          if (widgetData.required && value == null)
            Text('Required', style: TextStyle(color: Theme.of(context).errorColor)),
        ],
      ),
    );
  }
}
