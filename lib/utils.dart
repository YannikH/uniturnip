class Utils {

  static Map<String, dynamic> modifyMapByPath(
    List<String> path,
    Map<String, dynamic> data,
    dynamic value) {

    path = [...path];
    data = {...data};

    return _modifyMapByPath(path, data, value);
  }

  static Map<String, dynamic> _modifyMapByPath(
      List<String> path,
      Map<String, dynamic> data,
      dynamic value) {
    if (path.isNotEmpty) {
      if (path.length > 1) {
        String field = path.removeAt(0);
        data[field] ??= {};
        _modifyMapByPath(
            path,
            data[field].cast<String, dynamic>(),
            value);
      } else {
        data[path.first] = value;
      }
    }
    return data;
  }
}