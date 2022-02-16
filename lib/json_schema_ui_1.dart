import 'dart:collection';

import 'package:flutter/material.dart';
//
// class UIModel extends ChangeNotifier {
//   /// Internal, private state of the UI.
//   final Map<String, dynamic> _data = {};
//
//   /// An unmodifiable view of the items in the cart.
//   UnmodifiableMapView<String, dynamic> get data => UnmodifiableMapView<String, dynamic>(_data);
//
//
//   /// Removes all items from the cart.
//   Map<String, dynamic> modifyData(List<String> path, Map<String, dynamic> data, dynamic value) {
//     if (path.isNotEmpty) {
//       if (path.length > 1) {
//         data[path.removeAt(0)] ??= {};
//         Map<String, dynamic> rdata = data[path.removeAt(0)];
//         modifyData(path, rdata, value);
//       }
//       else {
//         data[path.first] = value;
//       }
//     }
//     return data;
//   }
//
//   Map<String, dynamic>
// }

class JSONSchemaUI extends StatelessWidget {
  JSONSchemaUI(
      {Key? key,
      this.schema = const {},
      this.ui = const {},
      this.data,
      this.name,
      this.path = const [],
      required this.onUpdate})
      : fields = schema['properties']?.keys?.toList() ?? [],
        top = true,
        super(key: key);

  JSONSchemaUI._(
      {Key? key,
      this.schema = const {},
      this.ui = const {},
      this.data,
      this.name,
      this.path = const [],
      required this.onUpdate})
      : fields = schema['properties']?.keys?.toList() ?? [],
        top = false,
        super(key: key);

  final Map<String, dynamic> schema;
  final Map<String, dynamic> ui;
  final Map<String, dynamic>? data;
  final List<String> fields;
  final String? name;
  final List<String> path;
  final bool top;
  final void Function(
      {dynamic data,
      required String field,
      required List<String> path}) onUpdate;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ListView.builder(
              padding: const EdgeInsets.all(8),
              shrinkWrap: true,
              itemCount: fields.length,
              itemBuilder: (BuildContext context, int index) {
                String field = fields[index];
                List<String> newPath = [...path];
                newPath.add(field);
                // print('$path');
                // print('$newPath');
                return _buildJSONSchemaField(
                    name: name ?? field,
                    schema: schema['properties']?[field] ?? {},
                    data: data?[field],
                    path: newPath);
              }),
          // Text('$_data')
        ]);
  }

  Widget _buildJSONSchemaField(
      {required String name,
      required Map<String, dynamic> schema,
      required dynamic data,
      required List<String> path}) {
    // print('${schema['title']} IS REBUILDING');
    InputDecoration decoration = InputDecoration(labelText: schema['title']);
    if (schema.containsKey('enum')) {
      List<String> options;
      try {
        options = schema['enum'].cast<String>();
      } on NoSuchMethodError catch (error) {
        return Text(
            'Error: Enum field of ${schema['title']} field must be a List!');
      }
      return DropdownButtonFormField(
          value: data ?? options[0],
          items: options
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          decoration: decoration,
          onChanged: (dynamic val) =>
              onUpdate(data: val, field: name, path: path));
    } else if ((schema['type'] ?? 'not_defined') == 'boolean') {
      return CheckboxListTile(
          title: Text(schema['title']),
          value: data ?? schema['default'] ?? false,
          onChanged: (bool? val) =>
              onUpdate(data: val, field: name, path: path));
    } else if ((schema['type'] ?? 'not_defined') == 'object') {
      return JSONSchemaUI._(
          schema: schema,
          data: data?.cast<String, dynamic>(),
          name: name,
          onUpdate: onUpdate,
          path: path);
    } else {
      return TextFormField(
        onChanged: (val) => onUpdate(data: val, field: name, path: path),
        decoration: decoration,
      );
    }
    // return const SizedBox.shrink();
  }
}
