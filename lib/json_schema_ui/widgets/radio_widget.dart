import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../../../../json_schema_ui/models/widget_data.dart';
import 'widget_ui.dart';

class RadioWidget extends StatelessWidget {
  const RadioWidget({Key? key, required this.widgetData}) : super(key: key);

  final WidgetData widgetData;

  @override
  Widget build(BuildContext context) {
    String title = widgetData.schema['title'] ?? '';
    String description = widgetData.schema['description'] ?? '';

    String type = widgetData.schema['type'];

    List items = [];
    List names = [];

    final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

    if (type == 'boolean') {
      items.addAll([true, false]);
      if (widgetData.schema['enumNames'] == null) {
        names.addAll(['Yes', 'No']);
      }
    } else {
      items.addAll(widgetData.schema['enum']);
      if (widgetData.schema['enumNames'] != null) {
        names.addAll(widgetData.schema['enumNames']);
      }
    }

    return WidgetUI(
      title: title,
      description: description,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) =>
              //     FormBuilderRadio(
              //   attribute: "best_language",
              //   leadingInput: true,
              //   onChanged: (dynamic newValue) =>
              //       widgetData.onChange(context, widgetData.path, newValue),
              //   validators: [FormBuilderValidators.required()],
              //   options: items.map((lang) => FormBuilderFieldOption(
              //     value: lang,
              //     child: Text('$lang'),
              //   )).toList(growable: false),
              // ),
              RadioListTile(
                  title: Text(names.length > index ? names[index] ?? items[index].toString() : items[index].toString()),
                  value: items[index],
                  groupValue: widgetData.value,
                  contentPadding: EdgeInsets.zero,
                  onChanged: (dynamic newValue) =>
                      widgetData.onChange(context, widgetData.path, newValue),
              ),
            ),
            items.contains(true) ? SizedBox.shrink() : Text(
                'Required',
                style: TextStyle(
                    color: Theme.of(context).errorColor
                ),
              ),
          ],
        ),
    );
  }
}
