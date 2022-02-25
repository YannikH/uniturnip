import 'package:flutter/cupertino.dart';

import 'mapPath.dart';

class ArrayPanel extends StatelessWidget {
  const ArrayPanel(this.path, {Key? key}) : super(key: key);
  
  final MapPath path;

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
  
}