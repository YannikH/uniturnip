import 'package:flutter/material.dart';
import 'package:uniturnip/json_schema_ui/models/widget_data.dart';
import 'package:uniturnip/json_schema_ui/widgets/widget_ui.dart';

class NullWidget extends StatelessWidget {
  final WidgetData widgetData;

  const NullWidget({Key? key, required this.widgetData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title = widgetData.title;
    String description = widgetData.description;

    return WidgetUI(
      title: title,
      description: description,
      child: const SizedBox.shrink(),
    );
  }
}
