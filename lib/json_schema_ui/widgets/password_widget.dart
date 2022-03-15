import 'package:flutter/material.dart';

import '../../../../json_schema_ui/models/widget_data.dart';

class PasswordWidget extends StatelessWidget {
  PasswordWidget({Key? key, required this.widgetData}) : super(key: key);

  final WidgetData widgetData;
  final TextEditingController textControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    textControl.text = widgetData.value ?? '';
    textControl.selection = TextSelection.fromPosition(
      TextPosition(offset: textControl.text.length),
    );
    return TextFormField(
      obscureText: true,
      controller: textControl,
      onChanged: (val) => widgetData.onChange(context, widgetData.path, val),
      enabled: !widgetData.disabled,
      autofocus: widgetData.autofocus,
      readOnly: widgetData.readonly,
      decoration: const InputDecoration(
        labelText: 'Password',
      ),
    );
  }
}
