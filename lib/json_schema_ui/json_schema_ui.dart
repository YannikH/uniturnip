import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniturnip/json_schema_ui/models/mapPath.dart';
import 'package:uniturnip/json_schema_ui/models/ui_model.dart';

import 'fields/json_schema_field.dart';

class JSONSchemaUI extends StatelessWidget {
  JSONSchemaUI(
      {Key? key,
        this.schema = const {},
        this.ui = const {},
        this.data = const {},
        UIModel? controller,
        required this.onUpdate})
      : fields = schema['properties']?.keys?.toList() ?? [],
        controller = (controller == null)
            ? UIModel()
            : controller,
        super(key: key) {
    this.controller.data = data;
    this.controller.onUpdate = onUpdate;
  }

  final Map<String, dynamic> schema;
  final Map<String, dynamic> ui;
  final Map<String, dynamic> data;
  final List<String> fields;
  final UIModel controller;
  final void Function(
      {required MapPath path, required Map<String, dynamic> data})? onUpdate;
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UIModel>.value(
      value: controller,
      // create: (context) => UIModel(data: data, onUpdate: onUpdate),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              JSONSchemaUIField(
                schema: schema,
                ui: ui,
              ),

              // Button that submit the whole form using global key
              ElevatedButton(
                onPressed: (){
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
                child: const Text("Submit"),
              ),
            ],
          ),

        ),
      ),
    );
  }
}