import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/ui_model.dart';
import '../models/widget_data.dart';

class LearnerWidget extends StatelessWidget {
  const LearnerWidget({Key? key, required this.widgetData, required this.widgets}) : super(key: key);

  final WidgetData widgetData;
  final Widget widgets;

  @override
  Widget build(BuildContext context) {
    context.read<UIModel>().initValues(widgetData);

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.center,
            width: 350.0,
            color: Colors.blueGrey,
            child: widgets,
          ),
          const SizedBox(
            width: 16.0,
          ),
          Container(
            padding: const EdgeInsets.all(4.0),
              color: Colors.blueGrey,
              child: IconButton(
                  icon: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    context.read<UIModel>().getNextField();
                  })),
        ]
      )
    );

    // return Center(
    //   child:  GestureDetector(
    //     onTap: () {
    //       context.read<UIModel>().getNextField();
    //     },
    //     child: Container(
    //       padding: EdgeInsets.all(16.0),
    //       alignment: Alignment.center,
    //       width: 500.0,
    //       color: Colors.blueGrey,
    //       child: widgets,
    //     )
    //   ),
    // );
  }
}