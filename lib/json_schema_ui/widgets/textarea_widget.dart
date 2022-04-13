import 'package:flutter/material.dart';

import '../../../../json_schema_ui/models/widget_data.dart';
import 'widget_ui.dart';

class TextareaWidget extends StatelessWidget {
  TextareaWidget({Key? key, required this.widgetData}) : super(key: key);

  final WidgetData widgetData;
  final TextEditingController textControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String title = widgetData.schema['title'] ?? '';
    String description = widgetData.schema['description'] ?? '';

    textControl.text = widgetData.value ?? '';
    textControl.selection = TextSelection.fromPosition(
      TextPosition(offset: textControl.text.length),
    );

    return WidgetUI(
      title: title,
      description: description,
      child: TextFormField(
        controller: textControl,
        onChanged: (val) => widgetData.onChange(context, widgetData.path, val),
        enabled: !widgetData.disabled,
        autofocus: widgetData.autofocus,
        readOnly: widgetData.readonly,
        decoration: const InputDecoration(border: OutlineInputBorder()),
        maxLines: null,
        minLines: 4,
      ),
    );
  }
}
