import 'package:flutter/material.dart';
import '../../../../json_schema_ui/models/widget_data.dart';

class SelectWidget extends StatelessWidget {
  const SelectWidget({Key? key, required this.widgetData}) : super(key: key);

  final WidgetData widgetData;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      alignment: Alignment.center,
      autofocus: widgetData.autofocus,
      hint: const Text('Select item'),
      value: widgetData.value ,
      elevation: 16,
      isExpanded: true,
      style: const TextStyle(color: Colors.indigoAccent),
      underline: Container(
        height: 2,
        color: Colors.blueGrey,
      ),
      onChanged: (String? newValue) {
        widgetData.onChange(context, widgetData.path, newValue);
      },
      items: widgetData.schema['enum'].cast<String>()
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          alignment: AlignmentDirectional.center,
          enabled: !widgetData.disabled,
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}