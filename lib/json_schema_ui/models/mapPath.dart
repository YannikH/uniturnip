import 'dart:collection';

class MapPath {
  MapPath({
    List<PathStep> steps = const [],
  }) : _steps = steps;

  final List<PathStep> _steps;

  @override
  String toString() {
    return _steps.toString();
  }

  UnmodifiableListView<PathStep> get steps =>
      UnmodifiableListView<PathStep>(_steps);

  /// добавляет поле(properties)
  MapPath add(String type, dynamic pointer) {
    List<PathStep> steps = [..._steps];
    StepType stepType = StepType.object;
    if (type == 'object') {
      stepType = StepType.object;
    } else if (type == 'array') {
      stepType = StepType.array;
    }
    steps.add(PathStep(stepType, pointer));
    return MapPath(steps: steps);
  }

  /// удаляет по индексу поле(properties), добавленное в steps
  MapPath removeAt(int index) {
    List<PathStep> steps = [..._steps];
    steps.removeAt(index);
    return MapPath(steps: steps);
  }

  /// удаляет последнее поле(properties), добавленное в steps
  MapPath removeLast() {
    List<PathStep> steps = [..._steps];
    steps.removeAt(steps.length - 1);
    return MapPath(steps: steps);
  }

  /// если тип поля array
  bool isLastArray() {
    return _steps.isNotEmpty ? _steps.last.type == StepType.array : false;
  }
  /// если тип поля object
  bool isLastObject() {
    return _steps.isNotEmpty ? _steps.last.type == StepType.object : false;
  }

}

class PathStep {
  PathStep(this.type, this.pointer);

  @override
  String toString() {
    return '$pointer';
  }

  final StepType type;
  final dynamic pointer;
}

enum StepType {object, array}