import 'package:flutter/material.dart';
import 'package:uniturnip/json_schema_ui/widgets/widget_ui.dart';
import 'package:uniturnip/json_schema_ui/models/widget_data.dart';

class TextWidget extends StatelessWidget {
  TextWidget({Key? key, required this.widgetData}) : super(key: key);

  final WidgetData widgetData;
  final TextEditingController textControl = TextEditingController();

  final _val = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String title = widgetData.schema['title'] ?? '';
    String description = widgetData.schema['description'] ?? '';
    textControl.text = widgetData.value.toString();
    textControl.selection = TextSelection.fromPosition(
      TextPosition(offset: textControl.text.length),
    );

    if (widgetData.schema.containsKey('examples')) {
      List<String> _options = widgetData.schema['examples'];

      return WidgetUI(
        title: title,
        description: description,
        child: Autocomplete<String>(
          fieldViewBuilder: (BuildContext context,
              TextEditingController textEditingController,
              FocusNode focusNode, VoidCallback onFieldSubmitted) {
            return Form(
              key: _val,
              child: Column(
                children: <Widget>[TextFormField(
                  validator: (val){
                    if(val==null || val.isEmpty)
                      return 'Please enter the text';
                    return null;
                  },
                  controller: textEditingController,
                  decoration: const InputDecoration(border: OutlineInputBorder()),
                  focusNode: focusNode,
                  onChanged: (val) => widgetData.onChange(context, widgetData.path, val),
                  onFieldSubmitted: (String value) {
                    onFieldSubmitted();
                    print('You just typed a new entry  $value');
                  },
                ),
                  ElevatedButton(onPressed: () {
                    _val.currentState!.validate();
                  }, child: Text('Enter')),
              ]
              ),
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
            widgetData.onChange(context, widgetData.path, selection);
          },
        ),
      );
    }

    return WidgetUI(
      title: title,
      description: description,
      child: TextFormField(
        controller: textControl,
        onChanged: (val) => widgetData.onChange(context, widgetData.path, val),
        enabled: !widgetData.disabled,
        autofocus: widgetData.autofocus,
        readOnly: widgetData.readonly,
        decoration: const InputDecoration(border: OutlineInputBorder()),
      ),
    );
  }
}
