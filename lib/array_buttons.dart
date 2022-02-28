import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniturnip/ui_model.dart';

import 'mapPath.dart';

class ArrayPanel extends StatelessWidget {
  const ArrayPanel(this.path, {Key? key}) : super(key: key);
  
  final MapPath path;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(onPressed: () => onUpdate(context, path), child: const Text('+')),
        ElevatedButton(onPressed: () => print('- pressed'), child: const Text('-')),
      ],
    );
  }

  void onUpdate(BuildContext context, MapPath path) {
    Provider.of<UIModel>(context, listen: false).addArrayElement(path);
  }
}