import 'package:flutter/material.dart';
import 'models/widget_data.dart';
import 'widgets.dart';

class Utils {
  static Widget _formWidget(
      {required String widget, required WidgetData widgetData}) {
    switch (widget) {
      case 'checkbox':
        return CheckboxWidget(widgetData: widgetData);
// case 'radio':
//   return RadioWidget(widgetData: widgetData);
// case 'select':
//   return SelectWidget(widgetData: widgetData);
// case 'hidden':
//   return HiddenWidget(widgetData: widgetData);
      case 'text':
        return TextWidget(widgetData: widgetData);
// case 'password':
//   return PasswordWidget(widgetData: widgetData);
// case 'email':
//   return EmailWidget(widgetData: widgetData);
// case 'uri':
//   return URLWidget(widgetData: widgetData);
// case 'data-url':
//   return FileWidget(widgetData: widgetData);
// case 'textarea':
//   return TextareaWidget(widgetData: widgetData);
// case 'date':
//   return DateWidget(widgetData: widgetData);
// case 'datetime':
//   return DateTimeWidget(widgetData: widgetData);
// case 'date-time':
//   return DateTimeWidget(widgetData: widgetData);
// case 'color':
//   return ColorWidget(widgetData: widgetData);
// case 'file':
//   return FileWidget(widgetData: widgetData);
// case 'updown':
//   return UpDownWidget(widgetData: widgetData);
// case 'range':
//   return RangeWidget(widgetData: widgetData);
// case 'checkboxes':
//   return CheckboxesWidget(widgetData: widgetData);
// case 'files':
//   return FileWidget(widgetData: widgetData);
// case 'null':
//   return NullWidget(widgetData: widgetData);
      default:
        return TextWidget(widgetData: widgetData);
    }
  }

  static _defaultWidgetType({required type}) {
    // Return default widget for fields types.
    switch (type) {
      case 'string':
        return 'text';
      case 'integer':
        return 'updown';
      case 'number':
        return 'updown';
      case 'boolean':
        return 'checkbox';
      case 'null':
        return 'null';
    }
  }

  static formWidget(WidgetData widgetData) {
    // Return widget that fits schema or uiSchema conditions.
    // Conditions priority: [ui:widget] --> [format] --> [enum] --> [type].
    final uiSchema = widgetData.uiSchema;
    final schema = widgetData.schema;

    final String widget;
    final String type = schema['type'];

    if (uiSchema != null && uiSchema.containsKey('ui:widget')) {
      widget = uiSchema['ui:widget'];
      return _formWidget(widget: widget, widgetData: widgetData);
    } else if (schema.containsKey('format')) {
      widget = schema['format'];
      return _formWidget(widget: widget, widgetData: widgetData);
    } else if (schema.containsKey('enum') &&
        (type != 'boolean' || type != 'null')) {
      widget = 'select';
      return _formWidget(widget: widget, widgetData: widgetData);
    } else {
      widget = _defaultWidgetType(type: type);
      return _formWidget(widget: widget, widgetData: widgetData);
    }
  }
}
