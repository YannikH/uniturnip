import 'package:flutter/material.dart';
import '../models/widget_data.dart';

class SelectWidget extends StatefulWidget {
  const SelectWidget({Key? key, required this.widgetData}) : super(key: key);

  final WidgetData widgetData;

  @override
  State<SelectWidget> createState() => _SelectWidgetState();
}

class _SelectWidgetState extends State<SelectWidget> {
  late List<String> _options;
  String selectedChoice = "";


  _buildList() {
    List<Widget> choices = [];
    _options = widget.widgetData.schema['enum'].cast<String>();
    for (var item in _options) {
      choices.add(Container(
        padding: EdgeInsets.only(top: 10.0, right: 10.0),
        child: ChoiceChip(
          label: Text(item),
          selectedColor: Colors.green,
          selected: selectedChoice == item,
          onSelected: (selected) {
            setState(() {
              selectedChoice = item;
              widget.widgetData.onChange(context, widget.widgetData.path, selected);
            });
          },
        ),
      ));
    }
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    _options = widget.widgetData.schema['enum'].cast<String>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.widgetData.schema['title']),
        Row(
          children: _buildList(),
        ),
      ],
    );
  }
}