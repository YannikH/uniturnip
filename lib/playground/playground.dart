import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:uniturnip/json_schema_ui/examples/schemas.dart';
import 'package:uniturnip/json_schema_ui/json_schema_ui.dart';
import 'package:uniturnip/json_schema_ui/models/mapPath.dart';
import 'package:uniturnip/json_schema_ui/models/ui_model.dart';
import 'package:uniturnip/playground/adaptiveLayout.dart';

class Playground extends StatefulWidget {
  const Playground({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Playground> createState() => _PlaygroundState();
}

class _PlaygroundState extends State<Playground> with SingleTickerProviderStateMixin {
  Map<String, dynamic> _data = const {};
  String _path = '';

  final List<Tab> myTabs = <Tab>[
    const Tab(icon: Icon(Icons.edit)),
    const Tab(icon: Icon(Icons.done_all)),
    const Tab(icon: Icon(Icons.emoji_objects))
  ];

  late TabController _tabController;

  late List<Map<String, dynamic>> _schemas;
  late Map<String, dynamic> _schema;
  late Map<String, dynamic> _ui;

  TextEditingController textControl = TextEditingController();
  TextEditingController formControl = TextEditingController();
  TextEditingController uiControl = TextEditingController();
  UIModel formController = UIModel();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
    int defaultPage = 4;
    _tabController.addListener(_handleTabSelection);
    _schemas = Schemas.schemas;
    _schema = Schemas.schemas[defaultPage]['schema'];
    _ui = Schemas.schemas[defaultPage]['ui'];
    _data = Schemas.schemas[defaultPage]['formData'];
    formControl.text = JsonEncoder.withIndent(' ' * 4).convert(_schema);
    uiControl.text = JsonEncoder.withIndent(' ' * 4).convert(_ui);
    textControl.text = JsonEncoder.withIndent(' ' * 4).convert(_data);
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      switch (_tabController.index) {
        case 0:
          setState(() {});
          break;
        case 1:
          setState(() {});
          break;
        case 2:
          setState(() {});
          break;
      }
    }
  }

  void _setSchema(int index) {
    setState(() {
      _schema = _schemas[index]['schema'];
      _ui = _schemas[index]['ui'];
      _data = {..._schemas[index]['formData']};
      formControl.text = JsonEncoder.withIndent(' ' * 4).convert(_schema);
      uiControl.text = JsonEncoder.withIndent(' ' * 4).convert(_ui);
      textControl.text = JsonEncoder.withIndent(' ' * 4).convert(_data);
    });
  }

  void _updateSchema({required Map<String, dynamic> schema}) {
    setState(() {
      _schema = schema;
    });
  }

  void _updateUi({required Map<String, dynamic> ui}) {
    setState(() {
      _ui = ui;
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.title),
          bottom: TabBar(
            controller: _tabController,
            tabs: myTabs,
          )),
      drawer: Drawer(
        child: ListView.builder(
          // Important: Remove any padding from the ListView.
          controller: ScrollController(),
          padding: EdgeInsets.zero,
          itemCount: _schemas.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(_schemas[index]['label']),
              onTap: () =>  _setSchema(index),
            );
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Form(
                child:JSONSchemaUI(
                      schema: _schema,
                      ui: _ui,
                      onUpdate: _updateDataAndPath,
                      data: _data,
                      controller: formController,
                    ),
              ),
              // Text('Data: $_data \n Path: $_path'),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(border: Border.all()),
                      height: 500,
                      child: TextFormField(
                          // initialValue: JsonEncoder.withIndent(' ' * 4).convert(_schema),
                          controller: formControl,
                          onChanged: (val) => _updateSchema(schema: json.decode(val)),
                          decoration: const InputDecoration(labelText: 'SCHEMA'),
                          keyboardType: TextInputType.multiline,
                          maxLines: null),
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(border: Border.all()),
                          height: 500,
                          child: TextFormField(
                              // initialValue: JsonEncoder.withIndent(' ' * 4).convert(_ui),
                              controller: uiControl,
                              onChanged: (val) => _updateUi(ui: json.decode(val)),
                              decoration: const InputDecoration(labelText: 'UI'),
                              keyboardType: TextInputType.multiline,
                              maxLines: null),
                        )),
                        Expanded(
                            child: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(border: Border.all()),
                          height: 500,
                          child: TextFormField(
                              // initialValue: JsonEncoder.withIndent(' ' * 4).convert(_data),
                              controller: textControl,
                              onChanged: (val) => formController.data = json.decode(val),
                              decoration: const InputDecoration(labelText: 'DATA'),
                              keyboardType: TextInputType.multiline,
                              maxLines: null),
                        )),
                      ],
                    )
                  ],
                ),
              ),
            ],
          )
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }

  void _updateDataAndPath({required Map<String, dynamic> data, required MapPath path}) {
    textControl.text = JsonEncoder.withIndent(' ' * 4).convert(formController.data);
    // setState(() {
    //   _data = data;
    // });
  }
}
