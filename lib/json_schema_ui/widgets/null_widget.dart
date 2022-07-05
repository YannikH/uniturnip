import 'package:flutter/material.dart';
import '../models/widget_data.dart';
import 'widget_ui.dart';

class NullWidget extends StatelessWidget {
  NullWidget({Key? key, required this.widgetData}) : super(key: key);

  final WidgetData widgetData;
  final TextEditingController textControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String title = widgetData.schema['title'] ?? '';
    String description = widgetData.schema['description'] ?? '';
    textControl.text = widgetData.value.toString();
    textControl.selection = TextSelection.fromPosition(
      TextPosition(offset: textControl.text.length),
    );

    return WidgetUI(
      title: title,
      description: description,
      child: const SizedBox.shrink(),
    );
  }
}
