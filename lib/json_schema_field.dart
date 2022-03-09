import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniturnip/mapPath.dart';
import 'package:uniturnip/ui_model.dart';

import 'array_buttons.dart';
import 'json_schema_leaf.dart';

class JSONSchemaUIField extends StatelessWidget {
  JSONSchemaUIField({
    Key? key,
    required this.schema,
    this.ui = const {},
    MapPath? path,
    dynamic pointer,
  })  : path = (path == null)
            ? MapPath()
            : (pointer == null)
                ? path
                : path.add(schema['type'], pointer),
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
      if (ui.containsKey('ui:order')) {
        List<dynamic> uiOrder = ui['ui:order'] ?? [];
        List<dynamic> orderList = [...uiOrder, ...fields];
        Map<String, dynamic> order = { for (var key in orderList) key : orderList.indexOf(key) };
        fields.sort((a, b) => order[a].compareTo(order[b]));
      }
    } else if (schema['items'] != null) {
      length = context.select(
          (UIModel uiModel) => uiModel.getDataByPath(path)?.length ?? 1);
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
                Map<String, dynamic> newSchema =
                    schema['properties']?[field] ?? schema['items'] ?? {};
                String schemaType = newSchema['type'] ?? 'not_defined';
                Map<String, dynamic> newUiSchema = ui[field] ?? ui['items'] ?? {};
                if (schemaType == 'object' || schemaType == 'array') {
                  return JSONSchemaUIField(
                    schema: newSchema,
                    ui: newUiSchema,
                    pointer: field,
                    path: path,
                  );
                } else {
                  // print('Dependencies field ${schema['dependencies']?[field]}');
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        JSONSchemaFinalLeaf(
                          schema: newSchema,
                          ui: newUiSchema,
                          pointer: field,
                          path: path,
                        ),
                        field != null && schema['dependencies']?[field] != null && path != null
                            ? JSONSchemaTest(
                            schema: schema['dependencies']?[field],
                            ui: ui,
                            path: path,
                            pointer: field)
                            : const SizedBox.shrink(),
                      ]);
                }
              }),
          path.isLastArray() ? ArrayPanel(path) : const SizedBox.shrink(),
        ]);
  }
}

// class JSONSchemaDependency extends JSONSchemaUIField {
//   JSONSchemaDependency({
//     Key? key,
//     required Map<String, dynamic> schema,
//     Map<String, dynamic> ui = const {},
//     required MapPath path,
//     required this.pointer,
//   }) : super(key: key, schema: schema, pointer: pointer, path: path);
//
//   final dynamic pointer;
//
//   @override
//   Widget build(BuildContext context) {
//     print('Detected dependency controller!!!!');
//     dynamic data =
//         context.select((UIModel uiModel) => uiModel.getDataByPath(path));
//     print('Detected dependency controller change: $data');
//     List<Map<String, dynamic>> oneOf = schema['oneOf'] ?? [];
//     for (Map<String, dynamic> dependency in oneOf) {
//       List<dynamic> options = dependency['properties']?[pointer]?['enum'] ?? [];
//       if (options.contains(data)) {
//         Map<String, dynamic> newSchema = {...dependency};
//         newSchema.remove(pointer);
//         newSchema['type'] = 'object';
//         MapPath newPath = path.removeLast();
//         return JSONSchemaUIField(schema: newSchema, path: newPath);
//       }
//     }
//     return const SizedBox.shrink();
//   }
// }


class JSONSchemaTest extends StatelessWidget {
  JSONSchemaTest({
    Key? key,
    required Map<String, dynamic> this.schema,
    this.ui = const {},
    required MapPath path,
    required this.pointer,
  }) : path = path.add('leaf', pointer), super(key: key);

  final dynamic pointer;
  final MapPath path;
  final Map<String, dynamic> schema;
  final Map<String, dynamic> ui;


  @override
  Widget build(BuildContext context) {
    print('Detected dependency controller!!!!');
    dynamic data =
    context.select((UIModel uiModel) => uiModel.getDataByPath(path));
    print('Detected dependency controller change: $data');
    List<dynamic> oneOf = schema['oneOf'] ?? [];
    for (Map<String, dynamic> dependency in oneOf) {
      List<dynamic> options = dependency['properties']?[pointer]?['enum'] ?? [];
      if (options.contains(data)) {
        Map<String, dynamic> newSchema = {...dependency};
        Map<String, dynamic> newSchemaProperties = {...dependency['properties']};
        newSchemaProperties.remove(pointer);
        newSchema['properties'] = newSchemaProperties;
        newSchema['type'] = 'object';
        MapPath newPath = path.removeLast();
        String field = newSchemaProperties.keys.first;
        Map<String, dynamic> newUiSchema = ui.containsKey(field) ? {field : ui[field]} : {};
        return JSONSchemaUIField(schema: newSchema, ui: newUiSchema, path: newPath);
      }
    }
    return Text('DEPENDENCY POINTER: $pointer, SCHEMA: $schema, PATH: $path');
  }
}


