import 'package:flutter/material.dart';
import 'dart:async';

import '../models/widget_data.dart';

// TODO: Implement DateWidget
class DateWidget extends StatelessWidget {
  const DateWidget({Key? key, required this.widgetData}) : super(key: key);

  final WidgetData widgetData;

  @override
  Widget build(BuildContext context) {

    DateTime selectedDate = widgetData.value ?? DateTime.now();

    Future<void> _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2015, 8),
          lastDate: DateTime(2101));
      if (picked != null && picked != selectedDate) {
        widgetData.onChange(context, widgetData.path, picked);
      }
    }

    return ElevatedButton(
      onPressed: () => _selectDate(context),
      child: Text('Select date'),
    );
  }
}
