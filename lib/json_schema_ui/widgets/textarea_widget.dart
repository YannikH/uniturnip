import 'package:flutter/material.dart';
import 'package:uniturnip/json_schema_ui/models/widget_data.dart';
import 'package:uniturnip/json_schema_ui/widgets/widget_ui.dart';

class TextareaWidget extends StatefulWidget {
  final WidgetData widgetData;

  const TextareaWidget({Key? key, required this.widgetData}) : super(key: key);

  @override
  State<TextareaWidget> createState() => _TextareaWidgetState();
}

class _TextareaWidgetState extends State<TextareaWidget> {
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
      child: TextFormField(
        validator: (val) {
          if (val == null || val.isEmpty) {
            return 'Required';
          }
          return null;
        },
        controller: textControl,
        onChanged: (val) => widget.widgetData.onChange(context, widget.widgetData.path, val),
        enabled: !widget.widgetData.disabled,
        autofocus: widget.widgetData.autofocus,
        readOnly: widget.widgetData.readonly,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
        maxLines: null,
        minLines: 4,
      ),
    );
  }
}
