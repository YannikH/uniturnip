import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniturnip/json_schema_ui/fields/object_field.dart';
import 'package:uniturnip/json_schema_ui/models/mapPath.dart';
import 'package:uniturnip/json_schema_ui/models/ui_model.dart';

typedef OnChangeCallback = void Function({
  required MapPath path,
  required Map<String, dynamic> data,
});

typedef OnSubmitCallback = void Function({
  required Map<String, dynamic> data,
});

class JSONSchemaUI extends StatelessWidget {
  JSONSchemaUI({
    Key? key,
    required this.schema,
    this.ui = const {},
    this.data = const {},
    required this.onUpdate,
    required this.onSubmit,
  }) : super(key: key);

  final Map<String, dynamic> schema;
  final Map<String, dynamic> ui;
  final Map<String, dynamic> data;
  final OnChangeCallback? onUpdate;
  final OnSubmitCallback? onSubmit;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UIModel>(
      create: (context) => UIModel(data: data, onUpdate: onUpdate),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              JSONSchemaUIField(
                schema: schema,
                ui: ui,
              ),

              // Button that submit the whole form using global key
              Builder(builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      onSubmit!(data: context.read<UIModel>().data);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }
                  },
                  child: const Text("Submit"),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
