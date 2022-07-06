import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../../../json_schema_ui/models/widget_data.dart';
import 'widget_ui.dart';

class NumberWidget extends StatefulWidget {
  final WidgetData widgetData;

  const NumberWidget({Key? key, required this.widgetData}) : super(key: key);

  @override
  State<NumberWidget> createState() => _NumberWidgetState();
}

class _NumberWidgetState extends State<NumberWidget> {
  late final TextEditingController textControl;
  late final String title;
  late final String description;

  @override
  void initState() {
    title = widget.widgetData.title;
    description = widget.widgetData.description;

    textControl = TextEditingController(text: widget.widgetData.value ?? '');
    textControl.selection = TextSelection.fromPosition(
      TextPosition(offset: textControl.text.length),
    );

    super.initState();
  }

  @override
  void dispose() {
    textControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WidgetUI(
      title: title,
      description: description,
      child: Column(children: <Widget>[
        TextFormField(
          controller: textControl,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[.0-9]')),
          ],
          onChanged: (val) => widget.widgetData.onChange(context, widget.widgetData.path, val),
          enabled: !widget.widgetData.disabled,
          autofocus: widget.widgetData.autofocus,
          readOnly: widget.widgetData.readonly,
          decoration: const InputDecoration(border: OutlineInputBorder()),
          validator: RequiredValidator(errorText: 'Required'),
        ),
      ]),
    );
  }
}
