import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../models/widget_data.dart';
import 'widget_ui.dart';

class PasswordWidget extends StatelessWidget {
  PasswordWidget({Key? key, required this.widgetData}) : super(key: key);

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
        validator: MultiValidator([
          RequiredValidator(errorText: "Required"),
          MinLengthValidator(6,
              errorText:
              "Password must contain atleast 6 characters"),
          MaxLengthValidator(15,
              errorText:
              "Password cannot be more 15 characters"),
          PatternValidator(r'(?=.*?[#?!@$%^&*-])',
              errorText:
              "Password must have at least one special character"),
        ]),
        obscureText: true,
        controller: textControl,
        onChanged: (val) => widgetData.onChange(context, widgetData.path, val),
        enabled: !widgetData.disabled,
        autofocus: widgetData.autofocus,
        readOnly: widgetData.readonly,
        decoration: const InputDecoration(border: OutlineInputBorder()),
      ),
    );
  }
}
