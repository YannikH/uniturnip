import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniturnip/mapPath.dart';
import 'package:uniturnip/ui_model.dart';

import 'json_schema_leaf.dart';

class JSONSchemaUIField extends StatelessWidget {
  JSONSchemaUIField(
      {Key? key,
        required this.schema,
        this.ui = const {},
        MapPath? path,
        String? pointer
      }): path = (path == null) ? MapPath() : path.add(schema['type'], pointer),
        super(key: key);

  final Map<String, dynamic> schema;
  final Map<String, dynamic> ui;
  final MapPath path;

  @override
  Widget build(BuildContext context) {
    List<dynamic> fields;
    int length;
    if (schema['properties'] != null) {
      fields = schema['properties'].keys.toList();
      length = fields.length;
    } else if (schema['items'] != null) {
      length = context.select(
              (UIModel uiModel) => uiModel.getDataByPath(path).length
      );
      fields = Iterable<int>.generate(length).toList();
    } else {
      return const SizedBox.shrink();
    }

    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ListView.builder(
              padding: const EdgeInsets.all(8),
              shrinkWrap: true,
              itemCount: length,
              itemBuilder: (BuildContext context, int index) {
                dynamic field = fields[index];
                Map<String, dynamic> newSchema = schema['properties']?[field] ??
                    schema['items'] ?? {};
                String schemaType = newSchema['type'] ?? 'not_defined';
                if (schemaType == 'object') {
                  return JSONSchemaUIField(
                      schema: newSchema,
                      pointer: field,
                      path: path,);
                } else {
                  return JSONSchemaFinalLeaf(
                      schema: newSchema,
                      pointer: field,
                      path: path,);
                }
              }),
        ]);
  }
}


// class JSONSchemaUIArray extends JSONSchemaUIField{
//   JSONSchemaUIArray(
//       {Key? key,
//         required Map<String, dynamic> schema,
//         Map<String, dynamic> ui = const {},
//         required MapPath path,
//         required dynamic pointer,
//       }): super(key: key, schema: schema, pointer: pointer, path: path);
//
//
//   @override
//   Widget build(BuildContext context) {
//     dynamic arrayLength = context.select(
//             (UIModel uiModel) => uiModel.getDataByPath(path).length
//     );
//     return Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: <Widget>[
//           ListView.builder(
//               padding: const EdgeInsets.all(8),
//               shrinkWrap: true,
//               itemCount: arrayLength,
//               itemBuilder: (BuildContext context, int index) {
//                 List<String> newPath = [...path];
//                 newPath.add($index);
//                 return _buildJSONSchemaField(
//                   schema: schema['items'] ?? {},
//                   path: newPath,
//                   context: context,);
//               }),
//         ]);
//   }
//
// }