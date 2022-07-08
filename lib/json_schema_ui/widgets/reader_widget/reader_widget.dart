import 'package:flutter/material.dart';
import 'package:uniturnip/json_schema_ui/widgets/reader_widget/extracted_text_span.dart';
import '../../models/widget_data.dart';

class ReaderWidget extends StatefulWidget {
  const ReaderWidget({Key? key, required this.widgetData}) : super(key: key);

  final WidgetData widgetData;

  @override
  State<ReaderWidget> createState() => _ReaderWidgetState();
}

class _ReaderWidgetState extends State<ReaderWidget> {
  String _clickedWord = '';
  String get clickedWord => _clickedWord;

  String _translation = '';
  String get translation => _translation;

  final List<String> _words = [];
  List<String> get words => _words;

  List<Map<String, dynamic>> _formData = [];
  List<Map<String, dynamic>> get formData => _formData;

  int _index = 0;
  int get index => _index;

  final List<String> _clickedWords = [];
  List<String> get clickedWords => _clickedWords;

  final List<String> _translations = [];
  List<String> get translations => _translations;

  List<Map<String, dynamic>> _formDataAsList = [];
  List<Map<String, dynamic>> get formDataAsList => _formDataAsList;

  final List<TextSpan> _wordsAsTextSpan = [];
  List<TextSpan> get wordsAsTextSpan => _wordsAsTextSpan;

  @override
  void initState() {
    super.initState();
    updateData();
  }

  void updateData() {
    /// получаем в виде списка данные текста из formData
    _formData = widget.widgetData.value;

    /// получаем список всех слов текста (words)
    words.clear();
    for (var map in formData) {
      _words.add(map['word']);
    }

    /// все слова из списка words оборачиваем виджетом TextSpan
    for (int index = 0; index < words.length; index++) {
      _wordsAsTextSpan.add(TextSpan(text: words[index] + ' '));
    }
  }

  setOnTapChanges(String word) {
    _clickedWord = word;
    getTranslate();
    increaseCount();
    getClickedWords();
  }

  void hideClickedWord() {
    setState(() {
      _clickedWord = '';
    });
  }

  void getTranslate() {
    /// убираем лишний пробел в конце слова
    var wordWithoutSpace = clickedWord.substring(0, clickedWord.length - 1);

    /// находим под каким индексом находится нажатое слово в списке всех слов
    _index = words.indexOf(wordWithoutSpace);

    /// получаем перевод нажатого слова
    _translation = formData[index]['translation'];
  }

  void increaseCount() {
    Map<String, dynamic> clickedWordProperties;

    /// из formData получаем данные текста с измененными значениями свойств
    _formData = widget.widgetData.value;

    /// копируем эти данные для внесения новых изменений
    _formDataAsList = List.from(formData);

    /// по индексу получаем свойства нажатого слова
    clickedWordProperties = {...formData[index]};

    /// при каждом нажатии на слово, свойство count этого слова увеличивается на один
    clickedWordProperties['count'] = clickedWordProperties['count'] + 1;

    /// если слово нажато один раз, то свойство active становится true
    if (clickedWordProperties['count'] == 1) {
      clickedWordProperties['active'] = true;
    }

    /// заменяем в схеме изменившиеся свойства
    _formDataAsList.removeAt(index);
    _formDataAsList.insert(index, clickedWordProperties);
    widget.widgetData.onChange(context, widget.widgetData.path, formDataAsList);
  }

  /// добавляем нажатые слова по очереди в список для отображения в UI
  void getClickedWords() {
    if (!clickedWords.contains(clickedWord) &&
        !translations.contains(translation)) {
      _clickedWords.add(clickedWord);
      _translations.add(translation);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Container(
            padding: const EdgeInsets.all(16.0),
            child: ExtractedTextSpan(
                wordsAsTextSpan: wordsAsTextSpan,
                clickedWord: clickedWord,
                onPressed: (word) => setOnTapChanges(word))),
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //(textList.indexOf(sentenceAsString) == 0) ? Container() :
              Container(
                  color: Colors.grey,
                  child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        // TODO: Add the method to get the previous sentence
                      })),
              //(textList.indexOf(sentenceAsString) == textList.length - 1) ? Container() :
              Container(
                  color: Colors.grey,
                  child: IconButton(
                      icon: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        // TODO: Add the method to get the next sentence
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
                      hideClickedWord();
                    }))),
        clickedWords.isEmpty
            ? Container()
            : Container(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                itemCount: clickedWords.length,
                itemBuilder: (BuildContext context, int index) {
                  return Text(
                      "${clickedWords[index]}: ${translations[index]}",
                      style: const TextStyle(fontSize: 20));
                }))
      ],
    );
  }
}