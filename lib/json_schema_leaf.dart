import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniturnip/ui_model.dart';

class JSONSchemaFinalLeaf extends StatelessWidget {
  const JSONSchemaFinalLeaf(
      {Key? key,
        required this.schema,
        // this.ui = const {},
        required this.path})
      : super(key: key);

  final Map<String, dynamic> schema;
  // final Map<String, dynamic> ui;
  final List<String> path;

  @override
  Widget build(BuildContext context) {
    print('$path is rebuilding!');
    dynamic data = context.select((UIModel uiModel) => uiModel.getDataByPath(path));
    // print('Data inside field: $data');
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
          onChanged: (dynamic val) => onUpdate(context, path, val));
    } else if ((schema['type'] ?? 'not_defined') == 'boolean') {
      return CheckboxListTile(
          title: Text(schema['title']),
          value: data ?? schema['default'] ?? false,
          onChanged: (bool? val) => onUpdate(context, path, val));
    } else {
      return TextFormField(
        onChanged: (val) => onUpdate(context, path, val),
        decoration: decoration,
      );
    }
    // return const SizedBox.shrink();
  }

  void onUpdate(BuildContext context, List<String> path, dynamic value) {
    Provider.of<UIModel>(context, listen: false).modifyData(path, value);
  }
}
