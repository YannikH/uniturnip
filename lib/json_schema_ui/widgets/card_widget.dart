import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/ui_model.dart';
import '../models/widget_data.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({Key? key, required this.widgets, required this.schema, this.widgetData}) : super(key: key);

  final Widget widgets;
  final Map schema;
  final WidgetData? widgetData;

  @override
  Widget build(BuildContext context) {
    context.read<UIModel>().initValues(schema);

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
                        context.read<UIModel>().getField();
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