import 'package:audio_recorder/audio_recorder.dart';
import 'package:flutter/material.dart';
import 'package:uniturnip/json_schema_ui/models/widget_data.dart';

class AudioWidget extends StatelessWidget {
  final WidgetData widgetData;

  const AudioWidget({Key? key, required this.widgetData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AudioRecorder(
      // url: 'https://flutter-sound.canardoux.xyz/web_example/assets/extract/06.mp4',
      onRecorderStop: (path) {
        print(path);
      },
    );
  }
}
