import 'package:flutter/material.dart';
import 'package:uniturnip/json_schema_ui/models/mapPath.dart';

import '../widgets/array_buttons.dart';
import '../utils.dart';

class JSONSchemaUIField extends StatelessWidget {
  JSONSchemaUIField({
    Key? key,
    required this.schema,
    this.ui = const {},
    MapPath? path,
    dynamic pointer,
  })  : path = Utils.getPath(path, pointer, schema),
        super(key: key);

  final Map<String, dynamic> schema;
  final Map<String, dynamic> ui;
  final MapPath path;

  @override
  Widget build(BuildContext context) {
    List fields = Utils.retrieveSchemaFields(context: context, schema: schema, ui: ui, path: path);
    int length = fields.length;

    if (fields.isEmpty) {
      return const SizedBox.shrink();
    }

    String title = schema['title'] ?? '';
    String description = schema['description'] ?? '';

    Widget header;
    if (path.isLastObject() || path.isLastArray()) {
      header = ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(title),
        subtitle: Text(description),
      );
    } else {
      header = const SizedBox.shrink();
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        header,
        ListView.builder(
            shrinkWrap: true,
            itemCount: length,
            itemBuilder: (BuildContext context, int index) {
              dynamic field = fields[index];
              return Utils.getFieldLeaf(
                  path: path, ui: ui, schema: schema, field: field);
            }),
        path.isLastArray() ? ArrayPanel(path) : const SizedBox.shrink(),
      ],
    );
  }
}
