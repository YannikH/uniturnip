import 'package:flutter/material.dart';
import 'package:uniturnip/json_schema_ui/fields/json_schema_dependency.dart';
import 'package:uniturnip/json_schema_ui/fields/json_schema_leaf.dart';
import 'package:uniturnip/json_schema_ui/models/mapPath.dart';
import 'package:uniturnip/json_schema_ui/utils.dart';
import 'package:uniturnip/json_schema_ui/widgets/array_buttons.dart';

class JSONSchemaUIField extends StatelessWidget {
  final Map<String, dynamic> schema;
  final Map<String, dynamic> ui;
  final MapPath path;
  final bool disabled;

  JSONSchemaUIField({
    Key? key,
    required this.schema,
    this.ui = const {},
    MapPath? path,
    this.disabled = false,
    dynamic pointer,
  })  : path = Utils.getPath(path, pointer, schema),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    List fields = Utils.retrieveSchemaFields(
      context: context,
      schema: schema,
      uiSchema: ui,
      path: path,
    );
    String? title = schema['title'];
    String? description = schema['description'];

    if (fields.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (path.isLastObject() || path.isLastArray())
          ObjectHeader(title: title, description: description),
        // TODO: Find out if there are any difference between for loop and listview in terms of optimization
        for (String field in fields)
          ObjectBody(path: path, uiSchema: ui, schema: schema, field: field, disabled: disabled),
        if (path.isLastArray()) ArrayPanel(path),
      ],
    );
  }
}

class ObjectHeader extends StatelessWidget {
  final String? title;
  final String? description;

  const ObjectHeader({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) Text(title!, style: Theme.of(context).textTheme.headline6),
          if (description != null) Text(description!),
          const Divider(height: 10),
        ],
      ),
    );
  }
}

class ObjectBody extends StatelessWidget {
  final Map<String, dynamic> schema;
  final Map<String, dynamic> uiSchema;
  final MapPath path;
  final String field;
  final bool disabled;

