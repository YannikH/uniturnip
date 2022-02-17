import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uniturnip/json_schema_form.dart';
import 'package:uniturnip/schemas.dart';
import 'package:uniturnip/utils.dart';

import 'json_schema_ui.dart';

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
      home: const MyHomePage(title: 'Flutter Demo oihdsvoihdsfovhj'),
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
  int _counter = 0;
  bool _decrement = false;
  List<int> _elements = [];
  Color _color = Colors.red;

  Map<String, dynamic> _data = const {};
  String _field = '';
  List<String> _path = [];

  final List<Tab> myTabs = <Tab>[
    const Tab(icon: Icon(Icons.edit)),
    const Tab(icon: Icon(Icons.done_all)),
    const Tab(icon: Icon(Icons.emoji_objects))
  ];

  late TabController _tabController;

  late Map<String, dynamic> _schema;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);

    _tabController.addListener(_handleTabSelection);
    _schema = Schemas.demoNested;
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      switch (_tabController.index) {
        case 0:
          setState(() {
            _color = Colors.red;
          });
          break;
        case 1:
          setState(() {
            _color = Colors.blue;
          });
          break;
        case 2:
          setState(() {
            _color = Colors.green;
          });
          break;
      }
    }
  }

  void _incrementCounter() {
    setState(() {
      _counter = _decrement ? _counter - 1 : _counter + 1;
    });
  }

  void _changeMode() {
    setState(() {
      _decrement = !_decrement;
    });
  }

  void _addElement() {
    setState(() {
      _elements.add(_counter);
    });
  }

  void _incrementAdd() {
    _incrementCounter();
    _addElement();
  }

  void _updateData(
      {dynamic data, required String field, required List<String> path}) {
    setState(() {
      _data = Utils.modifyMapByPath(path, _data, data);
      _field = field;
      _path = path;
    });
  }

  void _updateSchema({required Map<String, dynamic> schema}) {
    setState(() {
      _schema = schema;
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            ElevatedButton(
                onPressed: _changeMode,
                child: Text(_decrement ? 'Increment' : 'Decrement')),
            ListView.builder(
                padding: const EdgeInsets.all(8),
                shrinkWrap: true,
                itemCount: _elements.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                      child: Ink(
                          height: 50,
                          color: _color,
                          child: Center(
                              child: Text(_elements[index].toString()))));
                }),
            JSONSchemaUI(schema: _schema, onUpdate: _updateData, data: _data),
            Text('Data: $_data \n Field: $_field \n Path: $_path'),
            TextFormField(
                onChanged: (val) => _updateSchema(schema: json.decode(val)),
                decoration: const InputDecoration(labelText: 'SCHEMA'),
                keyboardType: TextInputType.multiline,
                maxLines: null
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementAdd,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
