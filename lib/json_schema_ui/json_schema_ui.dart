import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniturnip/json_schema_ui/fields/object_field.dart';
import 'package:uniturnip/json_schema_ui/models/mapPath.dart';
import 'package:uniturnip/json_schema_ui/models/ui_model.dart';

typedef ChangeCallback = void Function({
  required MapPath path,
  required Map<String, dynamic> data,
});

typedef SubmitCallback = void Function({
  required Map<String, dynamic> data,
});

typedef SaveAudioRecordCallback = Future<String> Function(String filepath);

class JSONSchemaUI extends StatelessWidget {
  final Map<String, dynamic> schema;
  final Map<String, dynamic> ui;
  final Map<String, dynamic> data;
  final ChangeCallback? onUpdate;
  final SubmitCallback? onSubmit;
  final SaveAudioRecordCallback? saveAudioRecord;
  final bool disabled;

  JSONSchemaUI({
    Key? key,
    required this.schema,
    this.ui = const {},
    this.data = const {},
    this.disabled = false,
    this.onUpdate,
    this.onSubmit,
    this.saveAudioRecord,
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UIModel>(
      create: (context) => UIModel(
        data: data,
        onUpdate: onUpdate,
        saveAudioRecord: saveAudioRecord,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              JSONSchemaUIField(
                schema: schema,
                ui: ui,
                disabled: disabled,
              ),

              // Button that submit the whole form using global key
              Builder(builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      onSubmit!(data: context.read<UIModel>().data);
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
