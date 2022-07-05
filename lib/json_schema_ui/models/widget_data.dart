import 'package:flutter/material.dart';
import 'package:uniturnip/json_schema_ui/models/mapPath.dart';

class WidgetData {
  final Map<String, dynamic> schema;
  final MapPath path;
  final dynamic uiSchema;
  final dynamic value;
  final dynamic options;
  final bool readonly;
  final bool disabled;
  final bool required;
  final bool autofocus;
  final void Function(BuildContext context, MapPath path, dynamic value)
      onChange;
  final Function(BuildContext context, MapPath path, dynamic value)?
      onBlur;
  final Function(BuildContext context, MapPath path, dynamic value)?
      onFocus;

  WidgetData({
    required this.schema,
    required this.path,
    required this.onChange,
    this.uiSchema,
    this.value,
    this.options,
    this.readonly = false,
    this.disabled = false,
    this.required = false,
    this.autofocus = false,
    this.onBlur,
    this.onFocus,
  });

  String get title => schema['title'] ?? '';
  String get description => schema['description'] ?? '';
  String get type => schema['type'];
}
