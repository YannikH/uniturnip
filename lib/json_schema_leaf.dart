import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniturnip/json_schema_field.dart';
import 'package:uniturnip/ui_model.dart';

import 'mapPath.dart';

class JSONSchemaFinalLeaf extends JSONSchemaUIField{
  JSONSchemaFinalLeaf(
      {Key? key,
        required Map<String, dynamic> schema,
        Map<String, dynamic> ui = const {},
        required MapPath path,
        required dynamic pointer,
      }): super(key: key, schema: schema, pointer: pointer, path: path);

  final TextEditingController textControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //print('$path is rebuilding!');
    // print('Schema: $schema');
    List<dynamic> dataList = context.select(
            (UIModel uiModel) => [uiModel.getDataByPath(path), uiModel.isExternal]
    );
    dynamic data = dataList[0];
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
      if (dataList[1]) {
        textControl.text = data ?? '';
        textControl.selection = TextSelection.fromPosition(
          TextPosition(offset: textControl.text.length),
        );
        return TextFormField(
          controller: textControl,
          // initialValue: data ?? '',
          onChanged: (val) => onUpdate(context, path, val),
          decoration: decoration,
        );
      } else {
        return TextFormField(
          initialValue: data ?? '',
          onChanged: (val) => onUpdate(context, path, val),
          decoration: decoration,
        );
      }

    }
    // return const SizedBox.shrink();
  }

  void onUpdate(BuildContext context, MapPath path, dynamic value) {
    Provider.of<UIModel>(context, listen: false).modifyData(path, value);
  }
}
