import 'package:flutter/material.dart';

// TODO: Implement UpDownWidget
class UpDownWidget extends StatefulWidget {
  const UpDownWidget({Key? key}) : super(key: key);

  @override
  State<UpDownWidget> createState() => _UpDownWidgetState();
}

class _UpDownWidgetState extends State<UpDownWidget> {
  int page = 1;

  final _controller = PageController();
  List<Widget> widgets = [ // list of pages I'll be scrolling through
    Center(child: Text("Page 1", style: TextStyle(fontSize: 50))),
    Center(child: Text("Page 2", style: TextStyle(fontSize: 50))),
    Center(child: Text("Page 3", style: TextStyle(fontSize: 50))),
    Center(child: Text("Page 4", style: TextStyle(fontSize: 50))),
    Center(child: Text("Page 5", style: TextStyle(fontSize: 50))),
  ];
  @override
  Widget build(BuildContext context) {
  return Scaffold(
      body: PageView(
        children: widgets, // set 'children' to the list of pages
        scrollDirection: Axis.vertical, // Set the Axis to the desired direction.
        controller: _controller, // set this to the controller
        onPageChanged: (num) { // what will happen when you switch
          setState(() { // Update state
            page = num; // Set the page we're on to the num argument
  });
  }));
  }

  }



