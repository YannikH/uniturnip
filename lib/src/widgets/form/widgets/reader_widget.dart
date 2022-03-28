import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniturnip/src/widgets/form/models/widget_data.dart';
import '../../../../ui_model.dart';

class ReaderWidget extends StatelessWidget {
  const ReaderWidget({Key? key, required this.widgetData}) : super(key: key);

  final WidgetData widgetData;

  @override
  Widget build(BuildContext context) {
    var sentence = widgetData.schema['title'];
    var clickedWord = context.watch<UIModel>().clickedWord;

    return Column(
        children: [
          Container(
              padding: const EdgeInsets.all(16.0),
              child: RichText(text: context.watch<UIModel>().getTextSpan(sentence, widgetData, context))),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /*(controller.textList.indexOf(sentence) == 0) ? Container() :*/ Container(
                    color: Colors.grey,
                    child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          // initState();
                          // updateText(false);
                          // clickedWord = '';
                        })),
                /*(textList.indexOf(sentence) == textList.length - 1) ? Container() :*/ Container(
                  color: Colors.grey,
                  child: IconButton(
                      icon: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        // updateText(true);
                        // clickedWord = '';
                      }),
                ),
              ],
            ),
          ),
          clickedWord.isEmpty ? Container() : Container(
            padding: const EdgeInsets.all(16.0),
            child: ListTile(
              title: Text(
                clickedWord,
                style: const TextStyle(fontSize: 20.0),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  context.read<UIModel>().hideClickedWord();
                },
              ),
            ),
          ),
        ],
    );
  }

}

