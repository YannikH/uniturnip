import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uniturnip/json_schema_form.dart';

import 'json_schema_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'Flutter Demo oihdsvoihdsfovhj'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
    _schema = {
      "title": "A registration form",
      "description": "A simple form example.",
      "type": "object",
      "required": ["firstName", "lastName"],
      "properties": {
        // "firstName": {
        //   "enum": ["a", "b", "c"],
        //   "type": "string",
        //   "title": "First name",
        //   "default": "Chuck",
        //   "description": "This is field description"
        // },
        "lastName": {"type": "boolean", "title": "Last name"},
        "telephone": {"type": "string", "title": "Telephone", "minLength": 10},
        "obj": {
          "title": "A registration form",
          "description": "A simple form example.",
          "type": "object",
          "required": ["firstName", "lastName"],
          "properties": {
            // "first": {
            //   "enum": ["d", "e", "f"],
            //   "type": "string",
            //   "title": "First name",
            //   "default": "Chuck",
            //   "description": "This is field description"
            // },
            "lastName": {"type": "boolean", "title": "Last name"},
            "telephone": {
              "type": "string",
              "title": "Telephone",
              "minLength": 10
            }
          }
        }
      }
    };
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
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
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

  Map<String, dynamic> _modifyData(
      List<String> path, Map<String, dynamic> data, dynamic value) {
    if (path.isNotEmpty) {
      if (path.length > 1) {
        String field = path.removeAt(0);
        data[field] ??= {};
        _modifyData(path, data[field].cast<String, dynamic>(), value);
      } else {
        data[path.first] = value;
      }
    }
    return data;
  }

  void _updateData(
      {dynamic data, required String field, required List<String> path}) {
    // print('data: $data');
    // print('field: $field');
    // print('path: $path');
    Map<String, dynamic> newData = {..._data};
    List<String> newPath = [...path];
    setState(() {
      _data = _modifyData(newPath, newData, data);
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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
          bottom: TabBar(
            controller: _tabController,
            tabs: myTabs,
          )),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
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
                      onTap: () => print("Click click $index"),
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
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
