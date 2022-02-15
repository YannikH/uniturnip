import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class JSONSchemaForm extends StatefulWidget {

  JSONSchemaForm({
    Key? key,
    this.schema = const {},
    this.ui = const {},
    this.data,
    this.name,
    this.path = const [],
    required this.onUpdate
  }) : fields = schema['properties']?.keys?.toList() ?? [],
        top = true,
        super(key: key);

  JSONSchemaForm._({
    Key? key,
    this.schema = const {},
    this.ui = const {},
    this.data,
    this.name,
    this.path = const [],
    required this.onUpdate
  }) : fields = schema['properties']?.keys?.toList() ?? [],
        top = false,
        super(key: key);

  final Map<String, dynamic> schema;
  final Map<String, dynamic> ui;
  final Map<String, dynamic>? data;
  final List<String> fields;
  final String? name;
  final List<String> path;
  final bool top;
  final void Function({
    dynamic data,
    required String field,
    required List<String> path
  }) onUpdate;


  @override
  State<JSONSchemaForm> createState() => _JSONSchemaFormState();
}

class _JSONSchemaFormState extends State<JSONSchemaForm> {
  // late Map<String, dynamic> _schema;
  // late Map<String, dynamic> _ui;
  dynamic _data;

  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      _data = widget.data;
    }
  }

  @override
  Widget build(BuildContext context) {
    print('FORM IS REBUILDING');
    return Column(mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ListView.builder(
            padding: const EdgeInsets.all(8),
            shrinkWrap: true,
            itemCount: widget.fields.length,
            itemBuilder: (BuildContext context, int index) {
              String field = widget.fields[index];
              List<String> newPath = [...widget.path];
              newPath.add(field);
              print('${widget.path}');
              print('$newPath');
              return JSONSchemaFormField(
                name: widget.name ?? field,
                schema: widget.schema['properties']?[field] ?? {},
                onUpdate: _update,
                data: _data?[field],
                path: newPath
                );
            }
          ),
          // Text('$_data')
        ]
    );
  }

  void _update({
    dynamic data,
    required String field,
    required List<String> path
  }) {
    Map<String, dynamic> newData = {...?_data};
    newData[field] = data;
    setState(() {
      _data = newData;
    });
    widget.onUpdate(data: newData, field: field, path: path);
  }

}


class JSONSchemaFormField extends StatelessWidget {
  const JSONSchemaFormField({
    Key? key,
    this.schema = const {},
    this.ui = const {},
    this.data,
    required this.name,
    required this.onUpdate,
    required this.path
  }) : super(key: key);

  final Map<String, dynamic> schema;
  final Map<String, dynamic> ui;
  final dynamic data;
  final String name;
  final List<String>path;
  final void Function({
    dynamic data,
    required String field,
    required List<String> path
  }) onUpdate;

  @override
  Widget build(BuildContext context) {
    print('${schema['title']} IS REBUILDING');
    InputDecoration decoration = InputDecoration(
        labelText: schema['title']
    );
    if (schema.containsKey('enum')) {
      List<String> options;
      try {
        options = schema['enum'].cast<String>();
      } on NoSuchMethodError catch (error) {
        return Text('Error: Enum field of ${schema['title']} field must be a List!');
      }
      return DropdownButtonFormField(
          value: data ?? options[0],
          items: options.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          decoration: decoration,
          onChanged: (dynamic val) => onUpdate(data: val, field: name, path: path));
    }
    else if ((schema['type'] ?? 'not_defined') == 'boolean') {
      return CheckboxListTile(
        title: Text(schema['title']),
        value: data ?? schema['default'] ?? false,
        onChanged: (bool? val) => onUpdate(data: val, field: name, path: path)
      );

    }
    else if ((schema['type'] ?? 'not_defined') == 'object') {
      return JSONSchemaForm._(
        schema: schema,
        data: data,
        name: name,
        onUpdate: onUpdate,
        path: path
      );
    }
    else {
      return TextFormField(
        onChanged: (val) => onUpdate(data: val, field: name, path: path),
        decoration: decoration,
      );
    }
    // else {
    //   return const SizedBox.shrink();
    // }
  }
}
