import 'package:flutter/material.dart';
import 'dart:async';

import '../../../../json_schema_ui/models/widget_data.dart';
import 'widget_ui.dart';

class DateTimeWidget extends StatelessWidget {
  DateTimeWidget({Key? key, required this.widgetData}) : super(key: key);

  final WidgetData widgetData;
  final TextEditingController textControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String title = widgetData.schema['title'] ?? '';
    String description = widgetData.schema['description'] ?? '';

    textControl.text = widgetData.value ?? '';
    textControl.selection = TextSelection.fromPosition(
      TextPosition(offset: textControl.text.length),
    );

    Future<void> _selectDate(BuildContext context) async {
      final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2015, 8),
          lastDate: DateTime(2101));
      final TimeOfDay? pickedTime =
          await showTimePicker(context: context, initialTime: TimeOfDay.now());
      if (pickedDate != null && pickedTime != null) {
        String _year = pickedDate.year.toString();
        String _month = pickedDate.month.toString().padLeft(2, '0');
        String _day = pickedDate.day.toString().padLeft(2, '0');
        String _hour = pickedTime.hour.toString().padLeft(2, '0');
        String _minute = pickedTime.minute.toString().padLeft(2, '0');

        String picked = '$_day-$_month-$_year $_hour:$_minute';
        widgetData.onChange(context, widgetData.path, picked);
      }
    }

    return WidgetUI(
      title: title,
      description: description,
      child: TextFormField(
        controller: textControl,
        onChanged: (val) => widgetData.onChange(context, widgetData.path, val),
        enabled: !widgetData.disabled,
        keyboardType: TextInputType.datetime,
        autofocus: widgetData.autofocus,
        readOnly: true,
        onTap: () => _selectDate(context),
        decoration: InputDecoration(border: const OutlineInputBorder(), suffixIcon: IconButton(
          onPressed: () => _selectDate(context),
          icon: const Icon(Icons.calendar_today),
        )),
      ),
    );
  }
}
