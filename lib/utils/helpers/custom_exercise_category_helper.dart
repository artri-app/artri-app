import 'package:artriapp/utils/enums/index.dart';
import 'package:artriapp/utils/helpers/difficulty_helper.dart';

class CustomExerciseCategoryHelper {
  static const List<TrainingType> categories = [
    TrainingType.mobility,
    TrainingType.aerobic,
    TrainingType.inferiorBoost,
    TrainingType.superiorBoost,
    TrainingType.coreBoost,
    TrainingType.stretching,
  ];

  static String getPrefixText(TrainingType type) {
    switch (type) {
      case TrainingType.inferiorBoost:
        return 'Escolha x exercícios para as';
      case TrainingType.superiorBoost:
        return 'Escolha x exercícios para os';
      case TrainingType.coreBoost:
        return 'Escolha x exercícios para o';
      default:
        return 'Escolha x exercícios de';
    }
  }

  static String getCategoryName(TrainingType type) {
    switch (type) {
      case TrainingType.mobility:
        return 'mobilidade';
      case TrainingType.aerobic:
        return 'aquecimento';
      case TrainingType.inferiorBoost:
        return 'pernas';
      case TrainingType.superiorBoost:
        return 'braços';
      case TrainingType.coreBoost:
        return 'tronco';
      case TrainingType.stretching:
        return 'alongamento';
      default:
        return '';
    }
  }

  static String getSelectionInstructionPrefix(TrainingType type) {
    switch (type) {
      case TrainingType.inferiorBoost:
        return 'Selecione os exercícios para as';
      case TrainingType.superiorBoost:
        return 'Selecione os exercícios para os';
      case TrainingType.coreBoost:
        return 'Selecione os exercícios para o';
      default:
        return 'Selecione os exercícios de';
    }
  }

  // Precisa bater com o padrão de nome gerado pelo seed_banco.py:
  // 'EXERCÍCIO PERSONALIDADO - {DIFICULDADE} - {CATEGORIA}'.
  static String getTrainingName(
    TrainingType type,
    ExerciseDifficulty difficulty,
  ) {
    final difficultyLabel =
        DifficultyHelper.getDifficultyText(difficulty.toString())
                ?.toUpperCase() ??
            '';

    return 'EXERCÍCIO PERSONALIDADO - $difficultyLabel - '
        '${getCategoryName(type).toUpperCase()}';
  }
}
