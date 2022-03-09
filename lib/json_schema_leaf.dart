import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniturnip/json_schema_field.dart';
import 'package:uniturnip/src/widgets/form/models/widget_data.dart';
import 'package:uniturnip/src/widgets/form/utils.dart';
import 'package:uniturnip/ui_model.dart';

import 'mapPath.dart';

class JSONSchemaFinalLeaf extends JSONSchemaUIField{
  JSONSchemaFinalLeaf(
      {Key? key,
        required Map<String, dynamic> schema,
        Map<String, dynamic> ui = const {},
        required MapPath path,
        required dynamic pointer,
      }): super(key: key, schema: schema, ui: ui, pointer: pointer, path: path){
    print('Path: ${this.path}');
  }

  final TextEditingController textControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print('$path is rebuilding!');
    dynamic data = context.select(
            (UIModel uiModel) {
              return uiModel.getDataByPath(path);
            }
    );

    final WidgetData widgetData =
    WidgetData(schema: schema, value: data, path: path, onChange: onUpdate);
    return Utils.formWidget(widgetData);
  }

  void onUpdate(BuildContext context, MapPath path, dynamic value) {
    Provider.of<UIModel>(context, listen: false).modifyData(path, value);
  }
}
