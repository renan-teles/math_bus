import 'exercise_config.dart';
import 'basic/operation.dart';

abstract interface class Exercise {
  bool next(ExerciseConfig config);

  double getCorrectAnswer();
  List<int> getOperands();

  Operation getOperation();
}