  const ObjectBody({
    Key? key,
    required this.schema,
    required this.uiSchema,
    required this.path,
    required this.field,
    required this.disabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> newSchema = schema['properties']?[field] ?? schema['items'] ?? {};
    Map<String, dynamic> newUiSchema = uiSchema[field] ?? uiSchema['items'] ?? {};
    List<dynamic> required = schema['required'] ?? [];
    String schemaType = newSchema['type'] ?? 'not_defined';
    if (schemaType == 'object' || schemaType == 'array') {
      // TODO: Add FixedItemsList handling
      // https://rjsf-team.github.io/react-jsonschema-form/#eyJmb3JtRGF0YSI6eyJsaXN0T2ZTdHJpbmdzIjpbImZvbyIsImJhciJdLCJtdWx0aXBsZUNob2ljZXNMaXN0IjpbImZvbyIsImJhciJdLCJmaXhlZEl0ZW1zTGlzdCI6WyJTb21lIHRleHQiLHRydWUsMTIzXSwibWluSXRlbXNMaXN0IjpbeyJuYW1lIjoiRGVmYXVsdCBuYW1lIn0seyJuYW1lIjoiRGVmYXVsdCBuYW1lIn0seyJuYW1lIjoiRGVmYXVsdCBuYW1lIn1dLCJkZWZhdWx0c0FuZE1pbkl0ZW1zIjpbImNhcnAiLCJ0cm91dCIsImJyZWFtIiwidW5pZGVudGlmaWVkIiwidW5pZGVudGlmaWVkIl0sIm5lc3RlZExpc3QiOltbImxvcmVtIiwiaXBzdW0iXSxbImRvbG9yIl1dLCJ1bm9yZGVyYWJsZSI6WyJvbmUiLCJ0d28iXSwidW5yZW1vdmFibGUiOlsib25lIiwidHdvIl0sIm5vVG9vbGJhciI6WyJvbmUiLCJ0d28iXSwiZml4ZWROb1Rvb2xiYXIiOls0Mix0cnVlLCJhZGRpdGlvbmFsIGl0ZW0gb25lIiwiYWRkaXRpb25hbCBpdGVtIHR3byJdfSwic2NoZW1hIjp7InR5cGUiOiJvYmplY3QiLCJwcm9wZXJ0aWVzIjp7ImZpeGVkSXRlbXNMaXN0Ijp7InR5cGUiOiJhcnJheSIsInRpdGxlIjoiQSBsaXN0IG9mIGZpeGVkIGl0ZW1zIiwiaXRlbXMiOlt7InRpdGxlIjoiQSBzdHJpbmcgdmFsdWUiLCJ0eXBlIjoic3RyaW5nIiwiZGVmYXVsdCI6ImxvcmVtIGlwc3VtIn0seyJ0aXRsZSI6ImEgYm9vbGVhbiB2YWx1ZSIsInR5cGUiOiJib29sZWFuIn1dLCJhZGRpdGlvbmFsSXRlbXMiOnsidGl0bGUiOiJBZGRpdGlvbmFsIGl0ZW0iLCJ0eXBlIjoibnVtYmVyIn19fX0sInVpU2NoZW1hIjp7Imxpc3RPZlN0cmluZ3MiOnsiaXRlbXMiOnsidWk6ZW1wdHlWYWx1ZSI6IiJ9fSwibXVsdGlwbGVDaG9pY2VzTGlzdCI6eyJ1aTp3aWRnZXQiOiJjaGVja2JveGVzIn0sImZpeGVkSXRlbXNMaXN0Ijp7Iml0ZW1zIjpbeyJ1aTp3aWRnZXQiOiJ0ZXh0YXJlYSJ9LHsidWk6d2lkZ2V0Ijoic2VsZWN0In1dLCJhZGRpdGlvbmFsSXRlbXMiOnsidWk6d2lkZ2V0IjoidXBkb3duIn19LCJ1bm9yZGVyYWJsZSI6eyJ1aTpvcHRpb25zIjp7Im9yZGVyYWJsZSI6ZmFsc2V9fSwidW5yZW1vdmFibGUiOnsidWk6b3B0aW9ucyI6eyJyZW1vdmFibGUiOmZhbHNlfX0sIm5vVG9vbGJhciI6eyJ1aTpvcHRpb25zIjp7ImFkZGFibGUiOmZhbHNlLCJvcmRlcmFibGUiOmZhbHNlLCJyZW1vdmFibGUiOmZhbHNlfX0sImZpeGVkTm9Ub29sYmFyIjp7InVpOm9wdGlvbnMiOnsiYWRkYWJsZSI6ZmFsc2UsIm9yZGVyYWJsZSI6ZmFsc2UsInJlbW92YWJsZSI6ZmFsc2V9fX0sInRoZW1lIjoiZGVmYXVsdCIsImxpdmVTZXR0aW5ncyI6eyJ2YWxpZGF0ZSI6ZmFsc2UsImRpc2FibGUiOmZhbHNlLCJyZWFkb25seSI6ZmFsc2UsIm9taXRFeHRyYURhdGEiOmZhbHNlLCJsaXZlT21pdCI6ZmFsc2V9fQ==
      if (newSchema['items'] != null && newSchema['items']['enum'] != null) {
        return JSONSchemaFinalLeaf(
          schema: newSchema['items'],
          ui: newUiSchema.containsKey('items') ? newUiSchema['items'] : newUiSchema,
          pointer: field,
          path: path,
          required: required.contains(field),
          disabled: disabled,
        );
      } else {
        return JSONSchemaUIField(
          schema: newSchema,
          ui: newUiSchema,
          pointer: field,
          path: path,
        );
      }
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          JSONSchemaFinalLeaf(
            schema: newSchema,
            ui: newUiSchema,
            pointer: field,
            path: path,
            required: required.contains(field),
            disabled: disabled,
          ),
          if (schema['dependencies']?[field] != null)
            JSONSchemaDependency(
              schema: schema['dependencies'][field],
              uiSchema: uiSchema,
              path: path,
              pointer: field,
            ),
        ],
      );
    }
  }
}
