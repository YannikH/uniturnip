import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:uniturnip/json_schema_ui/models/widget_data.dart';
import 'package:uniturnip/json_schema_ui/widgets/widget_ui.dart';

class PasswordWidget extends StatefulWidget {
  final WidgetData widgetData;

  const PasswordWidget({Key? key, required this.widgetData}) : super(key: key);

  @override
  State<PasswordWidget> createState() => _PasswordWidgetState();
}

class _PasswordWidgetState extends State<PasswordWidget> {
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
      required: widget.widgetData.required,
      child: TextFormField(
        validator: MultiValidator([
          RequiredValidator(errorText: "Required"),
          MinLengthValidator(6, errorText: "Password must contain at least 6 characters"),
          MaxLengthValidator(15, errorText: "Password cannot be more 15 characters"),
          PatternValidator(
            r'(?=.*?[#?!@$%^&*-])',
            errorText: "Password must have at least one special character",
          ),
        ]),
        obscureText: true,
        controller: textControl,
        onChanged: (val) => widget.widgetData.onChange(widget.widgetData.path, val),
        enabled: !widget.widgetData.disabled,
        autofocus: widget.widgetData.autofocus,
        readOnly: widget.widgetData.readonly,
        decoration: const InputDecoration(border: OutlineInputBorder()),
      ),
    );
  }
}
