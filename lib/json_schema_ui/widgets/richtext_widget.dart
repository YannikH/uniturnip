import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:uniturnip/json_schema_ui/widgets/widget_ui.dart';
import '../../../../json_schema_ui/models/widget_data.dart';



class RichTextWidget extends StatelessWidget {
  RichTextWidget({Key? key, required this.widgetData}) : super(key: key);

  final WidgetData widgetData;
  final TextEditingController textControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String title = widgetData.schema['title'] ?? '';
    String description = widgetData.schema['description'] ?? '';
    String content = widgetData.uiSchema['content']; // TODO: Add content to schemas.dart, in "ui"

    return WidgetUI(
      title: title,
      description: description,
      child: Markdown(
        data: content,
      ),
    );
  }
}

