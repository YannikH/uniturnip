import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:uniturnip/json_schema_ui/widgets/widget_ui.dart';
import 'package:uniturnip/json_schema_ui/models/widget_data.dart';

class TextWidget extends StatefulWidget {
  final WidgetData widgetData;

  const TextWidget({Key? key, required this.widgetData}) : super(key: key);

  @override
  State<TextWidget> createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
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
    if (widget.widgetData.schema.containsKey('examples')) {
      List<String> _options = widget.widgetData.schema['examples'];

      return WidgetUI(
        title: title,
        description: description,
        child: Autocomplete<String>(
          fieldViewBuilder: (
            BuildContext context,
            TextEditingController textEditingController,
            FocusNode focusNode,
            VoidCallback onFieldSubmitted,
          ) {
            return TextFormField(
              validator: RequiredValidator(
                errorText: 'Please enter a text',
              ),
              controller: textEditingController,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              focusNode: focusNode,
              onChanged: (val) => widget.widgetData.onChange(context, widget.widgetData.path, val),
              onFieldSubmitted: (String value) {
                onFieldSubmitted();
              },
            );
          },
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text == '') {
              return const Iterable<String>.empty();
            }
            return _options.where((String option) {
              String lowerOption = option.toString().toLowerCase();
              return lowerOption.contains(textEditingValue.text.toLowerCase());
            });
          },
          onSelected: (String selection) {
            widget.widgetData.onChange(context, widget.widgetData.path, selection);
          },
        ),
      );
    }

    return WidgetUI(
      title: title,
      description: description,
      child: TextFormField(
        validator: RequiredValidator(
          errorText: 'Please enter a text',
        ),
        controller: textControl,
        onChanged: (val) => widget.widgetData.onChange(context, widget.widgetData.path, val),
        enabled: !widget.widgetData.disabled,
        autofocus: widget.widgetData.autofocus,
        readOnly: widget.widgetData.readonly,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
