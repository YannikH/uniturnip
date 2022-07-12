import 'package:audio_recorder/audio_recorder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniturnip/json_schema_ui/models/ui_model.dart';
import 'package:uniturnip/json_schema_ui/models/widget_data.dart';
import 'package:uniturnip/json_schema_ui/widgets/widget_ui.dart';

class AudioWidget extends StatelessWidget {
  final WidgetData widgetData;

  const AudioWidget({Key? key, required this.widgetData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String? url = widgetData.uiSchema['ui:options']['default'];
    return WidgetUI(
      title: widgetData.title,
      description: widgetData.description,
      required: widgetData.required,
      child: AudioRecorder(
        url: url,
        onRecorderStop: (filepath) async {
          var storagePath = await context.read<UIModel>().saveAudioRecord!(filepath);
          widgetData.onChange(widgetData.path, storagePath);
        },
      ),
    );
  }
}
