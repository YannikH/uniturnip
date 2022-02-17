import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:uniturnip/utils.dart';

class UIModelProvider extends ChangeNotifier {
  UIModelProvider({required data}) : _data = data;

  Map<String, dynamic> _data;

  UnmodifiableMapView<String, dynamic> get data => UnmodifiableMapView<String, dynamic>(_data);

  void modifyData(List<String> path, dynamic value) {
    _data = Utils.modifyMapByPath(path, _data, value);
    notifyListeners();
  }

  // Map<String, dynamic>
}

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
  final void Function({dynamic data, required List<String> path}) onUpdate;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UIModelProvider>(
        create: (context) => UIModelProvider(data: data),
        child: JSONSchemaUIField(
          schema: schema,
          data: data?.cast<String, dynamic>(),
          onUpdate: onUpdate);
    );
  }
}

class JSONSchemaUIField extends StatelessWidget {
  JSONSchemaUIField(
      {Key? key,
      this.schema = const {},
      this.ui = const {},
      this.data,
      this.path = const [],
      required this.onUpdate})
      : fields = schema['properties']?.keys?.toList() ?? [],
        super(key: key);

  final Map<String, dynamic> schema;
  final Map<String, dynamic> ui;
  final Map<String, dynamic>? data;
  final List<String> fields;
  final List<String> path;
  final void Function({dynamic data, required List<String> path}) onUpdate;

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
                return _buildJSONSchemaField(
                    schema: schema['properties']?[field] ?? {},
                    data: data?[field],
                    path: newPath);
              }),
          // Text('$_data')
        ]);
  }

  Widget _buildJSONSchemaField(
      {required Map<String, dynamic> schema,
      required dynamic data,
      required List<String> path}) {
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
          onChanged: (dynamic val) => onUpdate(data: val, path: path));
    } else if ((schema['type'] ?? 'not_defined') == 'boolean') {
      return CheckboxListTile(
          title: Text(schema['title']),
          value: data ?? schema['default'] ?? false,
          onChanged: (bool? val) => onUpdate(data: val, path: path));
    } else if ((schema['type'] ?? 'not_defined') == 'object') {
      return JSONSchemaUIField(
          schema: schema,
          data: data?.cast<String, dynamic>(),
          onUpdate: onUpdate,
          path: path);
    } else {
      return TextFormField(
        onChanged: (val) => onUpdate(data: val, path: path),
        decoration: decoration,
      );
    }
    // return const SizedBox.shrink();
  }
}
