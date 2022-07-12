import 'package:flutter/material.dart';

class WidgetUI extends StatelessWidget {
  final Widget child;
  final String title;
  final String description;
  final bool required;

  const WidgetUI({
    Key? key,
    required this.title,
    required this.description,
    required this.required,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: title.isNotEmpty
              ? Text(required ? '$title*' : title, style: const TextStyle(fontWeight: FontWeight.bold))
              : null,
          subtitle: description.isNotEmpty ? Text(description) : null,
        ),
        description.isNotEmpty ? const SizedBox(height: 8) : const SizedBox.shrink(),
        child,
      ],
    );
  }
}
