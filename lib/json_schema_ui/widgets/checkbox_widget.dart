import 'package:flutter/material.dart';
import '../../../../json_schema_ui/models/widget_data.dart';

class CheckboxWidget extends StatelessWidget {
  const CheckboxWidget({Key? key, required this.widgetData}) : super(key: key);

  final WidgetData widgetData;

  @override
  Widget build(BuildContext context) {
    String title = widgetData.schema['title'] ?? '';
    // String description = widgetData.schema['description'] ?? '';

    final _val = GlobalKey<FormState>();

    return FormField<bool>(
      validator: (_val) {
        if (!widgetData.value == false) {
          return 'You need to accept terms';
        }
      },
      builder: (FormFieldState<dynamic> field) {
        return Column(
          children: [
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              autofocus: widgetData.autofocus,    //true
              value: true == widgetData.value,
                onChanged: (dynamic newValue) {
                  widgetData.onChange(context, widgetData.path, newValue);
                },
              title: Text(title),
              ),
            ElevatedButton(onPressed: () {
              _val.currentState!.validate(  );
            }, child: Text('drag')),
          ],
        );
        },
  );
}
}
