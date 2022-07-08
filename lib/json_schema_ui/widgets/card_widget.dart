import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/ui_model.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({Key? key, required this.widgets, required this.schema}) : super(key: key);

  final Widget widgets;
  final Map schema;

  @override
  Widget build(BuildContext context) {
    context.read<UIModel>().getNumOfCards(schema);

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
                        context.read<UIModel>().getCard();
                      })),
            ]
        )
    );
  }
}