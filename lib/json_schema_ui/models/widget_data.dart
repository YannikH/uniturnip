import 'package:uniturnip/json_schema_ui/json_schema_ui.dart';
import 'package:uniturnip/json_schema_ui/models/mapPath.dart';


typedef WidgetCallback = void Function(MapPath path, dynamic value);

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
  final WidgetCallback onChange;
  final WidgetCallback? onBlur;
  final WidgetCallback? onFocus;
  final AudioRecordCallback? onRecord;

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
    this.onRecord,
  });

  String get title => schema['title'] ?? '';

  String get description => schema['description'] ?? '';

  String get type => schema['type'];
}
