import 'package:flutter/material.dart';
import 'dart:async';

import '../models/widget_data.dart';
import 'widget_ui.dart';


class DateWidget extends StatelessWidget {
  DateWidget({Key? key, required this.widgetData}) : super(key: key);

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
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2015, 8),
          lastDate: DateTime(2101));
      if (picked != null) {
        String _year = picked.year.toString();
        String _month = picked.month.toString().padLeft(2, '0');
        String _day = picked.day.toString().padLeft(2, '0');
        widgetData.onChange(context, widgetData.path, '$_day/$_month/$_year');
      }
    }

    return WidgetUI(
      title: title,
      description: description,
      child: TextFormField(
        validator: (val){
          if(val==null || val.isEmpty)
            return 'Please enter appropriate Date';
          return null;
        },
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
