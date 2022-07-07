import 'package:flutter/material.dart';
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
            ? GestureDetector(
                child: Container(
                  child: Hero(
                    child: Image.network(imageList[0]),
                    tag: 'name',
                  ),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              )
            : SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (ctx, i) => GestureDetector(
                      child: Container(
                        child: Image.network(imageList[i]),
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    itemCount: imageList.length,
                  ),
              ),
        /* Vertical */
        // ListView.builder(
        //     itemBuilder: (ctx, i) => GestureDetector(
        //         child: Container(
        //       child: Image.network(imageList[i]),
        //       height: MediaQuery.of(context).size.height,
        //       width: MediaQuery.of(context).size.width,
        //     ),
        //       onTap: (){
        //           Navigation.pop(context);
        //       },
        //     ),
        //     itemCount: imageList.length,
        //   ),
        );
  }
}
