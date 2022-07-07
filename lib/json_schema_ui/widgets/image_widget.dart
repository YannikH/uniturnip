import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:uniturnip/json_schema_ui/widgets/widget_ui.dart';
import '../../../../json_schema_ui/models/widget_data.dart';

class ImageWidget extends StatelessWidget {
  ImageWidget({Key? key, required this.widgetData}) : super(key: key);

  final WidgetData widgetData;

  @override
  Widget build(BuildContext context) {
    String title = widgetData.schema['title'] ?? '';
    String description = widgetData.schema['description'] ?? '';
    final List<String> imageList = widgetData.uiSchema['images'];

    return WidgetUI(
      title: title,
      description: description,
      child: imageList.length == 1
          ? FullScreenWidget(child: Image.network(imageList[0]))
          : FullScreenWidget(
            child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, i) => Image.network(imageList[i]),
                  itemCount: imageList.length,
                ),
              ),
          ),
            /* Vertical */
            // FullScreenWidget(
            //   child: ListView.builder(
            //     itemBuilder: (ctx, i) => Image.network(imageList[i]),
            //     itemCount: imageList.length,
            //   ),
            // )
    );
  }
}
