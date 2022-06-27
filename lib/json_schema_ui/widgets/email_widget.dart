import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../../../../json_schema_ui/models/widget_data.dart';
import 'widget_ui.dart';

class EmailWidget extends StatefulWidget {
  EmailWidget({Key? key, required this.widgetData}) : super(key: key);

  final WidgetData widgetData;

  @override
  State<EmailWidget> createState() => _EmailWidgetState();
}

class _EmailWidgetState extends State<EmailWidget> {
  final TextEditingController textControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String title = widget.widgetData.schema['title'] ?? '';
    String description = widget.widgetData.schema['description'] ?? '';
    textControl.text = widget.widgetData.value ?? '';
    textControl.selection = TextSelection.fromPosition(
      TextPosition(offset: textControl.text.length),
    );
    // final _val = GlobalKey<FormState>();

    return WidgetUI(
      title: title,
      description: description,
        child: TextFormField(
              validator: MultiValidator([
                RequiredValidator(errorText: "Required"),
                EmailValidator(errorText: "Please enter a valid email address"),
              ]),
              controller: textControl,
              decoration: const InputDecoration(
                hintText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              onChanged: (val) => widget.widgetData.onChange(context, widget.widgetData.path, val),
              enabled: !widget.widgetData.disabled,
              autofocus: widget.widgetData.autofocus,
              readOnly: widget.widgetData.readonly,
              autofillHints: const [AutofillHints.email],
            ),
    );
  }
}
