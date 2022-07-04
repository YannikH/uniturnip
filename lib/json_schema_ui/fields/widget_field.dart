import 'package:flutter/material.dart';
import 'package:uniturnip/json_schema_ui/models/widget_data.dart';
import 'package:uniturnip/json_schema_ui/widgets.dart';

class WidgetField extends StatelessWidget {
  final String widgetType;
  final WidgetData widgetData;

  const WidgetField({
    Key? key,
    required this.widgetType,
    required this.widgetData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (widgetType) {
      // case 'audio':
      //   return AudioWidget(widgetData: widgetData);
      case 'checkbox':
        return CheckboxWidget(widgetData: widgetData);
      case 'checkboxes':
        return CheckboxesWidget(widgetData: widgetData);
      case 'radio':
        return RadioWidget(widgetData: widgetData);
      case 'select':
        return SelectWidget(widgetData: widgetData);
// case 'hidden':
//   return HiddenWidget(widgetData: widgetData);
      case 'text':
        return TextWidget(widgetData: widgetData);
      case 'password':
        return PasswordWidget(widgetData: widgetData);
      case 'email':
        return EmailWidget(widgetData: widgetData);
// case 'uri':
//   return URLWidget(widgetData: widgetData);
      case 'data-url':
        return FileWidget(widgetData: widgetData);
      case 'textarea':
        return TextareaWidget(widgetData: widgetData);
      case 'date':
        return DateWidget(widgetData: widgetData);
      case 'datetime':
        return DateTimeWidget(widgetData: widgetData);
      case 'date-time':
        return DateTimeWidget(widgetData: widgetData);
// case 'color':
//   return ColorWidget(widgetData: widgetData);
      case 'file':
        return FileWidget(widgetData: widgetData);
      case 'number':
        return NumberWidget(widgetData: widgetData);
// case 'range':
//   return RangeWidget(widgetData: widgetData);
      case 'files':
        return FileWidget(widgetData: widgetData);
      case 'null':
        return NullWidget(widgetData: widgetData);
      case 'reader':
        return ReaderWidget(widgetData: widgetData);
      // case 'card':
      // return CardWidget(widgetData: widgetData);
      default:
        return TextWidget(widgetData: widgetData);
    }
  }
}
