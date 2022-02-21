import 'package:flutter/material.dart';
import 'package:uniturnip/src/widgets/form/models/widget_data.dart';

// TODO: Implement TextWidget
class TextWidget extends StatelessWidget {
  const TextWidget({
    Key? key,
    required this.widgetData
  }) : super(key: key);

  final WidgetData widgetData;

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      onChanged: (val) => widgetData.onChange(context, widgetData.path, val),
      initialValue: widgetData.value,
      decoration: InputDecoration(labelText: widgetData.schema['title']),
    );
  }
}
