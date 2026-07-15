import 'package:artriapp/models/api_responses/exercise.dart';
import 'package:artriapp/utils/enums/training_type_enum.dart';

class ExerciseListByType {
  List<Exercise> exerciseList = [];
  TrainingType type;

  ExerciseListByType({required this.exerciseList, required this.type});
}