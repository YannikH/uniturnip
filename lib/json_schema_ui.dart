import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniturnip/ui_model.dart';

import 'json_schema_field.dart';


class JSONSchemaUI extends StatelessWidget {
  JSONSchemaUI(
      {Key? key,
      this.schema = const {},
      this.ui = const {},
      this.data,
      required this.onUpdate})
      : fields = schema['properties']?.keys?.toList() ?? [],
        super(key: key);

  final Map<String, dynamic> schema;
  final Map<String, dynamic> ui;
  final Map<String, dynamic>? data;
  final List<String> fields;
  final void Function(
      {required List<String> path,
      required Map<String, dynamic> data})? onUpdate;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UIModel>(
        create: (context) => UIModel(data: data, onUpdate: onUpdate),
        child: JSONSchemaUIField(
            schema: schema,
        ));
  }
}