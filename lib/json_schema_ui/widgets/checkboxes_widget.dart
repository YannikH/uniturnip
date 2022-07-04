import 'package:flutter/material.dart';

import '../models/widget_data.dart';

// TODO: Implement CheckboxesWidget
class CheckboxesWidget extends StatefulWidget {
  const CheckboxesWidget({Key? key, required this.widgetData})
      : super(key: key);

  final WidgetData widgetData;

  @override
  State<CheckboxesWidget> createState() => _CheckboxesWidgetState();
}

class _CheckboxesWidgetState extends State<CheckboxesWidget> {
  List values = [];

  @override
  Widget build(BuildContext context) {
    List items = widget.widgetData.schema['enum'] ?? [];
    List value = widget.widgetData.value ?? [];

    return ListView.builder(
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) => CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        autofocus: widget.widgetData.autofocus,
        title: Text(items[index]),
        value: value.contains(items[index]),
        onChanged: (dynamic newValue) {
          setState(() {
            newValue
                ? values.add(items[index])
                : values.removeWhere((element) => element == items[index]);
          });
          widget.widgetData.onChange(
            context,
            widget.widgetData.path,
            values,
          );
        },
      ),
    );
  }
}
