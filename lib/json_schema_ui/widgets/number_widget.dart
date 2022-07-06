import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../../../json_schema_ui/models/widget_data.dart';
import 'widget_ui.dart';

class NumberWidget extends StatelessWidget {
  NumberWidget({Key? key, required this.widgetData}) : super(key: key);

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
      child: Column(
          children: <Widget>[
            TextFormField(
            controller: textControl,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[.0-9]')),
            ],
            onChanged: (val) => widgetData.onChange(context, widgetData.path, val),
            enabled: !widgetData.disabled,
            autofocus: widgetData.autofocus,
            readOnly: widgetData.readonly,
            decoration: const InputDecoration(border: OutlineInputBorder()),
            validator: RequiredValidator(errorText: 'Required'),
          ),
          ]
      ),
    );
  }
}
