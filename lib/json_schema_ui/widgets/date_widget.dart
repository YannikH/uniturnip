import 'package:flutter/material.dart';
import 'dart:async';
import 'package:uniturnip/json_schema_ui/models/widget_data.dart';
import 'package:uniturnip/json_schema_ui/utilities/date_time.dart';
import 'package:uniturnip/json_schema_ui/widgets/widget_ui.dart';

class DateWidget extends StatefulWidget {
  DateWidget({Key? key, required this.widgetData}) : super(key: key);

  final WidgetData widgetData;

  @override
  State<DateWidget> createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {
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

      if (pickedDate != null) {
        final date = parseDate(pickedDate);
        widget.widgetData.onChange(context, widget.widgetData.path, date);
      }
    }

    return WidgetUI(
      title: title,
      description: description,
      child: TextFormField(
        validator: (val) {
          if (val == null || val.isEmpty) return 'Please enter appropriate Date';
          return null;
        },
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
