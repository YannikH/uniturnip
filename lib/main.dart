import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uniturnip/json_schema_ui/models/mapPath.dart';
import 'package:uniturnip/json_schema_ui/examples/schemas.dart';
import 'package:uniturnip/json_schema_ui/models/ui_model.dart';

import 'json_schema_ui/json_schema_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'asdasd',),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  Map<String, dynamic> _data = const {};
  String _path = '';

  final List<Tab> myTabs = <Tab>[
    const Tab(icon: Icon(Icons.edit)),
    const Tab(icon: Icon(Icons.done_all)),
    const Tab(icon: Icon(Icons.emoji_objects))
  ];

  late TabController _tabController;

  late Map<String, dynamic> _schema;
  late Map<String, dynamic> _ui;

  TextEditingController textControl = TextEditingController();
  UIModel formController = UIModel();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);

    _tabController.addListener(_handleTabSelection);
    _schema = Schemas.demoNested;
    _ui = Schemas.demoUi;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.title),
          bottom: TabBar(
            controller: _tabController,
            tabs: myTabs,
          )),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              JSONSchemaUI(
                  schema: _schema,
                  ui: _ui,
                  onUpdate: _updateDataAndPath,
                  data: _data,
                controller: formController,),
              Text('Data: $_data \n Path: $_path'),
              TextFormField(
                  initialValue: JsonEncoder.withIndent(' ' * 4).convert(_schema),
                  onChanged: (val) => _updateSchema(schema: json.decode(val)),
                  decoration: const InputDecoration(labelText: 'SCHEMA'),
                  keyboardType: TextInputType.multiline,
                  maxLines: null),
              Row(children: [
                Expanded(child:
                  TextFormField(
                    initialValue: JsonEncoder.withIndent(' ' * 4).convert(_ui),
                    onChanged: (val) => _updateUi(ui: json.decode(val)),
                    decoration: const InputDecoration(labelText: 'UI'),
                    keyboardType: TextInputType.multiline,
                    maxLines: null)
                ),
                Expanded(child:
                TextFormField(
                    // initialValue: JsonEncoder.withIndent(' ' * 4).convert(_data),
                    controller: textControl,
                    onChanged: (val) => formController.data = json.decode(val),
                    decoration: const InputDecoration(labelText: 'DATA'),
                    keyboardType: TextInputType.multiline,
                    maxLines: null)
                ),

              ],)
            ],
          )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _updateDataAndPath({required Map<String, dynamic> data, required MapPath path}) {
    textControl.text = JsonEncoder.withIndent(' ' * 4).convert(formController.data);
    // setState(() {
    //   _data = data;
    // });
  }
}
