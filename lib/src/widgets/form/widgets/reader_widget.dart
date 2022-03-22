import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class TextReader extends StatefulWidget {
  const TextReader({Key? key}) : super(key: key);

  @override
  _TextReaderState createState() => _TextReaderState();
}

class _TextReaderState extends State<TextReader> {
  String text = 'A child and his father were visiting an elderly neighbor. They were raking the neighbors leaves, organizing the neighbors garage, putting the trash out, and performing other small jobs around the neighbors house. The child had not really seen the elderly neighbor up close, but on this day the child was going to meet the neighbor up close for the first time. When the child met the neighbor up close he asked the neighbor how old he was, and the father was flabbergasted by his childs question and attempted to apologize to the neighbor, but the neighbor laughed and said that was ok, the child is curious. The elderly neighbor told the child he was 92 years old. The child had a look of unbelief and asked the neighbor, "Did you start at the number one?"';
  List<String> textList = [];
  String sentence = '';
  String clickedWord = '';
  int counter = 0;

  @override
  void initState() {
    super.initState();
    textList = text.split('.');
    sentence = textList[0];
    getTextSpan();
  }

  updateText(bool value) {
    setState(() {
      if (value) {
        counter++;
        if (counter < textList.length) {
          sentence = textList[counter];
          getTextSpan();
        }
      } else {
        counter--;
        if (counter >= 0) {
          sentence = textList[counter];
          getTextSpan();
        }
      }
    });
  }

  TextSpan getTextSpan() {
    final arrayStrings = sentence.split(" ");
    List<TextSpan> arrayOfTextSpan = [];
    late TextSpan textSpan;

    for (int index = 0; index < arrayStrings.length; index++) {
      arrayOfTextSpan.add(TextSpan(text: arrayStrings[index] + ' '));
    }

    textSpan = TextSpan(
        children: arrayOfTextSpan
            .map((e) => TextSpan(
            text: e.text,
            style: TextStyle(
              fontSize: 20.0,
              color: (clickedWord == e.text) ? Colors.greenAccent : Colors.black,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                setState(() {
                  clickedWord = e.text!;
                  getTextSpan();
                });
              }))
            .toList());
    return textSpan;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('English OkuTool'),
      ),
      body: Column(
        children: [
          Container(
              padding: const EdgeInsets.all(16.0),
              child: RichText(text: getTextSpan())),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                (textList.indexOf(sentence) == 0) ? Container() : Container(
                    color: Colors.grey,
                    child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          updateText(false);
                          clickedWord = '';
                        })),
                (textList.indexOf(sentence) == textList.length - 1) ? Container() : Container(
                    color: Colors.grey,
                    child: IconButton(
                        icon: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          updateText(true);
                          clickedWord = '';
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
                  setState(() {
                    clickedWord = '';
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}