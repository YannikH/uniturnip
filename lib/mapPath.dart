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

  MapPath add(String type, dynamic pointer) {
    List<PathStep> steps = [..._steps];
    StepType stepType = StepType.leaf;
    if (type == 'object') {
      stepType = StepType.object;
    } else if (type == 'array') {
      stepType = StepType.array;
    }
    steps.add(PathStep(stepType, pointer));
    return MapPath(steps: steps);
  }

  MapPath removeAt(int index) {
    List<PathStep> steps = [..._steps];
    steps.removeAt(index);
    return MapPath(steps: steps);
  }

  bool isLastArray() {
    return _steps.isNotEmpty ? _steps.last.type == StepType.array : false;
  }

  bool isLastObject() {
    return _steps.isNotEmpty ? _steps.last.type == StepType.object : false;
  }

  bool isLastLeaf() {
    return _steps.isNotEmpty ? _steps.last.type == StepType.leaf : false;
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

enum StepType {object, array, leaf}