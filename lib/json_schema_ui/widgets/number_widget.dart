import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../json_schema_ui/models/widget_data.dart';

class NumberWidget extends StatelessWidget {
  NumberWidget({Key? key, required this.widgetData}) : super(key: key);

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
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[.0-9]')),
      ],
      onChanged: (val) => widgetData.onChange(context, widgetData.path, val),
      enabled: !widgetData.disabled,
      autofocus: widgetData.autofocus,
      readOnly: widgetData.readonly,
      decoration: InputDecoration(labelText: widgetData.schema['title']),
    );
  }
}
