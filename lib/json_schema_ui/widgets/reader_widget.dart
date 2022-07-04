import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/ui_model.dart';
import '../models/widget_data.dart';

class ReaderWidget extends StatelessWidget {
  const ReaderWidget({Key? key, required this.widgetData}) : super(key: key);

  final WidgetData widgetData;

  @override
  Widget build(BuildContext context) {
    context.read<UIModel>().setData(widgetData.value);
    context.read<UIModel>().getSentenceAsList();
    context.read<UIModel>().getTextSpan(widgetData, context);
    var sentenceAsTextSpan = context.watch<UIModel>().sentenceAsTextSpan;
    var clickedWord = context.watch<UIModel>().clickedWord;
    var translation = context.watch<UIModel>().translation;
    var clickedWordList = context.watch<UIModel>().clickedWordList;
    var translationList = context.watch<UIModel>().translationList;

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
                  Container(
                    color: Colors.grey,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        //context.read<UIModel>().updateText(false);
                        //context.read<UIModel>().getTextSpan(widgetData, context);
                      })),
                  Container(
                    color: Colors.grey,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        //context.read<UIModel>().updateText(true);
                        // context.read<UIModel>().getTextSpan(widgetData, context);
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
        clickedWordList.isEmpty
            ? Container()
            : Container(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                itemCount: clickedWordList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Text("${clickedWordList[index]}: ${translationList[index]}", style: const TextStyle(fontSize: 20));
                }
              ),
            )
      ],
    );
  }
}
