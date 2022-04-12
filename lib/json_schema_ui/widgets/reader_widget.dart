import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/ui_model.dart';
import '../models/widget_data.dart';

class ReaderWidget extends StatelessWidget {
  const ReaderWidget({Key? key, required this.widgetData}) : super(key: key);

  final WidgetData widgetData;

  @override
  Widget build(BuildContext context) {
    var text = widgetData.schema['title'];
    context.read<UIModel>().getTextAsList(text);
    context.read<UIModel>().getTextSpan(widgetData, context);
    var textList = context.watch<UIModel>().textList;
    var sentenceAsTextSpan = context.watch<UIModel>().sentenceAsTextSpan;
    var sentenceAsString = context.watch<UIModel>().sentenceAsString;
    var clickedWord = context.watch<UIModel>().clickedWord;
    var translation = context.watch<UIModel>().translation;

    return Column(
      children: [
        Container(
            padding: const EdgeInsets.all(16.0),
            child: RichText(
                text: sentenceAsTextSpan)),
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              (textList.indexOf(sentenceAsString) == 0)
                  ? Container() :
                  Container(
                    color: Colors.grey,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        context.read<UIModel>().updateText(false);
                        context.read<UIModel>().getTextSpan(widgetData, context);
                      })),
              (textList.indexOf(sentenceAsString) == textList.length - 1)
                  ? Container() :
                  Container(
                    color: Colors.grey,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        context.read<UIModel>().updateText(true);
                        context.read<UIModel>().getTextSpan(widgetData, context);
                      })),
            ],
          ),
        ),
        clickedWord.isEmpty
            ? Container()
            : Container(
              padding: const EdgeInsets.all(16.0),
              child: ListTile(
                title: Text(
                  "$clickedWord: $translation",
                  style: const TextStyle(fontSize: 20.0),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    context.read<UIModel>().hideClickedWord();
                  }),
              ),
            ),
      ],
    );
  }
}
