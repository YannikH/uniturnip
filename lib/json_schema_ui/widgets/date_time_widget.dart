import 'package:flutter/material.dart';
import 'dart:async';
import 'package:uniturnip/json_schema_ui/models/widget_data.dart';
import 'package:uniturnip/json_schema_ui/utilities/date_time.dart';
import 'package:uniturnip/json_schema_ui/widgets/widget_ui.dart';

class DateTimeWidget extends StatefulWidget {
  final WidgetData widgetData;

  const DateTimeWidget({Key? key, required this.widgetData}) : super(key: key);

  @override
  State<DateTimeWidget> createState() => _DateTimeWidgetState();
}

class _DateTimeWidgetState extends State<DateTimeWidget> {
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
    Future<void> _selectDate(BuildContext context) async {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101),
      );
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedDate != null && pickedTime != null) {
        final pickedDateTime = parseDateTime(pickedDate, pickedTime);
        widget.widgetData.onChange(context, widget.widgetData.path, pickedDateTime);
      }
    }

    return WidgetUI(
      title: title,
      description: description,
      child: TextFormField(
        controller: textControl,
        onChanged: (val) => widget.widgetData.onChange(context, widget.widgetData.path, val),
        enabled: !widget.widgetData.disabled,
        keyboardType: TextInputType.datetime,
        autofocus: widget.widgetData.autofocus,
        readOnly: true,
        onTap: () => _selectDate(context),
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          suffixIcon: IconButton(
            onPressed: () => _selectDate(context),
            icon: const Icon(Icons.calendar_today),
          ),
        ),
      ),
    );
  }
}
