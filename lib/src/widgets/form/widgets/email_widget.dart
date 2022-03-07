import 'package:flutter/material.dart';

import '../models/widget_data.dart';

class EmailWidget extends StatelessWidget {
  EmailWidget({Key? key, required this.widgetData}) : super(key: key);

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
        decoration: InputDecoration(
          hintText: 'Email',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          prefixIcon: Icon(Icons.mail),
          suffixIcon: textControl.text.isEmpty
              ? Container(width: 0)
              : IconButton(
            icon: Icon(Icons.close),
            onPressed: () => textControl.clear(),
          ),
        ),
        keyboardType: TextInputType.emailAddress,
        onChanged: (val) => widgetData.onChange(context, widgetData.path, val),
        enabled: !widgetData.disabled,
        autofocus: widgetData.autofocus,
        readOnly: widgetData.readonly,
        autofillHints: const [AutofillHints.email]
    );
  }
}