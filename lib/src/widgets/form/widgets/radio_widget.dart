import 'package:flutter/material.dart';

import '../models/widget_data.dart';

class RadioWidget extends StatelessWidget {
  const RadioWidget({Key? key, required this.widgetData}) : super(key: key);

  final WidgetData widgetData;

  @override
  Widget build(BuildContext context) {
    List items = widgetData.schema['enum'] ?? [];
    List names = widgetData.schema['enumNames'] ?? [];
    List<Widget> radioButtons = [];
    for (int index = 0; index < items.length; index++) {
      radioButtons.add(RadioListTile(
          title: Text(names[index] ?? items[index]),
          value: items[index],
          groupValue: widgetData.value,
          onChanged: (dynamic newValue) =>
              widgetData.onChange(context, widgetData.path, newValue)));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widgetData.schema['title']),
        Column(
          children: radioButtons,
        ),
      ],
    );
  }
}
