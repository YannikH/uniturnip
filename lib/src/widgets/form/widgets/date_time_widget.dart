import 'package:flutter/material.dart';
import 'dart:async';

import '../models/widget_data.dart';

class DateTimeWidget extends StatelessWidget {
  const DateTimeWidget({Key? key, required this.widgetData}) : super(key: key);

  final WidgetData widgetData;

  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = DateTime.now();
    TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

    Future<void> _selectDate(BuildContext context) async {
      final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2015, 8),
          lastDate: DateTime(2101));
      final TimeOfDay? pickedTime =
          await showTimePicker(context: context, initialTime: selectedTime);
      if (pickedDate != null && pickedTime != null) {
        String _year = pickedDate.year.toString();
        String _month = pickedDate.month.toString().padLeft(2, '0');
        String _day = pickedDate.day.toString().padLeft(2, '0');
        String _hour = pickedTime.hour.toString().padLeft(2, '0');
        String _minute = pickedTime.minute.toString().padLeft(2, '0');

        String picked = '$_day-$_month-$_year $_hour:$_minute';
        print('DateTime: $picked');
        widgetData.onChange(context, widgetData.path, picked);
      }
    }

    return ElevatedButton(
      onPressed: () => _selectDate(context),
      child: Text('Select date&time'),
    );
  }
}
