import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ExtractedTextSpan extends StatelessWidget{
  const ExtractedTextSpan({Key? key, required this.wordsAsTextSpan, required this.clickedWord, required this.onPressed}) : super(key: key);

  final List<TextSpan> wordsAsTextSpan;
  final String? clickedWord;
  final Function(String) onPressed;

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            children: wordsAsTextSpan.map((word) =>
                TextSpan(
                    text: word.text,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: (clickedWord == word.text)
                          ? Colors.greenAccent
                          : Colors.black,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        var _clickedWord = word.text;
                        onPressed(word.text!);
                      }
                )).toList())
    );
  }
}