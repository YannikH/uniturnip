import 'package:flutter/material.dart';
import 'package:uniturnip/json_schema_ui/models/widget_data.dart';

class CheckboxesWidget extends StatefulWidget {
  final WidgetData widgetData;

  const CheckboxesWidget({Key? key, required this.widgetData}) : super(key: key);

  @override
  State<CheckboxesWidget> createState() => _CheckboxesWidgetState();
}

class _CheckboxesWidgetState extends State<CheckboxesWidget> {
  List values = [];

  @override
  Widget build(BuildContext context) {
    List items = widget.widgetData.schema['enum'] ?? [];
    List? value = widget.widgetData.value;

    return Column(
      children: [
        for (var item in items)
          CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            autofocus: widget.widgetData.autofocus,
            title: Text(item),
            value: value?.contains(item),
            onChanged: (dynamic newValue) {
              setState(() {
                newValue ? values.add(item) : values.removeWhere((element) => element == item);
              });
              widget.widgetData.onChange(context, widget.widgetData.path, values);
            },
          ),
        if (widget.widgetData.required && (value == null || value.isEmpty))
          Text('Required', style: TextStyle(color: Theme.of(context).errorColor)),
      ],
    );
  }
}
