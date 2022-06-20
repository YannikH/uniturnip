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
    List<String> requiredList = schema['required'] ?? [];

    if (fields.isEmpty) {
      return const SizedBox.shrink();
    }

    Widget header;
    if ((path.isLastObject() || path.isLastArray()) && schema['title'] != null) {
      Widget title = schema['title'] != null
          ? Text(schema['title'], style: Theme.of(context).textTheme.headline6)
          : const SizedBox.shrink();
      Widget description =
          schema['description'] != null ? Text(schema['description']) : const SizedBox.shrink();

      header = Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title,
            description,
            const Divider(height: 10),
          ],
        ),
      );
    } else {
      header = const SizedBox.shrink();
    }

    void setTitleDescription(field){
      String title = ui[field]?['ui:title'] ?? schema['properties']?[field]['title'] ?? '';
      String description = ui[field]?['ui:description'] ?? schema['properties']?[field]['description'] ?? '';
      schema['properties']?[field]['description'] = description;
      if (requiredList.contains(field) && !title.contains('*')) {
        schema['properties']?[field]['title'] = title + '*';
      } else {
        schema['properties']?[field]['title'] = title;
      }
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
              setTitleDescription(field);
              String uiHelp = ui[field]?['ui:help'] ?? '';
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Utils.getFieldLeaf(path: path, ui: ui, schema: schema, field: field),
                    if (uiHelp.isNotEmpty) Text(uiHelp, style: const TextStyle(color: Colors.black54, fontSize: 16.0))
                  ]
              );
            }),
        path.isLastArray() ? ArrayPanel(path) : const SizedBox.shrink(),
      ],
    );
  }
}
