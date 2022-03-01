import 'package:flutter/material.dart';
import 'package:uniturnip/src/widgets/form/models/widget_data.dart';

// TODO: Implement TextWidget
class TextWidget extends StatelessWidget {
  TextWidget({Key? key, required this.widgetData}) : super(key: key);

  final WidgetData widgetData;
  final TextEditingController textControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    textControl.text = widgetData.value ?? '';
    textControl.selection = TextSelection.fromPosition(
      TextPosition(offset: textControl.text.length),
    );
    return TextFormField(
      controller: textControl,
      onChanged: (val) => widgetData.onChange(context, widgetData.path, val),
      enabled: !widgetData.disabled,
      autofocus: widgetData.autofocus,
      readOnly: widgetData.readonly,
      decoration: InputDecoration(labelText: widgetData.schema['title']),
    );
  }
}
